import 'package:flutter/material.dart';

class PloggingDeniedWidget extends StatelessWidget {
  final Function() onRetry;

  const PloggingDeniedWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fmd_bad, size: 80),
          ],
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "위치 혹은 알람 권한이 필요합니다.",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 5),
            IconButton(
              onPressed: onRetry,
              icon: const Icon(Icons.restart_alt_outlined),
            ),
          ],
        ),
      ],
    );
  }
}
