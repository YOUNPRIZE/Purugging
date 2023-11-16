import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:purugging/services/campaign_services.dart';
import 'package:purugging/widgets/campaign/campaign_create/input_content_widget.dart';
import 'package:purugging/widgets/campaign/campaign_create/input_number_widget.dart';
import 'package:purugging/widgets/campaign/campaign_create/select_date_widget.dart';
import 'package:purugging/widgets/campaign/campaign_create/input_title_widget.dart';
import 'package:purugging/widgets/shared/alert_dialog_widget.dart';
import 'package:purugging/widgets/shared/elevated_button_widget.dart';
import 'package:purugging/widgets/shared/info_header_widget.dart';

class CampaignCreateScreen extends StatefulWidget {
  const CampaignCreateScreen({super.key});

  @override
  State<CampaignCreateScreen> createState() => _CampaignCreateScreenState();
}

class _CampaignCreateScreenState extends State<CampaignCreateScreen> {
  // 변수 - 폼과 연결된 변수들
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  // 변수 - 입력 포커스
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode contentFocusNode = FocusNode();
  final FocusNode numberFocusNode = FocusNode();
  // 변수 - 날짜
  DateTime date = DateTime.now();

  // 함수 - 날짜 선택
  Future handleDateSelect(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (selectedDate == null) {
      return;
    }
    setState(() {
      date = selectedDate;
    });
  }

  // 함수 - 시간 선택
  Future handleTimeSelect(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: date.hour, minute: date.minute));
    if (selectedTime == null) {
      return;
    }
    final DateTime dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      selectedTime.hour,
      selectedTime.minute,
    );
    setState(() {
      date = dateTime; // date 변수를 업데이트 // timeOfDay 변수도 업데이트
    });
  }

  // 함수 - 캠페인 추가
  Future<void> createCampaign(context) async {
    if (titleController.text.isEmpty) {
      titleFocusNode.requestFocus();
    } else if (contentController.text.isEmpty) {
      contentFocusNode.requestFocus();
    } else if (numberController.text.isEmpty ||
        int.parse(numberController.text) > 50) {
      numberFocusNode.requestFocus();
    } else if (!DateTime.now().isBefore(date)) {
      return showDialog(
          context: context,
          barrierDismissible: false, // 다이얼로그 이외의 바탕 눌러도 안꺼지도록 설정
          builder: (BuildContext context) {
            // 알림창
            return AlertDialogWidget(
              title: '캠페인 날짜 오류',
              body: '개최 날짜는\n지금 시간 이후여야합니다.\n지금으로부터 일주일 후로\n설정하시겠습니까?',
              handleAlert: () {
                setState(() {
                  date = date.add(const Duration(days: 7));
                });
              },
            );
          });
    } else {
      bool result = await CampaignServices.createCampaign({
        "title": titleController.text, //String
        "content": contentController.text, //String
        "date": DateFormat("yyyy-MM-ddTHH:mm:ss")
            .format(date), //yyyy-MM-dd'T'HH:mm:ss
        "max_participant_number": int.parse(numberController.text) //Long
      });
      if (result) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFCFCF3),
        body: Column(
          children: [
            // 헤더
            const InfoHeaderWidget(
                titleTxt: Text(
              "캠페인 개최하기",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            )),
            // 입력창
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  children: [
                    // 제목 입력
                    InputTitleWidget(
                      controller: titleController,
                      focusNode: titleFocusNode,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // 내용 입력
                    InputContentWidget(
                      controller: contentController,
                      focusNode: contentFocusNode,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // 일시 입력
                    SelectDateWidget(
                      date: date,
                      handleDateSelect: () => handleDateSelect(context),
                      handleTimeSelect: () => handleTimeSelect(context),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // 최대 인원수 입력
                    InputNumberWidget(
                      controller: numberController,
                      focusNode: numberFocusNode,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: ElevatedButtonWidget(
                            title: '취소',
                            color: Colors.grey,
                            txtSize: 20,
                            handleFunc: () => Navigator.of(context).pop(),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: ElevatedButtonWidget(
                            title: '완료',
                            txtSize: 20,
                            handleFunc: () => createCampaign(context),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
