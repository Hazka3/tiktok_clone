import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_tabbar.dart';
import 'package:tiktok_clone/features/users/widgets/profile_stats.dart';
import 'package:tiktok_clone/utils/theme.dart';

class UserProfileScreen extends StatefulWidget {
  final String username;
  final String tab;

  const UserProfileScreen({
    super.key,
    required this.username,
    required this.tab,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);

    // backgroundcolor を使いたいため Scaffold で wrap
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: SafeArea(
        child: DefaultTabController(
          initialIndex: widget.tab == "likes" ? 1 : 0,
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: Text(widget.username),
                  actions: [
                    IconButton(
                      onPressed: _onGearPressed,
                      icon: const FaIcon(
                        FontAwesomeIcons.gear,
                        size: Sizes.size20,
                      ),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Gaps.v14,
                      const CircleAvatar(
                        radius: Sizes.size48,
                        foregroundImage: NetworkImage(
                          "https://avatars.githubusercontent.com/u/94900388",
                        ),
                        child: Text("Username"),
                      ),
                      Gaps.v14,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "@${widget.username}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: Sizes.size16,
                            ),
                          ),
                          Gaps.h5,
                          FaIcon(
                            FontAwesomeIcons.solidCircleCheck,
                            size: Sizes.size16,
                            color: Colors.blue.shade500,
                          ),
                        ],
                      ),
                      Gaps.v14,
                      SizedBox(
                        height: Sizes.size48,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const ProfileStats(
                              count: 37,
                              label: "Following",
                            ),
                            VerticalDivider(
                              width: Sizes.size32,
                              thickness: Sizes.size2,
                              color: Colors.grey.shade200,
                              indent: Sizes.size14,
                              endIndent: Sizes.size14,
                            ),
                            const ProfileStats(
                              count: 10594329,
                              label: "Followers",
                            ),
                            VerticalDivider(
                              width: Sizes.size32,
                              thickness: Sizes.size2,
                              color: Colors.grey.shade200,
                              indent: Sizes.size14,
                              endIndent: Sizes.size14,
                            ),
                            const ProfileStats(
                              count: 149389523,
                              label: "Likes",
                            ),
                          ],
                        ),
                      ),
                      Gaps.v14,
                      FractionallySizedBox(
                        widthFactor: 0.6,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: Sizes.size12 + Sizes.size1,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(
                                    Sizes.size2,
                                  ),
                                ),
                                child: const Text(
                                  "Follow",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Gaps.h5,
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: Sizes.size10,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isDark
                                        ? Colors.grey.shade800
                                        : Colors.grey.shade300,
                                    width: 1.3,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    Sizes.size2,
                                  ),
                                ),
                                child: const Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.youtube,
                                  ),
                                ),
                              ),
                            ),
                            Gaps.h5,
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: Sizes.size14 + Sizes.size1,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isDark
                                        ? Colors.grey.shade800
                                        : Colors.grey.shade300,
                                    width: 1.3,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    Sizes.size2,
                                  ),
                                ),
                                child: const Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.caretDown,
                                    size: Sizes.size14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gaps.v14,
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Sizes.size32,
                        ),
                        child: Text(
                          "This is my nice biooooooooooooooooooo + I wonder how it would loooooook",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Gaps.v14,
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.link,
                            size: Sizes.size12,
                          ),
                          Gaps.h4,
                          Text(
                            "https://google.com",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Gaps.v20,
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: PersistentTabBar(),
                ),
              ];
            },
            body: TabBarView(
              children: [
                GridView.builder(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: 20,
                  padding: const EdgeInsets.only(top: Sizes.size4),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: Sizes.size2,
                    crossAxisSpacing: Sizes.size2,
                    childAspectRatio: 3 / 4,
                  ),
                  itemBuilder: (context, index) => Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 3 / 4,
                        child: FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholder: "assets/images/placeholder.jpg",
                          image:
                              "https://picsum.photos/seed/${index + 1}/200/${350 + (5 * index)}",
                        ),
                      ),
                      Positioned(
                        bottom: Sizes.size2,
                        left: Sizes.size6,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.play,
                              color: Colors.white,
                              size: Sizes.size14,
                            ),
                            Gaps.h4,
                            Text(
                              "${index + 1}.0M",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: Sizes.size12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Center(
                  child: Text("Page two"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
