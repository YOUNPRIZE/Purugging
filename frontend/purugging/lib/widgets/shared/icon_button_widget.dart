import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final double size;
  final Color color;
  final Function() handleFunc;
  final IconData icon;

  const IconButtonWidget(
      {super.key,
      required this.handleFunc,
      required this.icon,
      required this.size,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
          iconSize: size,
          onPressed: () => handleFunc(),
          icon: Icon(
            icon,
            color: color,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(4, 4),
              )
            ],
          )),
    );
  }
}
