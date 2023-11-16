import 'package:flutter/material.dart';

class PloggingStatusWidget extends StatelessWidget {
  const PloggingStatusWidget({
    super.key,
    required this.distanceText,
    required this.currentTime,
  });

  final String distanceText;
  final String currentTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          distanceText,
          style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          currentTime,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
