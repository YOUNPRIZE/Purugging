import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:purugging/models/plogging_model.dart';
import 'package:purugging/models/user_model.dart';
import 'package:purugging/screens/profile/profile_edit_screen.dart';
import 'package:purugging/services/member_services.dart';
import 'package:purugging/services/plogging_services.dart';
import 'package:purugging/widgets/profile/drawer/grade_drawer_widget.dart';
import 'package:purugging/widgets/profile/drawer/profile_drawer_widget.dart';
import 'package:purugging/widgets/profile/profile_footer_widget.dart';
import 'package:purugging/widgets/profile/profile_header_widget.dart';
import 'package:purugging/widgets/profile/profile_sumarry_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // 변수 - 유저 관련
  UserModel? user;
  String basicProfilePhoto =
      "https://mblogthumb-phinf.pstatic.net/MjAyMDExMDFfMTgy/MDAxNjA0MjI4ODc1NDMw.Ex906Mv9nnPEZGCh4SREknadZvzMO8LyDzGOHMKPdwAg.ZAmE6pU5lhEdeOUsPdxg8-gOuZrq_ipJ5VhqaViubI4g.JPEG.gambasg/%EC%9C%A0%ED%8A%9C%EB%B8%8C_%EA%B8%B0%EB%B3%B8%ED%94%84%EB%A1%9C%ED%95%84_%ED%95%98%EB%8A%98%EC%83%89.jpg?type=w800";
  // 변수 - 플로깅 관련
  List<PloggingModel>? ploggingList;
  // 변수 - 이미지 피커 관련
  XFile? image;
  final ImagePicker picker = ImagePicker();

  // 함수 - 유저 데이터 불러오기
  Future<void> handleUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? memberId = prefs.getInt('memberId');
      UserModel? userData = await MemberServices.loadMyInfo(memberId!);
      setState(() {
        user = userData;
      });
    } catch (e) {
      return;
    }
  }

  // 함수 - 플로깅 데이터 불러오기
  Future<void> handlePloggingData() async {
    try {
      List<PloggingModel> ploggingListData =
          await PloggingServices.loadPloggings();
      setState(() {
        ploggingList = ploggingListData;
      });
    } catch (e) {
      return;
    }
  }

  // 함수 - 프로필 이미지 변경
  Future<void> handleEditImage(ImageSource imageSource) async {
    final XFile? pickedImage = await picker.pickImage(source: imageSource);
    if (pickedImage != null) {
      bool result = await MemberServices.editProfileImage(pickedImage.path);
      if (!result) return;
      await handleUserData();
    }
  }

  // 함수 - 회원 이미지 변경 페이지로 이동
  void handleMoveScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ProfileEditScreen(handleUserData: handleUserData, user: user!),
          fullscreenDialog: true,
        ));
  }

  // init 사이클
  @override
  void initState() {
    super.initState();
    try {
      handleUserData();
      handlePloggingData();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFCFCF3),
        drawer: const GradeDrawerWidget(),
        endDrawer: ProfileDrawerWidget(
          handleMoveScreen: () => handleMoveScreen(context),
        ),
        body: user != null && ploggingList != null
            ? Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 20, bottom: 40),
                child: Column(
                  children: [
                    // 상단부
                    ProfileHeaderWidget(
                        basicProfilePhoto: basicProfilePhoto,
                        user: user!,
                        handleEditImage: () =>
                            handleEditImage(ImageSource.gallery)),
                    const SizedBox(
                      height: 30,
                    ),
                    // 중단부
                    ProfileSummaryWidget(user: user),
                    const SizedBox(
                      height: 40,
                    ),
                    // 하단부
                    ploggingList!.isEmpty
                        ? const Text(
                            "플로깅 기록이 없습니다!",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w800),
                          )
                        : ProfileFooterWidget(
                            ploggingList: ploggingList!,
                          )
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
