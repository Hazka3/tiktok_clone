import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/main_navigation/widgets/navigation_tab.dart';
import 'package:tiktok_clone/common/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/features/discover/discover_screen.dart';
import 'package:tiktok_clone/features/inbox/inbox_screen.dart';
import 'package:tiktok_clone/features/users/user_profile_screen.dart';
import 'package:tiktok_clone/features/videos/view/video_recording_screen.dart';
import 'package:tiktok_clone/features/videos/view/video_timeline_screen.dart';
import 'package:tiktok_clone/utils/theme.dart';

class MainNavigationScreen extends StatefulWidget {
  static const String routeURL = "/:tab";
  static const String routeName = "top";

  final String tab;

  const MainNavigationScreen({
    super.key,
    required this.tab,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<String> _tabs = [
    "home",
    "discover",
    "recording",
    "inbox",
    "profile",
  ];

  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTabTap(int index) {
    context.goNamed(
      MainNavigationScreen.routeName,
      pathParameters: {"tab": _tabs[index]},
    );
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoTap() {
    context.pushNamed(VideoRecordingScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Scaffold(
      backgroundColor: _selectedIndex == 0 || isDark
          ? Colors.black
          : Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const VideoTimelineScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const InboxScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileScreen(
              username: "hehe",
              tab: "",
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: _selectedIndex == 0 || isDark ? Colors.black : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavigationTab(
              icon: FontAwesomeIcons.house,
              selectedIcon: FontAwesomeIcons.house,
              name: "Home",
              isSelected: _selectedIndex == 0,
              onTap: () => _onTabTap(0),
              selectedIndex: _selectedIndex,
            ),
            NavigationTab(
              icon: FontAwesomeIcons.compass,
              selectedIcon: FontAwesomeIcons.solidCompass,
              name: "Discover",
              isSelected: _selectedIndex == 1,
              onTap: () => _onTabTap(1),
              selectedIndex: _selectedIndex,
            ),
            Gaps.h24,
            GestureDetector(
              onTap: _onPostVideoTap,
              child: PostVideoButton(
                inverted: _selectedIndex != 0,
              ),
            ),
            Gaps.h24,
            NavigationTab(
              icon: FontAwesomeIcons.message,
              selectedIcon: FontAwesomeIcons.solidMessage,
              name: "Inbox",
              isSelected: _selectedIndex == 3,
              onTap: () => _onTabTap(3),
              selectedIndex: _selectedIndex,
            ),
            NavigationTab(
              icon: FontAwesomeIcons.user,
              selectedIcon: FontAwesomeIcons.solidUser,
              name: "Profile",
              isSelected: _selectedIndex == 4,
              onTap: () => _onTabTap(4),
              selectedIndex: _selectedIndex,
            ),
          ],
        ),
      ),
    );
  }
}
