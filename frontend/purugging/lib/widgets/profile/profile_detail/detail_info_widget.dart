import 'package:flutter/material.dart';

class DetailInfoWidget extends StatelessWidget {
  // 생성자
  const DetailInfoWidget(
      {super.key, required this.category, required this.info});

  // 변수 - 카테고리, 정보
  final String category, info;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          info,
          style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic),
        ),
        Text(
          category,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
