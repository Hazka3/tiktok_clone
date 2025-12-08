import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class PostVideoButton extends StatefulWidget {
  const PostVideoButton({super.key});

  @override
  State<PostVideoButton> createState() => _PostVideoButtonState();
}

class _PostVideoButtonState extends State<PostVideoButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _turns;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _turns = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: 17,
          child: Container(
            height: 35,
            width: 25,
            decoration: BoxDecoration(
              color: const Color(0xff61D4F0),
              borderRadius: BorderRadius.circular(Sizes.size9),
            ),
          ),
        ),
        Positioned(
          left: 17,
          child: Container(
            height: 35,
            width: 25,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(Sizes.size9),
            ),
          ),
        ),
        GestureDetector(
          onLongPress: () {
            if (!_animationController.isAnimating) {
              _animationController.repeat();
            }
          },
          onLongPressEnd: (_) {
            _animationController.reverse();
          },
          child: Container(
            height: 35,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Sizes.size8),
            ),
            child: Center(
              child: RotationTransition(
                turns: _turns,
                child: const FaIcon(
                  FontAwesomeIcons.plus,
                  color: Colors.black,
                  size: Sizes.size20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
