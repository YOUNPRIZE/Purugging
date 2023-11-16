import 'package:flutter/material.dart';

class ItemImageWidget extends StatelessWidget {
  const ItemImageWidget({
    super.key,
    required this.photo,
    required this.ploggingId,
  });

  final int ploggingId;
  final String? photo;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: photo != null
          ? Opacity(
              opacity: 0.55, // 조절할 투명도 값
              child: Hero(
                tag: 'plogging$ploggingId',
                child: Image.network(
                  photo!,
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Opacity(
              opacity: 0.55,
              child: Hero(
                tag: 'plogging$ploggingId',
                child: Image.asset(
                  'assets/image/home_image1.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
    );
  }
}
