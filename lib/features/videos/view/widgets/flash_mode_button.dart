import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class FlashModeButton extends StatelessWidget {
  final FlashMode currentMode;
  final FlashMode mode;
  final IconData icon;
  final ValueChanged<FlashMode> onPressed;

  const FlashModeButton({
    super.key,
    required this.currentMode,
    required this.mode,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: currentMode == mode ? Colors.yellow : Colors.white,
      icon: Icon(icon),
      onPressed: () => onPressed(mode),
    );
  }
}
