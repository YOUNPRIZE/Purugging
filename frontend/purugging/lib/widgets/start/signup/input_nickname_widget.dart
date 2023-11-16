import 'package:flutter/material.dart';

class InputNicknameWidget extends StatelessWidget {
  const InputNicknameWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.duplicateNickname,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool duplicateNickname;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 10,
      controller: controller,
      focusNode: focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: '닉네임',
        border: OutlineInputBorder(),
        errorStyle: TextStyle(color: Colors.red),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '닉네임을 입력해주세요';
        } else if (duplicateNickname) {
          return '중복된 닉네임입니다.';
        }
        return null;
      },
    );
  }
}
