import 'package:flutter/material.dart';

class InputNameWidget extends StatelessWidget {
  const InputNameWidget({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLength: 10,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: '이름',
        border: OutlineInputBorder(),
        errorStyle: TextStyle(color: Colors.red),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '이름을 입력해주세요';
        }
        return null;
      },
    );
  }
}
