import 'package:flutter/material.dart';

class ProfileNameWidget extends StatelessWidget {
  final String nickname;

  const ProfileNameWidget({super.key, required this.nickname});

  @override
  Widget build(BuildContext context) {
    return Text(
      nickname,
      style: TextStyle(
          fontSize: nickname.length > 5 ? 16 : 20,
          fontWeight: FontWeight.w800,
          fontFamily: 'KCC'),
    );
  }
}
