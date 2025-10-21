import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final FaIcon icon;
  final Function() tapButton;

  const AuthButton({
    super.key,
    required this.text,
    required this.tapButton,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => tapButton(),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          padding: EdgeInsets.all(Sizes.size14),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade200,
              width: Sizes.size1,
            ),
          ),
          child: Stack(
            alignment: AlignmentGeometry.center,
            children: [
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: icon,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
