import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
  bool _hasPermission = false;
  bool _deniedPermission = false;

  bool _isSelfieMode = false;
  late FlashMode _flashMode;

  late CameraController _cameraController;

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

  @override
  void initState() {
    super.initState();
    _initPermission();
  }

  @override
  void dispose() {
    _cameraController.dispose();
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
                          IconButton(
                            color: _flashMode == FlashMode.off
                                ? Colors.yellow
                                : Colors.white,
                            icon: const Icon(Icons.flash_off_rounded),
                            onPressed: () => _setFlashMode(FlashMode.off),
                          ),
                          IconButton(
                            color: _flashMode == FlashMode.always
                                ? Colors.yellow
                                : Colors.white,
                            icon: const Icon(Icons.flash_on_rounded),
                            onPressed: () => _setFlashMode(FlashMode.always),
                          ),
                          IconButton(
                            color: _flashMode == FlashMode.auto
                                ? Colors.yellow
                                : Colors.white,
                            icon: const Icon(Icons.flash_auto_rounded),
                            onPressed: () => _setFlashMode(FlashMode.auto),
                          ),
                          IconButton(
                            color: _flashMode == FlashMode.torch
                                ? Colors.yellow
                                : Colors.white,
                            icon: const Icon(Icons.flashlight_on_rounded),
                            onPressed: () => _setFlashMode(FlashMode.torch),
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
