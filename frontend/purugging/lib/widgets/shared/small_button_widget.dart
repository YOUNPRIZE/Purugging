import 'package:flutter/material.dart';

class SmallButtonWidget extends StatelessWidget {
  final String title, heroTag;
  final Function() handleFunc;
  final IconData icon;
  final Color color;
  final Color textColor;

  const SmallButtonWidget(
      {super.key,
      required this.title,
      required this.handleFunc,
      required this.icon,
      required this.heroTag,
      required this.color,
      required this.textColor,
      });

  // 위젯 구현
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      onPressed: () => handleFunc(),
      backgroundColor: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: textColor,
            size: 28,
          ),
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
