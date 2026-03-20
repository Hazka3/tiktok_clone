import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils/theme.dart';

class ChatDetailScreen extends StatefulWidget {
  static const String routeURL = "/inbox/chats/:chatId";
  static const String routeName = "chatdetail";

  final String chatId;

  const ChatDetailScreen({
    super.key,
    required this.chatId,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  void _onScreenTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);

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
          title: Text(
            "User ${widget.chatId}",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text("Active now"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                size: Sizes.size20,
                color: isDark ? Colors.grey.shade500 : Colors.grey.shade900,
              ),
              Gaps.h32,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                size: Sizes.size20,
                color: isDark ? Colors.grey.shade500 : Colors.grey.shade900,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: _onScreenTap,
            child: ListView.separated(
              padding: const EdgeInsets.only(
                top: Sizes.size20,
                bottom: Sizes.size96,
                right: Sizes.size14,
                left: Sizes.size14,
              ),
              itemBuilder: (context, index) {
                // mock用処理
                final isMine = (index % 2 == 0);

                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: isMine
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(Sizes.size14),
                      decoration: BoxDecoration(
                        color: isMine
                            ? Colors.blue
                            : Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(
                            Sizes.size20,
                          ),
                          topRight: const Radius.circular(
                            Sizes.size20,
                          ),
                          bottomLeft: Radius.circular(
                            isMine ? Sizes.size20 : Sizes.size5,
                          ),
                          bottomRight: Radius.circular(
                            !isMine ? Sizes.size20 : Sizes.size5,
                          ),
                        ),
                      ),
                      child: const Text(
                        "This is a message!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size16,
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => Gaps.v10,
              itemCount: 10,
            ),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: BottomAppBar(
              color: isDark ? null : Colors.grey.shade100,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      autocorrect: false,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(Sizes.size10),
                        filled: true,
                        fillColor: isDark ? Colors.grey.shade800 : Colors.white,
                        hintText: "Send a message...",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsetsGeometry.all(12),
                          child: FaIcon(
                            FontAwesomeIcons.faceSmile,
                            color: isDark
                                ? Colors.grey.shade500
                                : Colors.grey.shade900,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  Gaps.h20,
                  Container(
                    width: Sizes.size40,
                    height: Sizes.size40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: FaIcon(
                        FontAwesomeIcons.reply,
                        color: Colors.red,
                      ),
                    ),
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
