import 'package:flutter/material.dart';

class LargeButtonWidget extends StatelessWidget {
  final String title, heroTag;
  final Function() handleFunc;
  final IconData icon;
  final Color color, textColor;

  const LargeButtonWidget({
      super.key,
      required this.title,
      required this.handleFunc,
      required this.icon,
      required this.heroTag,
      required this.color,
      required this.textColor,
      });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.large(
      heroTag: heroTag,
      onPressed: () => handleFunc(),
      backgroundColor: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: textColor,
            size: 48,
          ),
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
