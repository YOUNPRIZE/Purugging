import 'package:flutter/material.dart';

class DetailImageWidget extends StatelessWidget {
  // 생성자
  const DetailImageWidget(
      {super.key, required this.image, required this.ploggingId});

  // 변수 - 이미지 주소
  final String? image;
  final int ploggingId;

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
              spreadRadius: 4.0,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Hero(tag: 'plogging$ploggingId', 
        child: image != null? Image.network(image!):
        Image.asset('assets/image/home_image1.jpg')
        ));
  }
}
