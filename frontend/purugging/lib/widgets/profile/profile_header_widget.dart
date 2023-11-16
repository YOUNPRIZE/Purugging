import 'package:flutter/material.dart';
import 'package:purugging/models/user_model.dart';
import 'package:purugging/widgets/profile/profile_header/profile_grade_widget.dart';
import 'package:purugging/widgets/profile/profile_header/profile_image_widget.dart';
import 'package:purugging/widgets/profile/profile_header/profile_name_widget.dart';
import 'package:purugging/widgets/shared/icon_button_widget.dart';

class ProfileHeaderWidget extends StatefulWidget {
  const ProfileHeaderWidget(
      {super.key,
      required this.basicProfilePhoto,
      required this.user,
      required this.handleEditImage});

  final Function() handleEditImage;
  final String basicProfilePhoto;
  final UserModel user;

  @override
  State<ProfileHeaderWidget> createState() => _ProfileHeaderWidgetState();
}

class _ProfileHeaderWidgetState extends State<ProfileHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flex(
          direction: Axis.horizontal,
          children: [
            // 프로필 이미지
            ProfileImageWidget(
                photoUrl: widget.user.profile_image,
                handleEditImage: () => widget.handleEditImage()),
            const SizedBox(
              width: 15,
            ),
            // 닉네임 + 프로필 변경 버튼
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 닉네임
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfileNameWidget(
                      nickname: widget.user.nickname,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ProfileGradeWidget(user: widget.user),
                  ],
                ),
              ],
            ),
            const Flexible(fit: FlexFit.tight, child: SizedBox()),
            // 추가 설정
            IconButtonWidget(
                handleFunc: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: Icons.view_list_rounded,
                size: 48,
                color: Colors.black)
          ],
        ),
      ],
    );
  }
}
