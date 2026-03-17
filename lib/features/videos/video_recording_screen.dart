import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/video_preview_screen.dart';
import 'package:tiktok_clone/features/videos/widgets/flash_mode_button.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin {
  bool _hasPermission = false;
  bool _deniedPermission = false;

  bool _isSelfieMode = false;
  late FlashMode _flashMode;

  late CameraController _cameraController;
  late final AnimationController _buttonAnimationController =
      AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
      );

  late final AnimationController _progressAnimationController =
      AnimationController(
        vsync: this,
        duration: const Duration(
          seconds: 10,
        ),
        lowerBound: 0.0,
        upperBound: 1.0,
      );

  Future<void> _initPermission() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    if (!mounted) return;

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (cameraDenied || micDenied) {
      _deniedPermission = true;
      setState(() {});
    } else {
      _hasPermission = true;
      await _initCamera();
    }
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        return;
      }
      _cameraController = CameraController(
        cameras[_isSelfieMode ? 1 : 0],
        ResolutionPreset.ultraHigh,
      );

      await _cameraController.initialize();
      await _cameraController.prepareForVideoRecording();

      _flashMode = _cameraController.value.flashMode;
      setState(() {});
    } on CameraException catch (e) {
      debugPrint("Camera error: ${e.code} ${e.description}");
    }
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await _initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  late final Animation<double> _buttonAnimation = Tween(
    begin: 1.0,
    end: 1.3,
  ).animate(_buttonAnimationController);

  Future<void> _startRecording(TapDownDetails _) async {
    if (_buttonAnimationController.isAnimating ||
        _progressAnimationController.isAnimating) {
      return;
    }

    if (_cameraController.value.isRecordingVideo) return;

    await _cameraController.startVideoRecording();

    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;

    _buttonAnimationController.reverse();
    _progressAnimationController.reset();

    final XFile video = await _cameraController.stopVideoRecording();

    if (!mounted) return;

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: false,
        ),
      ),
    );
  }

  Future<void> _onPickVideoPressed() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (video == null) return;

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: true,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initPermission();
    _progressAnimationController.addListener(
      () {
        setState(() {});
      },
    );
    _progressAnimationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _stopRecording();
        }
      },
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _buttonAnimationController.dispose();
    _progressAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: _deniedPermission
              ? CupertinoAlertDialog(
                  title: const Text(
                    "Please check the following permissions:\n\n- camera\n- microphone",
                  ),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () {},
                      child: const Text(
                        "OK",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                )
              : !_hasPermission || !_cameraController.value.isInitialized
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Stack(
                  alignment: AlignmentGeometry.center,
                  children: [
                    CameraPreview(_cameraController),
                    Positioned(
                      top: Sizes.size10,
                      left: Sizes.size10,
                      child: Column(
                        children: [
                          IconButton(
                            color: Colors.white,
                            icon: const Icon(Icons.cameraswitch),
                            onPressed: _toggleSelfieMode,
                          ),
                          Gaps.v10,
                          FlashModeButton(
                            currentMode: _flashMode,
                            mode: FlashMode.off,
                            icon: Icons.flash_off_rounded,
                            onPressed: _setFlashMode,
                          ),
                          FlashModeButton(
                            currentMode: _flashMode,
                            mode: FlashMode.always,
                            icon: Icons.flash_on_rounded,
                            onPressed: _setFlashMode,
                          ),
                          FlashModeButton(
                            currentMode: _flashMode,
                            mode: FlashMode.auto,
                            icon: Icons.flash_auto_rounded,
                            onPressed: _setFlashMode,
                          ),
                          FlashModeButton(
                            currentMode: _flashMode,
                            mode: FlashMode.torch,
                            icon: Icons.flashlight_on_rounded,
                            onPressed: _setFlashMode,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: Sizes.size40,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const Spacer(),
                          GestureDetector(
                            onTapDown: _startRecording,
                            onTapUp: (details) => _stopRecording(),
                            onLongPressUp: () => _stopRecording(),
                            child: ScaleTransition(
                              scale: _buttonAnimation,
                              child: Stack(
                                alignment: AlignmentGeometry.center,
                                children: [
                                  SizedBox(
                                    height: Sizes.size80 + Sizes.size14,
                                    width: Sizes.size80 + Sizes.size14,
                                    child: CircularProgressIndicator(
                                      color: Colors.red,
                                      strokeWidth: Sizes.size6,
                                      value: _progressAnimationController.value,
                                    ),
                                  ),
                                  Container(
                                    height: Sizes.size80,
                                    width: Sizes.size80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: IconButton(
                                onPressed: _onPickVideoPressed,
                                icon: const FaIcon(
                                  FontAwesomeIcons.image,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
