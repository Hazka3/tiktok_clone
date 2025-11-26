import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class OnboardingFormButton extends StatelessWidget {
  final bool isIos;
  final String name;
  final VoidCallback onTap;

  const OnboardingFormButton({
    super.key,
    required this.isIos,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return isIos
        ? CupertinoButton(
            color: Theme.of(context).primaryColor,
            onPressed: onTap,
            child: Text(
              name,
              style: const TextStyle(color: Colors.white),
            ),
          )
        : GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Center(
                child: Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size16,
                  ),
                ),
              ),
            ),
          );
  }
}
