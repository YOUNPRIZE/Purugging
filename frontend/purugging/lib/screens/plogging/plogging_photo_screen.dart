import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:purugging/models/plogging_model.dart';
import 'package:purugging/screens/main_screen.dart';
import 'package:purugging/screens/profile/history_detail_screen.dart';
import 'package:purugging/services/plogging_services.dart';
import 'package:purugging/widgets/shared/alert_dialog_widget.dart';
import 'package:purugging/widgets/shared/icon_button_widget.dart';

class PloggingPhotoScreen extends StatefulWidget {
  const PloggingPhotoScreen({super.key, required this.ploggingId});

  final int ploggingId;
  @override
  State<PloggingPhotoScreen> createState() => _PloggingPhotoScreenState();
}

class _PloggingPhotoScreenState extends State<PloggingPhotoScreen> {
  // 변수 - 이미지 피커 관련
  XFile? image;
  final ImagePicker picker = ImagePicker();

  // 함수 - 이미지 가져오기
  Future handlePickImage(ImageSource imageSource) async {
    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedImage = await picker.pickImage(source: imageSource);
    if (pickedImage != null) {
      setState(() {
        image = XFile(pickedImage.path); //가져온 이미지를 _image에 저장
      });
    }
  }

  // 함수 - 이미지 초기화
  Future handleResetImage() async {
    setState(() {
      image = null;
    });
  }

  // 함수 - 완료
  Future handleCheckPhoto(BuildContext context) async {
    late String title, body;
    if (image == null) {
      title = '사진 미선택';
      body = '사진을 선택하지 않았습니다. 이대로 진행하시겠습니까?';
    } else {
      title = '사진 선택 완료';
      body = '선택된 사진을 등록하시겠습니까?';
    }
    return showDialog(
        context: context,
        barrierDismissible: false, // 다이얼로그 이외의 바탕 눌러도 안꺼지도록 설정
        builder: (BuildContext context) {
          // 알림창
          return AlertDialogWidget(
            title: title,
            body: body,
            handleAlert: () async {
              bool result = true;
              if (image != null) {
                result = await PloggingServices.sendPhoto(image!.path);
              }
              if (result) {
                PloggingModel? ploggingInfo =
                    await PloggingServices.loadPlogging(widget.ploggingId);
                handleMoveScreen(ploggingInfo);
              }
            },
          );
        });
  }

  // 함수 - 분리수거 스크린으로 이동
  Future<void> handleMoveScreen(PloggingModel? ploggingInfo) async {
    // mqtt 플로우 추가해야합니다.
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ploggingInfo == null
              ? const MainScreen()
              : HistoryDetailScreen(ploggingInfo: ploggingInfo),
          fullscreenDialog: true,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          handleCheckPhoto(context);
          return false;
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFFCFCF3),
          body: Stack(
            children: [
              // 사진 표시
              Padding(
                  padding: const EdgeInsets.only(
                      bottom: 160, top: 30, left: 30, right: 30),
                  child: Center(
                    child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3,
                              spreadRadius: 1,
                              offset: Offset(1, 3),
                            ),
                          ],
                        ),
                        child: image != null
                            ? Image.file(File(image!.path))
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButtonWidget(
                                    size: 80,
                                    color: Colors.black,
                                    icon: Icons.add_circle_outline_outlined,
                                    handleFunc: () {},
                                  ),
                                  const Text(
                                    "플로깅 완료 기념 사진을\n업로드 해주세요!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              )),
                  )),
              // 버튼 네비게이터
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                        spreadRadius: 3.0,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButtonWidget(
                          size: 40,
                          color: Colors.black,
                          icon: Icons.restore_page_sharp,
                          handleFunc: () => handleResetImage(),
                        ),
                        IconButtonWidget(
                          size: 40,
                          color: Colors.black,
                          icon: Icons.photo_library,
                          handleFunc: () =>
                              handlePickImage(ImageSource.gallery),
                        ),
                        IconButtonWidget(
                          size: 40,
                          color: Colors.black,
                          icon: Icons.camera_alt,
                          handleFunc: () => handlePickImage(ImageSource.camera),
                        ),
                        IconButtonWidget(
                          size: 64,
                          color: Colors.green,
                          icon: Icons.check_circle_outline,
                          handleFunc: () => handleCheckPhoto(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
