import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/videos/view/widgets/video_post.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  final Duration _scrollDuration = const Duration(milliseconds: 100);
  final Curve _scrollCurve = Curves.linear;

  final PageController _pageController = PageController();

  final int _itemCount = 4;

  void _onPageChanged(int page) {
    _pageController.animateToPage(
      page,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
  }

  void _onVideoFinished() {
    return;
    // _pageController.nextPage(
    //   duration: _scrollDuration,
    //   curve: _scrollCurve,
    // );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() {
    return Future.delayed(const Duration(seconds: 5));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: _onRefresh,
      displacement: 100,
      edgeOffset: 20,
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        onPageChanged: _onPageChanged,
        itemCount: _itemCount,
        itemBuilder: (context, index) => VideoPost(
          index: index,
          onVideoFinished: _onVideoFinished,
        ),
      ),
    );
  }
}
