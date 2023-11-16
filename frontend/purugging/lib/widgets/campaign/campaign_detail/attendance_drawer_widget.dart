import 'package:flutter/material.dart';
import 'package:purugging/widgets/campaign/campaign_detail/drawer_item_widget.dart';
import 'package:purugging/widgets/shared/icon_button_widget.dart';

class AttendanceDrawerWidget extends StatelessWidget {
  const AttendanceDrawerWidget({
    super.key,
    required this.approve,
    required this.removal,
    required this.members,
    required this.approval,
  });

  final Function approve;
  final Function removal;
  final List members;
  final Function approval;

  // 함수 - 회원 탈퇴
  Future<void> deleteMember(context) async {}

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: members.length,
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.black, // 가로선 색상 설정
                    thickness: 1, // 가로선 두께 설정// 가로선 위, 아래의 공간 설정
                  );
                },
                itemBuilder: (context, index) {
                  // 각 멤버를 위한 위젯을 반환
                  return DrawerItemWidget(member: members[index], approval: approval,);
                },
              ),
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
