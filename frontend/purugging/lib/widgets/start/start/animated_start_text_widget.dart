import 'package:flutter/material.dart';

class AnimatedStartTextWidget extends StatelessWidget {
  const AnimatedStartTextWidget({
    super.key,
    required this.isLoading,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isLoading ? 0 : 1,
      duration: const Duration(milliseconds: 1300),
      child: const Text(
        "터치하여 시작",
        style: TextStyle(
            fontSize: 28,
            fontFamily: 'KCC',
            color: Color(0xFF1F3A3A)
      ),
    ));
  }
}
