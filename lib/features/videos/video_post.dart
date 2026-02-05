import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/video.mp4");

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    _videoPlayerController.addListener(_onVideoChange);
    _videoPlayerController.play();

    setState(() {});
  }

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      // 例えば総尺(duration)が10秒の映像で、現在の位置(position)が10秒、すなわち再生が完了した時の処理
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _onVideoTap() {
    _videoPlayerController.pause();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: _videoPlayerController.value.isInitialized
              ? GestureDetector(
                  onTap: _onVideoTap,
                  child: VideoPlayer(_videoPlayerController),
                )
              : Container(
                  color: Colors.black,
                ),
        ),
      ],
    );
  }
}
