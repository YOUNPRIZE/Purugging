import 'package:flutter/material.dart';
import 'package:purugging/screens/campaign/campaign_list_screen.dart';
import 'package:purugging/screens/plogging/plogging_start_screen.dart';
import 'package:purugging/screens/profile/profile_screen.dart';
import 'package:purugging/widgets/bottm/plogging_button_widget.dart';
import 'package:purugging/widgets/bottm/campaign_button_widget.dart';
import 'package:purugging/widgets/bottm/profile_button_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // 변수 - 현재 선택된 스크린
  int currentIndex = 1;

  // 변수 - 위젯 리스트
  final List<Widget> pages = [
    const CampaignListScreen(),
    const PloggingStartScreen(),
    const ProfileScreen(),
  ];

  // 함수 - 스크린 선택
  void handleChoiceScreen(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  // init 사이클
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFCF3),
      body: pages[currentIndex],
      bottomNavigationBar: BottomAppBar(
        elevation: 15,
        color: Colors.white,
        height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // 캠페인 버튼
            GestureDetector(
                onTap: () => handleChoiceScreen(0),
                child: CampaignButtonWidget(currentIndex: currentIndex)),
            // 플로깅 버튼
            GestureDetector(
                onTap: () => handleChoiceScreen(1),
                child: PloggingButtonWidget(currentIndex: currentIndex)),
            // 프로필 버튼
            GestureDetector(
                onTap: () => handleChoiceScreen(2),
                child: ProfileButtonWidget(currentIndex: currentIndex)),
          ],
        ),
      ),
    );
  }
}
