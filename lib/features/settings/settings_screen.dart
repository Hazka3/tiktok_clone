import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/common/video_config/video_config.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          SwitchListTile.adaptive(
            value: context.watch<VideoConfig>().isMuted,
            onChanged: (value) {
              context.read<VideoConfig>().toggleIsMuted();
            },
            title: const Text("Auto Mute"),
            subtitle: const Text("Videos muted by default."),
          ),
          ListTile(
            title: const Text("Log out"),
            textColor: Colors.red,
            onTap: () {
              showAdaptiveDialog(
                context: context,
                builder: (context) => AlertDialog.adaptive(
                  title: const Text(
                    "Are you sure?",
                  ),
                  content: const Text(
                    "Pls dont go TT",
                  ),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        "No",
                      ),
                    ),
                    CupertinoDialogAction(
                      onPressed: () => Navigator.of(context).pop(),
                      isDestructiveAction: true,
                      child: const Text("Yes"),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Log out (bottom)"),
            textColor: Colors.red,
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) => CupertinoActionSheet(
                  title: const Text(
                    "Are you sure?",
                  ),
                  message: const Text("Please dooooont gooooo"),
                  actions: [
                    CupertinoActionSheetAction(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Not log out"),
                    ),
                    CupertinoActionSheetAction(
                      isDestructiveAction: true,
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Yes plz"),
                    ),
                  ],
                ),
              );
            },
          ),
          const AboutListTile(
            applicationVersion: "1.0",
            applicationLegalese: "Don't copy me.",
          ),
        ],
      ),
    );
  }
}
