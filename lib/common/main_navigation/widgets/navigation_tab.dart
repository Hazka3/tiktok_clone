import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';

class NavigationTab extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final String name;
  final bool isSelected;
  final Function onTap;
  final int selectedIndex;

  const NavigationTab({
    super.key,
    required this.icon,
    required this.selectedIcon,
    required this.name,
    required this.isSelected,
    required this.onTap,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: AnimatedOpacity(
          opacity: isSelected ? 1 : 0.6,
          duration: const Duration(milliseconds: 100),
          child: Container(
            color: selectedIndex == 0 ? Colors.black : Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  isSelected ? selectedIcon : icon,
                  color: selectedIndex == 0 ? Colors.white : Colors.black,
                ),
                Gaps.v5,
                Text(
                  name,
                  style: TextStyle(
                    color: selectedIndex == 0 ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
