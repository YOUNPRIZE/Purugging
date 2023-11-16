import 'package:flutter/material.dart';

class InputPhoneWidget extends StatelessWidget {
  const InputPhoneWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.duplicateNumber,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool duplicateNumber;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        errorStyle: TextStyle(color: Colors.red),
        labelText: '휴대폰 번호(- 제외)',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '휴대폰 번호를 입력해주세요';
        } else if (duplicateNumber) {
          return '중복된 전화번호 입니다.';
        }
        return null;
      },
    );
  }
}
