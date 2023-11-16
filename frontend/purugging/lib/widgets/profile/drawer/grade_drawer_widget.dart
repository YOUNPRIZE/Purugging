import 'package:flutter/material.dart';

class GradeDrawerWidget extends StatefulWidget {
  const GradeDrawerWidget({super.key});

  @override
  State<GradeDrawerWidget> createState() => _GradeDrawerWidgetState();
}

class _GradeDrawerWidgetState extends State<GradeDrawerWidget> {
  final List<List<String>> grades = [
    ["씨앗", "seed_icon"],
    ["새싹", "sprout_icon"],
    ["잎새", "leaf_icon"],
    ["가지", "branch_icon"],
    ["열매", "fruit_icon"],
    ["나무", "tree_icon"],
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 160,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (final grade in grades)
              Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFBADD7A),
                    ),
                    child: Image.asset(
                      'assets/image/${grade[1]}.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${grade[0]} 등급',
                    style: const TextStyle(fontFamily: 'KCC'),
                  ),
                  const SizedBox(
                    height: 25,
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}
