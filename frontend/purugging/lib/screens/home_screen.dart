import 'package:flutter/material.dart';
import 'package:purugging/widgets/home/home_body_widget.dart';

import 'package:purugging/widgets/home/home_title_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String hoemTitle = "플로깅이란?";
  String hoemBody1 = "'줍다'를 뜻하는 (Plocka Upp)와\n조깅(jogging)의 합성어로";
  String homeBody2 = "조깅을 하면서 쓰레기도 줍는\n일석이조의 활동입니다.";
  String homeBody3 = "푸르깅(Purugging)앱을 통해\n쉽고 재밌게 플로깅해보아요!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            opacity: 0.4,
            fit: BoxFit.cover,
            image: AssetImage('assets/image/home_image.jpg'), // 배경 이미지
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            HomeTitleWidget(hoemTitle: hoemTitle),
            const SizedBox(
              height: 50,
            ),
            HomeBodyWidget(hoemBody: hoemBody1),
            const SizedBox(
              height: 50,
            ),
            HomeBodyWidget(hoemBody: homeBody2),
            const SizedBox(
              height: 50,
            ),
            HomeBodyWidget(hoemBody: homeBody3),
            const SizedBox(
              height: 50,
            ),
          ]),
        ),
      ),
    );
  }
}
