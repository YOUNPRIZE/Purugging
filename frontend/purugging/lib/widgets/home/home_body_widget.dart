import 'package:flutter/material.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({
    super.key,
    required this.hoemBody,
  });

  final String hoemBody;

  @override
  Widget build(BuildContext context) {
    return Text(
      hoemBody,
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: 22, fontWeight: FontWeight.w400, fontFamily: 'KCC'),
    );
  }
}