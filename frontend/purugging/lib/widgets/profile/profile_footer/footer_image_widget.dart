import 'package:flutter/material.dart';
import 'package:purugging/models/plogging_model.dart';

class FooterImageWidget extends StatelessWidget {
  const FooterImageWidget({
    super.key,
    required this.plogging,
  });

  final PloggingModel plogging;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: plogging.plogging_image != null
          ? Opacity(
              opacity: 0.55, // 조절할 투명도 값
              child: Hero(
                tag: 'plogging${plogging.plogging_id}',
                child: Image.network(
                  plogging.plogging_image!,
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Opacity(
              opacity: 0.55,
              child: Hero(
                tag: 'plogging${plogging.plogging_id}',
                child: Image.asset(
                  'assets/image/home_image1.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
    );
  }
}
