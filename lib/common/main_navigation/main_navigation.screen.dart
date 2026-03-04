import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/main_navigation/widgets/navigation_tab.dart';
import 'package:tiktok_clone/common/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/discover/discover_screen.dart';
import 'package:tiktok_clone/features/inbox/inbox_screen.dart';
import 'package:tiktok_clone/features/users/user_profile_screen.dart';
import 'package:tiktok_clone/features/videos/video_timeline_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> screens = [
    const Center(
      child: Text("Home"),
    ),
    const Center(
      child: Text("Discover"),
    ),
    Container(),
    const Center(
      child: Text("Inbox"),
    ),
    const Center(
      child: Text("Profile"),
    ),
  ];

  void _onTabTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            // ポスト機能は未実装のため暫定措置として空 scaffold に遷移
            title: const Text("Record video"),
          ),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedIndex == 0 ? Colors.black : Colors.white,
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
            child: const UserProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: _selectedIndex == 0 ? Colors.black : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size12),
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
      ),
    );
  }
}
