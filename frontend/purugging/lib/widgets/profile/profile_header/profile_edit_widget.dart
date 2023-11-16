import 'package:flutter/material.dart';

class ProfileEditWidget extends StatelessWidget {
  const ProfileEditWidget({
    super.key,
    required this.handleEdit
  });

  final Function() handleEdit;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => handleEdit(),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
            const Size(30, 20)),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 5)), // 내부 패딩을 0으로 설정
      ),
      child: const Text(
        "프로필 편집",
        style: TextStyle(fontSize: 11),
      ),
    );
  }
}