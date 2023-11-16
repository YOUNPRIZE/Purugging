import 'package:flutter/material.dart';

class PloggingCntWidget extends StatelessWidget {
  const PloggingCntWidget({
    super.key,
    required this.imgUrl,
    required this.cnt,
    required this.category,
  });

  final String imgUrl;
  final String cnt;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          imgUrl,
          width: 40,
          height: 40,
        ),
        Row(
          children: [
            Text(
              cnt.toString(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                fontFamily: 'KCC',
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(category,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
          ],
        )
      ],
    );
  }
}
