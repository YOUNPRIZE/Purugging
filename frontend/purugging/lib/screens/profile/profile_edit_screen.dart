import 'package:flutter/material.dart';
import 'package:purugging/models/user_model.dart';
import 'package:purugging/services/member_services.dart';
import 'package:purugging/widgets/shared/elevated_button_widget.dart';
import 'package:purugging/widgets/start/signup/input_name_widget.dart';
import 'package:purugging/widgets/start/signup/input_nickname_widget.dart';
import 'package:purugging/widgets/start/signup/input_phone_widget.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen(
      {super.key, required this.handleUserData, required this.user});
  final Function() handleUserData;
  final UserModel user;

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  // 변수 - 입력 컨트롤러
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  // 변수 - 입력 포커스
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode nicknameFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  // 변수 - 중복 여부
  bool duplicateNickname = false;
  bool duplicateNumber = false;

  // 함수 - 회원가입 진행
  Future<void> handleSingup(context) async {
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
    } else if (nicknameController.text != widget.user.nickname &&
        !await MemberServices.checkNickname(nicknameController.text)) {
      nicknameFocusNode.requestFocus();
      setState(() {
        duplicateNickname = true;
      });
      // 전화번호 중복 검증
    } else if (phoneController.text != widget.user.phone_number &&
        !await MemberServices.checkPhone(phoneController.text)) {
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
      };
      bool result = await MemberServices.editInfo(memberData);
      if (result) {
        await widget.handleUserData();
        Navigator.pop(context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.user.name;
    nicknameController.text = widget.user.nickname;
    phoneController.text = widget.user.phone_number!;
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
          '회원정보 수정',
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
              duplicateNickname: duplicateNickname),
          const SizedBox(height: 32),
          InputPhoneWidget(
              controller: phoneController,
              focusNode: phoneFocusNode,
              duplicateNumber: duplicateNumber),
          const SizedBox(height: 48),
          ElevatedButtonWidget(
            title: '완료',
            txtSize: 20,
            handleFunc: () => handleSingup(context),
          ),
        ],
      ),
    );
  }
}
