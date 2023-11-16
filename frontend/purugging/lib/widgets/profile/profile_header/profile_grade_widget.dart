import 'package:flutter/material.dart';
import 'package:purugging/models/user_model.dart';

class ProfileGradeWidget extends StatelessWidget {
  const ProfileGradeWidget({
    super.key,
    required this.user,
  });

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Scaffold.of(context).openDrawer(),
      child: Container(
        width: 35,
        height: 35,
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFBADD7A),
        ),
        child: Image.asset(
          user!.getGradeIcon(),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
