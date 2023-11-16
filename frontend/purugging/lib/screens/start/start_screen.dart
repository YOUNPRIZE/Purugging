import 'package:flutter/material.dart';
import 'package:purugging/screens/start/sign_up_screen.dart';
import 'package:purugging/services/auth_service.dart';
import 'package:purugging/widgets/start/start/animated_logo_widget.dart';
import 'package:purugging/widgets/start/start/animated_start_text_widget.dart';
import 'package:purugging/widgets/start/start/google_login_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main_screen.dart';

// Stateful 위젯
class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

// State 위젯
class _StartScreenState extends State<StartScreen> {
  int memberId = 0;
  bool isLoading = true;
  bool isNeededLogin = false;

  // 함수 - 메인 스크린으로 이동
  void navigateToMainScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  // 함수 - 회원가입 스크린으로 이동
  void navigateToSignUpScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }

  // Show error when sign-in fails
  void showSignInError(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
  }

  // 함수 - 저장된 유저 Id 로드
  void loadMemberId() async {
    // 유저id 불러오기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedMemberId = prefs.getInt('memberId');
    // 유저id 저장후 로드 완료 표시
    setState(() {
      isLoading = false;
      memberId = savedMemberId ?? 0;
    });
  }

  // 함수 - 시작
  void handleStart() {
    // 아직 유저 정보 로드 중인 경우 시작 X
    if (isLoading) {
      return;
    }
    // 저장된 유저 정보가 없는 경우
    if (memberId == 0) {
      setState(() {
        isNeededLogin = true;
      });
      // 저장된 유저 정보가 있는 경우
    } else {
      navigateToMainScreen();
    }
  }

  // init 사이클
  @override
  void initState() {
    super.initState();
    loadMemberId();
  }

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleStart,
      child: Scaffold(
        backgroundColor: const Color(0xFFFCFCF3),
        body: Stack(
          children: [
            Positioned(
                child: Center(child: AnimatedLogoWidget(isLoading: isLoading))),
            Positioned(
              left: 0,
              right: 0,
              bottom: 170,
              child: Center(
                child: AnimatedCrossFade(
                  duration: const Duration(milliseconds: 150),
                  crossFadeState: isNeededLogin
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  firstChild: AnimatedStartTextWidget(isLoading: isLoading),
                  secondChild: const Text(
                    "플로깅",
                    style: TextStyle(
                        fontSize: 32,
                        fontFamily: 'KCC',
                        color: Color(0xFF1F3A3A)),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 50,
              right: 50,
              bottom: 60,
              child: !isNeededLogin
                  ? const SizedBox(
                      height: 0,
                    )
                  : GoogleLoginButtonWidget(
                      onSignInSuccess: navigateToMainScreen,
                      onSignUpRequired: navigateToSignUpScreen,
                      onSignInError: showSignInError,
                    ),
            )
          ],
        ),
      ),
    );
  }
}
