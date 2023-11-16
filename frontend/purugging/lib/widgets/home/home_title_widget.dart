import 'package:flutter/material.dart';

class HomeTitleWidget extends StatelessWidget {
  const HomeTitleWidget({
    super.key,
    required this.hoemTitle,
  });

  final String hoemTitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      hoemTitle,
      style: const TextStyle(
          fontSize: 32, fontWeight: FontWeight.w400, fontFamily: 'KCC'),
    );
  }
}