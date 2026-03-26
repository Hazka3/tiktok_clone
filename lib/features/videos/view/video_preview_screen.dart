import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:tiktok_clone/features/videos/view_models/video_timeline_vm.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends ConsumerStatefulWidget {
  final XFile video;
  final bool isPicked;

  const VideoPreviewScreen({
    super.key,
    required this.video,
    required this.isPicked,
  });

  @override
  ConsumerState<VideoPreviewScreen> createState() => VideoPreviewScreenState();
}

class VideoPreviewScreenState extends ConsumerState<VideoPreviewScreen> {
  late final VideoPlayerController _videoPlayerController =
      VideoPlayerController.file(File(widget.video.path));

  bool _savedVideo = false;

  Future<void> initVideo() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();

    setState(() {});
  }

  Future<void> _saveToGallery() async {
    if (_savedVideo) return;

    _savedVideo = true;

    await ImageGallerySaverPlus.saveFile(
      widget.video.path,
      isReturnPathOfIOS: true,
      name: "tiktok_clone_${DateTime.now().millisecondsSinceEpoch}",
    );

    setState(() {});
  }

  void _onUploadPressed() {
    ref.read(videoTimelineProvider.notifier).uploadVideo();
  }

  @override
  void initState() {
    super.initState();
    initVideo();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Preview video",
        ),
        actions: [
          if (!widget.isPicked)
            IconButton(
              onPressed: _saveToGallery,
              icon: FaIcon(
                _savedVideo
                    ? FontAwesomeIcons.check
                    : FontAwesomeIcons.download,
              ),
            ),
          IconButton(
            onPressed: _onUploadPressed,
            icon: ref.watch(videoTimelineProvider).isLoading
                ? const CircularProgressIndicator.adaptive()
                : const FaIcon(FontAwesomeIcons.cloudArrowUp),
          ),
        ],
      ),
      body: _videoPlayerController.value.isInitialized
          ? VideoPlayer(_videoPlayerController)
          : const CircularProgressIndicator.adaptive(),
    );
  }
}
