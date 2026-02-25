import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size5,
          leading: SizedBox(
            width: 48,
            height: 48,
            child: Stack(
              alignment: AlignmentGeometry.center,
              children: [
                const CircleAvatar(
                  foregroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/u/94900388",
                  ),
                  backgroundColor: Colors.white,
                  radius: Sizes.size24,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: Sizes.size18,
                    height: Sizes.size18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                      border: BoxBorder.all(
                        color: Colors.white,
                        width: Sizes.size3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          title: const Text(
            "User",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text("Active Now"),
          trailing: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                color: Colors.black,
                size: Sizes.size20,
              ),
              Gaps.h32,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: Colors.black,
                size: Sizes.size20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
