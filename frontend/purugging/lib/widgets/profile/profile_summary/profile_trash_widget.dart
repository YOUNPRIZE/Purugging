import 'package:flutter/material.dart';

class ProfileTrashWidget extends StatelessWidget {
  const ProfileTrashWidget({super.key, required this.icon, required this.info});

  final IconData icon;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 45,
        ),
        Text(
          info,
          style: const TextStyle(fontSize: 18, fontFamily: 'KCC'),
        )
      ],
    );
  }
}
