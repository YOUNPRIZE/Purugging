import 'package:flutter/material.dart';
import 'package:purugging/services/auth_service.dart';
import 'package:purugging/services/member_services.dart';
import 'package:purugging/widgets/shared/alert_dialog_widget.dart';
import 'package:purugging/widgets/shared/icon_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDrawerWidget extends StatelessWidget {
  const ProfileDrawerWidget({super.key, required this.handleMoveScreen});

  final Function() handleMoveScreen;

  // 함수 - 회원 탈퇴
  Future<void> deleteMember(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? memberId = prefs.getInt('memberId');
    return showDialog(
        context: context,
        barrierDismissible: false, // 다이얼로그 이외의 바탕 눌러도 안꺼지도록 설정
        builder: (context) {
          // 알림창
          return AlertDialogWidget(
            title: '회원 탈퇴',
            body: '정말 회원 탈퇴 하시겠습니까? \n저장된 데이터가 삭제됩니다.',
            handleAlert: () async {
              Navigator.of(context).pop();
              await AuthService.signOut(context);
              bool result = await MemberServices.deleteMember(memberId!);
              if (result) {}
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 회원 탈퇴 버튼
            Column(
              children: [
                IconButtonWidget(
                    handleFunc: () {
                      deleteMember(context);
                    },
                    icon: Icons.person_off_outlined,
                    size: 50,
                    color: Colors.black),
                const Text(
                  "회원탈퇴",
                  style: TextStyle(fontWeight: FontWeight.w600),
                )
              ],
            ),
            // 프로필 정보 변경 버튼
            Column(
              children: [
                IconButtonWidget(
                    handleFunc: handleMoveScreen,
                    icon: Icons.person_search_sharp,
                    size: 50,
                    color: Colors.black),
                const Text(
                  "프로필 변경",
                  style: TextStyle(fontWeight: FontWeight.w600),
                )
              ],
            ),
            // 로그아웃 버튼
            Column(
              children: [
                IconButtonWidget(
                    handleFunc: () {
                      AuthService.signOut(context);
                    },
                    icon: Icons.logout_outlined,
                    size: 50,
                    color: Colors.black),
                const Text(
                  "로그아웃",
                  style: TextStyle(fontWeight: FontWeight.w600),
                )
              ],
            ),
            // 뒤로 가기 버튼
            Column(
              children: [
                IconButtonWidget(
                    handleFunc: () {
                      Navigator.pop(context);
                    },
                    icon: Icons.arrow_circle_left_outlined,
                    size: 50,
                    color: Colors.black),
                const Text(
                  "뒤로 가기",
                  style: TextStyle(fontWeight: FontWeight.w600),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
