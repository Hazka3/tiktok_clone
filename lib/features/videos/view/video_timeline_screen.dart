import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/view/widgets/video_post.dart';
import 'package:tiktok_clone/features/videos/view_models/video_timeline_vm.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  VideoTimelineScreenState createState() => VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
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
    return ref
        .watch(videoTimelineProvider)
        .when(
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          error: (error, stackTrace) => const Center(
            child: Text(
              "Colud not load videos",
              style: TextStyle(color: Colors.white),
            ),
          ),
          data: (videos) => RefreshIndicator.adaptive(
            onRefresh: _onRefresh,
            displacement: 100,
            edgeOffset: 20,
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              onPageChanged: _onPageChanged,
              itemCount: videos.length,
              itemBuilder: (context, index) => VideoPost(
                index: index,
                onVideoFinished: _onVideoFinished,
              ),
            ),
          ),
        );
  }
}
