import 'package:flutter/material.dart';
import 'package:purugging/models/user_model.dart';
import 'package:purugging/services/member_services.dart';
import 'package:purugging/widgets/shared/icon_button_widget.dart';

class DrawerItemWidget extends StatefulWidget {
  const DrawerItemWidget({
    super.key,
    required this.member,
    required this.approval,
  });

  final dynamic member;
  final Function approval;

  @override
  State<DrawerItemWidget> createState() => _DrawerItemWidgetState();
}

class _DrawerItemWidgetState extends State<DrawerItemWidget> {
  UserModel? memberInfo;

  // 함수 - 유저 정보 불러오기
  Future<void> loadMemberInfo() async {
    final result =
        await MemberServices.loadMemberInfo(widget.member['member_id']);
    setState(() {
      memberInfo = result;
    });
  }

  @override
  void initState() {
    super.initState();
    loadMemberInfo();
  }

  @override
  Widget build(BuildContext context) {
    return memberInfo == null
        ? const SizedBox(
            height: 0,
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                memberInfo!.nickname,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              widget.member['attendance_status'] == 'ATTENDANCE_IS_ORGANIZER'
                  // 개최자
                  ? IconButtonWidget(
                      handleFunc: () {},
                      icon: Icons.assignment_ind_outlined,
                      size: 24,
                      color: Colors.black)
                  : Checkbox(
                      value: widget.member['attendance_status'] !=
                          'ATTENDANCE_NOT_APPROVED',
                      onChanged: (bool? value) {
                        if (widget.member['attendance_status'] ==
                          'ATTENDANCE_NOT_APPROVED') {
                            widget.approval(widget.member['member_id']);
                          }
                      },
                    ),
            ],
          );
  }
}
