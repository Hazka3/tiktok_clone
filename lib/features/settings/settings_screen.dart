import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          SwitchListTile.adaptive(
            value: ref.watch(playbackConfigProvider).muted,
            onChanged: (value) {
              ref.read(playbackConfigProvider.notifier).setMuted(value);
            },
            title: const Text("Mute Video"),
            subtitle: const Text("Videos muted by default."),
          ),
          SwitchListTile.adaptive(
            value: ref.watch(playbackConfigProvider).autoplay,
            onChanged: (value) {
              ref.read(playbackConfigProvider.notifier).setAutoplay(value);
            },
            title: const Text("Autoplay"),
            subtitle: const Text("Videos will start playing automatically."),
          ),
          SwitchListTile(
            value: false,
            onChanged: (_) {},
            title: const Text("Enable notifications"),
            subtitle: const Text("They will be cute xD."),
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
