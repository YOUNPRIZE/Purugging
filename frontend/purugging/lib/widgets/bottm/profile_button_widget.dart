import 'package:flutter/material.dart';

class ProfileButtonWidget extends StatelessWidget {
  const ProfileButtonWidget({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.person_3_outlined,
              size: 35, color: currentIndex == 2 ? Colors.green : Colors.black),
          Text(
            "프로필",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: currentIndex == 2 ? Colors.green : Colors.black),
          )
        ],
      ),
    );
  }
}
