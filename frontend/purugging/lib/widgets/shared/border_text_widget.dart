import 'package:flutter/material.dart';

class BorderTextWidget extends StatelessWidget {
  const BorderTextWidget({
    super.key,
    required this.info,
    required this.txtSize,
  });

  final String info;
  final double txtSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10), // 10의 반지름을 가진 둥근 모서리
        border: Border.all(
          color: Colors.grey, // 테두리 선의 색상
          width: 1.0, // 테두리 선의 너비
        ),
      ),
      child: Text(
        info,
        style: TextStyle(fontSize: txtSize, fontWeight: FontWeight.w600),
      ),
    );
  }
}
