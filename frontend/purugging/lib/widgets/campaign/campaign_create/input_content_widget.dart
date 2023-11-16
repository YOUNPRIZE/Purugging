import 'package:flutter/material.dart';

class InputContentWidget extends StatelessWidget {
  const InputContentWidget({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 200,
      maxLines: 10,
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: '상세 내용',
        hintText: '상세 내용을 입력하세요.',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0), // 보더의 모서리를 라운드 처리
        ),
      ),
    );
  }
}
