import 'package:flutter/material.dart';

class AnimatedLogoWidget extends StatelessWidget {
  const AnimatedLogoWidget({
    super.key,
    required this.isLoading,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        alignment: Alignment.center,
        width: 200,
        height: 200,
        duration: const Duration(seconds: 1),
        curve: Curves.bounceOut,
        transform:
            Matrix4.translationValues(0, isLoading == true ? 300 : -100, 0),
        child: Image.asset('assets/logo/logo.png'));
  }
}
