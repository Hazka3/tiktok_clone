import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;
  final int index;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  final Duration _animationDuration = const Duration(milliseconds: 300);

  bool _isEllipsis = false;
  bool _isPaused = false;

  late final VideoPlayerController _videoPlayerController;
  late final AnimationController _animationController;

  void _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.asset(
      "assets/videos/video.mp4",
    );
    await _videoPlayerController.initialize();

    _videoPlayerController
      ..setLooping(true)
      ..addListener(_onVideoChange);

    setState(() {});
  }

  void _initVideoButtonAnimation() async {
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );
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

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 1 && !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
  }

  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
    _isPaused = !_isPaused;

    setState(() {});
  }

  void _toggleSeeMore() {
    setState(() {
      _isEllipsis = !_isEllipsis;
    });
  }

  @override
  void initState() {
    super.initState();
    _initVideoButtonAnimation();
    _initVideoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              // タップ判定をアイコンに持たせたくないので IgnorePointer で Wrap
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child,
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1 : 0,
                    duration: _animationDuration,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 15,
            child: AnimatedSize(
              duration: const Duration(milliseconds: 100),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // アニメーション時に username が一瞬クリップされてしまうので、その予防策として余白を追加
                  Gaps.v10,
                  const Text(
                    "@username",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v10,
                  const Text(
                    "This is actually the place 🍔",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size16,
                    ),
                  ),
                  Gaps.v5,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 250,
                        child: Text(
                          "#googleearth #googlemaps #googleahahha #flutter #makeoverflow",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            overflow: _isEllipsis
                                ? TextOverflow.fade
                                : TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Gaps.h6,
                      GestureDetector(
                        onTap: _toggleSeeMore,
                        child: Text(
                          _isEllipsis ? "less" : "more",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: Sizes.size16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
