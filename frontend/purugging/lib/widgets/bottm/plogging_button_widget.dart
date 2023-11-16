import 'package:flutter/material.dart';

class PloggingButtonWidget extends StatelessWidget {
  const PloggingButtonWidget({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
          milliseconds: 200), // Set the duration of the animation
      transform: Matrix4.translationValues(
          currentIndex == 1 ? 0 : -10, currentIndex == 1 ? 0 : -28, 0),
      child: AnimatedContainer(
        duration: const Duration(
            milliseconds: 200), // Set the duration of the animation
        transform: Matrix4.identity()
          ..scale(currentIndex == 1 ? 1.0 : 1.5, currentIndex == 1 ? 1.0 : 1.5),
        child: SizedBox(
          height: 60,
          width: 60,
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3.0,
                ),
              ],
              shape: BoxShape.circle,
              color: Color(0xFFBADD7A),
            ),
            child: Transform.scale(
              scale: 0.85,
              child: Image.asset('assets/logo/logo.png'),
            ),
          ),
        ),
      ),
    );
  }
}
