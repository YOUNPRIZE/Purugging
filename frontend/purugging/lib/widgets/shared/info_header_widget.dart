import 'package:flutter/material.dart';
import 'package:purugging/widgets/shared/icon_button_widget.dart';

class InfoHeaderWidget extends StatelessWidget {
  // 생성자
  const InfoHeaderWidget({super.key, required this.titleTxt});

  // 변수 - 제목
  final Text titleTxt;

  // 함수 - 뒤로 가기
  void handleGoBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.grey, offset: Offset(0, 1), blurRadius: 3)
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 뒤로가기 버튼
              IconButtonWidget(
                  handleFunc: () => handleGoBack(context),
                  icon: Icons.arrow_back,
                  size: 32,
                  color: Colors.black),
              // 스크린
              titleTxt,
              const SizedBox(
                width: 36,
              )
            ],
          ),
        ),
      ],
    );
  }
}
