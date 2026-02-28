import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ProfileStats extends StatelessWidget {
  final int count;
  final String label;

  const ProfileStats({
    super.key,
    required this.count,
    required this.label,
  });

  String formatCount(int count) {
    if (count < 1000) {
      return "$count";
    } else if (count < 1000000) {
      final value = (count / 100).floor() / 10;
      return "${value.toStringAsFixed(1)}K";
    } else {
      final value = (count / 100000).floor() / 10;
      return "${value.toStringAsFixed(1)}M";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          formatCount(count),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Sizes.size18,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}
