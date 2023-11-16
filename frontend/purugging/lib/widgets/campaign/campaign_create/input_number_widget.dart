import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputNumberWidget extends StatefulWidget {
  const InputNumberWidget({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  State<InputNumberWidget> createState() => _InputNumberWidgetState();
}

class _InputNumberWidgetState extends State<InputNumberWidget> {
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "최대 인원수(명)",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Row(
          children: [
            SizedBox(
              width: 100,
              child: TextFormField(
                maxLines: 1,
                controller: widget.controller,
                focusNode: widget.focusNode,
                textAlign: TextAlign.center,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: const TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  errorStyle: const TextStyle(color: Colors.red),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // 보더의 모서리를 라운드 처리
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                ],
                validator: (value) {
                  if (value == null) {
                    isError = true;
                    return '입력 필수';
                  } else if (int.tryParse(value) != null &&
                      int.tryParse(value)! > 50) {
                    isError = true;
                    return '50명 초과';
                  } else {
                    isError = false;
                    return null;
                  }
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ],
    );
  }
}
