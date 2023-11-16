import 'package:flutter/material.dart';

class InputTitleWidget extends StatelessWidget {
  const InputTitleWidget({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 30,
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: '캠페인 제목',
        hintText: '캠페인 제목을 입력하세요.',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0), // 보더의 모서리를 라운드 처리
        ),
      ),
    );
  }
}
