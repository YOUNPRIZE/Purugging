import 'package:flutter/material.dart';

import 'package:purugging/services/auth_service.dart';
import 'package:purugging/services/member_services.dart';
import 'package:purugging/widgets/shared/alert_dialog_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleLoginButtonWidget extends StatelessWidget {
  final VoidCallback onSignInSuccess;
  final VoidCallback onSignUpRequired;
  final Function(String) onSignInError;

  const GoogleLoginButtonWidget({
    required this.onSignInSuccess,
    required this.onSignUpRequired,
    required this.onSignInError,
    super.key,
  });

  // 함수 - 로그인 진행
  Future<void> handleSignIn(context) async {
    bool? success;
    // 파이어베이스에서 구글 유저 정보 불러오기
    try {
      bool result = await AuthService.signInWithGoogle();
      success = result;
    } catch (e) {
      return;
    }
    if (success) {
      Map<String,dynamic>? memberData = await AuthService.isMember();
      if (memberData == null ) {return;}
      // 이미 가입한 회원이면 FCM 토큰 전송하
      else if (memberData['status'] == 'ACTIVE') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('memberId', memberData['member_id']);
        await AuthService.sendFcmToken();
        onSignInSuccess(); // MainScreen으로 이동
      // 미가입한 회원이면 회원가입 페이지로 이동
      } else if (memberData['status'] == 'NOT_REGISTERED'){
        onSignUpRequired(); // SingUpScreen으로 이동
      } else if (memberData['status'] == 'INACTIVE'){
        return showDialog(
        context: context,
        barrierDismissible: false, // 다이얼로그 이외의 바탕 눌러도 안꺼지도록 설정
        builder: (BuildContext context) {
          // 알림창
          return AlertDialogWidget(
            title: '재가입',
            body: '회원 탈퇴한 이력이 있습니다.\n재가입하시겠습니까?',
            handleAlert: () async{
              bool result = await MemberServices.rejoin(memberData['member_id']);
              if (result) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setInt('memberId', memberData['member_id']);
                onSignInSuccess();
              }
            },
          );
        });
      }
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => handleSignIn(context),
      style: OutlinedButton.styleFrom(
        fixedSize: const Size(260, 55),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/logo/logo_google.png'),
          const Text(
            "구글 계정으로 로그인",
            style: TextStyle(
              color: Color(0xFF1e3a37),
              fontSize: 16,
              fontFamily: 'KCC',
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
