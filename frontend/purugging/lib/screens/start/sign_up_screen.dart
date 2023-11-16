import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:purugging/screens/main_screen.dart';
import 'package:purugging/services/auth_service.dart';
import 'package:purugging/services/member_services.dart';
import 'package:purugging/widgets/shared/elevated_button_widget.dart';
import 'package:purugging/widgets/start/signup/input_name_widget.dart';
import 'package:purugging/widgets/start/signup/input_nickname_widget.dart';
import 'package:purugging/widgets/start/signup/input_phone_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // 변수 - 입력 컨트롤러
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  // 변수 - 입력 포커스
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode nicknameFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  // 변수 - 파이어베이스 유저 정보
  final User firebaseInfo = FirebaseAuth.instance.currentUser!;
  // 변수 - 중복 여부
  bool duplicateNickname = false;
  bool duplicateNumber = false;

  // 함수 - 회원가입 진행
  Future<void> handleSingup() async {
    setState(() {
      duplicateNickname = false;
      duplicateNumber = false;
    });
    // 이름이 입력되지 않음 경우
    if (nameController.text.isEmpty) {
      nameFocusNode.requestFocus();
      // 닉네임이 입력되지 않은 경우
    } else if (nicknameController.text.isEmpty) {
      nicknameFocusNode.requestFocus();
      // 휴대폰 번호가 입력되지 않은 경우
    } else if (phoneController.text.isEmpty) {
      phoneFocusNode.requestFocus();
      // 닉네임 중복 검증
    } else if (!await MemberServices.checkNickname(nicknameController.text)) {
      nicknameFocusNode.requestFocus();
      setState(() {
        duplicateNickname = true;      
      });
      // 전화번호 중복 검증
    } else if (!await MemberServices.checkPhone(phoneController.text)) {
      phoneFocusNode.requestFocus();
      setState(() {       
        duplicateNumber = true;
      });
      // 회원가입 진행
    } else {
      // 데이터 정리
      final memberData = {
        'name': nameController.text,
        'nickname': nicknameController.text,
        'phone_number': phoneController.text,
        'email': firebaseInfo.email,
        'image_url': firebaseInfo.photoURL,
        "google_uid": firebaseInfo.uid
      };
      bool result = await MemberServices.signUp(memberData);
      if (result) {
        Map<String, dynamic>? memberData = await AuthService.isMember();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('memberId', memberData!['member_id']);
        await AuthService.sendFcmToken();
        navigateToMainScreen();
      }
    }
  }

  // 함수 - 메인 스크린으로 이동
  Future<void> navigateToMainScreen() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    nameController.text = firebaseInfo.displayName!;
    nicknameController.text = firebaseInfo.displayName!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFCF3),
      // 헤더
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text(
          '회원가입',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 68, horizontal: 24),
        children: <Widget>[
          // 이름 입력
          InputNameWidget(
            controller: nameController,
            focusNode: nameFocusNode,
          ),
          const SizedBox(height: 32),
          InputNicknameWidget(
            controller: nicknameController,
            focusNode: nicknameFocusNode,
            duplicateNickname: duplicateNickname,
          ),
          const SizedBox(height: 32),
          InputPhoneWidget(
            controller: phoneController,
            focusNode: phoneFocusNode,
            duplicateNumber: duplicateNumber,
          ),
          const SizedBox(height: 48),
          ElevatedButtonWidget(
            title: '완료',
            txtSize: 20,
            handleFunc: handleSingup,
          ),
        ],
      ),
    );
  }
}
