import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:purugging/models/campaign_model.dart';
import 'package:purugging/screens/campaign/campaign_patch_screen.dart';
import 'package:purugging/services/campaign_services.dart';
import 'package:purugging/widgets/campaign/campaign_detail/attendance_drawer_widget.dart';
import 'package:purugging/widgets/campaign/campaign_detail/campaign_content_widget.dart';
import 'package:purugging/widgets/campaign/campaign_detail/campaign_title_widget.dart';
import 'package:purugging/widgets/campaign/campaign_shared/campaign_participan_widget.dart';
import 'package:purugging/widgets/shared/alert_dialog_widget.dart';
import 'package:purugging/widgets/shared/icon_button_widget.dart';
import 'package:purugging/widgets/shared/info_header_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CampaignDetailScreen extends StatefulWidget {
  // 생성자
  const CampaignDetailScreen({super.key, required this.campaign});
  // 변수 - 캠페인 정보
  final CampaignModel campaign;
  @override
  State<CampaignDetailScreen> createState() => _CampaignDetailScreenState();
}

class _CampaignDetailScreenState extends State<CampaignDetailScreen> {
  // 변수 - 맴버 아이디
  int? memberId;
  // 변수 - 캠페인 정보
  CampaignModel? campaign;
  // 변수 - 참여 유저 정보
  List members = [];
  // 변수 - 참석 여부
  bool isAttendance = false;
  // 글로벌 키
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // 함수 - 맴버 id 불러오기
  Future<void> loadMemberId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      memberId = prefs.getInt('memberId');
      campaign = widget.campaign;
    });
  }

  // 함수 - 해당 캠페인 정보 갱신
  Future<void> resetCampaign() async {
    CampaignModel? campaignInfo =
        await CampaignServices.loadCampaign(widget.campaign.campaign_id);
    if (campaignInfo != null) {
      setState(() {
        campaign = campaignInfo;
      });
    }
  }

  // 참여 유저 정보 로드
  Future<void> loadMembers() async {
    List result =
        await CampaignServices.loadMembers(widget.campaign.campaign_id);
    setState(() {
      members = result;
      // 참여 유저인지 판단
      for (final member in members) {
        if (member['member_id'] == memberId) {
          isAttendance = true;
          return;
        }
      }
      isAttendance = false;
    });
  }

  // 함수 - 해당 캠페인 삭제
  Future<void> deleteCampaign(context) async {
    bool result =
        await CampaignServices.deleteCampaign(widget.campaign.campaign_id);
    if (result) {
      Navigator.of(context).pop();
    }
  }

  // 함수 - 캠페인 수정 페이지로 이동
  Future<void> handlePatchScreen(context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CampaignPatchScreen(
            campaignInfo: campaign!,
          ),
          fullscreenDialog: true,
        )).then((value) {
      resetCampaign();
      loadMembers();
    });
  }

  // 함수 - 캠페인 삭제 알람
  Future<void> deleteWarning() async {
    return showDialog(
        context: context,
        barrierDismissible: false, // 다이얼로그 이외의 바탕 눌러도 안꺼지도록 설정
        builder: (BuildContext context) {
          // 알림창
          return AlertDialogWidget(
            title: '캠페인 삭제',
            body: '정말로 캠페인을 삭제하시겠습니까?',
            handleAlert: () async {
              await deleteCampaign(context);
            },
          );
        });
  }

  // 함수 - 캠페인 참가하기
  Future<void> addAttendance() async {
    bool result =
        await CampaignServices.addAttendance(widget.campaign.campaign_id);
    if (result) {
      await resetCampaign();
      await loadMembers();
    }
  }

  // 함수 - 캠페인 참가 취소
  Future<void> deleteAttendance() async {
    bool result =
        await CampaignServices.deleteAttendance(widget.campaign.campaign_id);
    if (result) {
      await resetCampaign();
      await loadMembers();
    }
  }

  // 함수 - 캠페인 참가 승인
  Future<void> approval(int attendantId) async {
    bool result = await CampaignServices.approval(
        attendantId, widget.campaign.campaign_id);
    if (result) {
      await loadMembers();
    }
  }

  @override
  void initState() {
    super.initState();
    loadMemberId();
    loadMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFCFCF3),
        key: _scaffoldKey,
        endDrawer: AttendanceDrawerWidget(
            members: members,
            approve: () {},
            removal: () {},
            approval: approval),
        body: memberId != null && campaign != null
            ? Flex(
                direction: Axis.vertical,
                children: [
                  // 헤더
                  InfoHeaderWidget(
                      titleTxt: Text(
                    DateFormat('yyyy-MM-dd').format(campaign!.date),
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic),
                  )),
                  // 타이틀
                  CampaignTitleWidget(title: campaign!.title),
                  Divider(
                      thickness: 1.5,
                      height: 1,
                      color: Colors.grey.withOpacity(0.4)),
                  // 본문
                  CampaignContentWidget(content: campaign!.content),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: CampaignParticipantWidget(
                        campaign: campaign!, size: 36),
                  ),
                  Divider(
                      thickness: 1.5,
                      height: 1,
                      color: Colors.grey.withOpacity(0.4)),
                  // 푸터
                  Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0, -1),
                                blurRadius: 2)
                          ]),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 30),
                      child:
                          // 현재 유저가 만든 캠페인일 경우
                          memberId == widget.campaign.member_id
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                      IconButtonWidget(
                                        handleFunc: () => deleteWarning(),
                                        icon: Icons.delete_forever,
                                        size: 52,
                                        color: Colors.black,
                                      ),
                                      IconButtonWidget(
                                        handleFunc: () =>
                                            handlePatchScreen(context),
                                        icon: Icons.edit_document,
                                        size: 52,
                                        color: Colors.black,
                                      ),
                                      IconButtonWidget(
                                        handleFunc: () {
                                          _scaffoldKey.currentState
                                              ?.openEndDrawer();
                                        },
                                        icon: Icons.people_outline_outlined,
                                        size: 52,
                                        color: Colors.black,
                                      )
                                    ])
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                      isAttendance
                                          ? IconButtonWidget(
                                              handleFunc: () =>
                                                  deleteAttendance(),
                                              icon: Icons.person_off_outlined,
                                              size: 52,
                                              color: Colors.black,
                                            )
                                          : IconButtonWidget(
                                              handleFunc: () => addAttendance(),
                                              icon: Icons.person_add_alt,
                                              size: 52,
                                              color: Colors.black,
                                            ),
                                    ]))
                ],
              )
            : const Center(child: CircularProgressIndicator()));
  }
}
