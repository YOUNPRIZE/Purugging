import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget(
      {super.key,
      required this.txtSize,
      required this.title,
      required this.handleFunc,
      this.color,
      this.textColor
      });

  final Color? color;
  final Color? textColor;
  final double txtSize;
  final String title;
  final Function() handleFunc;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => handleFunc(),
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(
              vertical: 12,
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
              color == null ? const Color(0xFFBADD7A) : color!)),
      child: Text(
        title,
        style: TextStyle(
          color: textColor == null ? Colors.white : textColor!,
          fontSize: txtSize),
      ),
    );
  }
}
