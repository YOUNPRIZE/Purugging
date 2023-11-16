import 'package:flutter/material.dart';
import 'package:purugging/models/campaign_model.dart';
import 'package:purugging/screens/campaign/campaign_create_screen.dart';
import 'package:purugging/services/campaign_services.dart';
import 'package:purugging/widgets/campaign/campaign_list/campaign_header_widget.dart';
import 'package:purugging/widgets/campaign/campaign_list/campaign_list_item_widget.dart';
import 'package:purugging/widgets/campaign/campaign_list/pagination_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CampaignListScreen extends StatefulWidget {
  const CampaignListScreen({super.key});

  @override
  State<CampaignListScreen> createState() => _CampaignListScreenState();
}

class _CampaignListScreenState extends State<CampaignListScreen> {
  // 변수 - 캠페인 관련
  List<CampaignModel> campaignList = [];
  // 변수 - 캠페인 필터
  int filterStatus = 0;
  String filterString = "전체";
  // 변수 - 페이지 관련
  int page = 1;
  int maxPage = 1;
  // 변수 - 필터 관련
  bool isMine = false;
  // 변수 - 유저 id
  int? memberId;

  // 함수 - 캠페인 추가 페이지로 이동
  Future<void> handleMoveScreen(context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CampaignCreateScreen(),
          fullscreenDialog: true,
        )).then((value) {
      handlePage(page);
    });
  }

  // 함수 - 페이지 이동하며 캠페인 불러오기
  Future<void> handlePage(int newPage) async {
    if (newPage < 1 || newPage > maxPage) return;
    final result = isMine
        ? await CampaignServices.loadMine(newPage)
        : await CampaignServices.loadCampaigns(newPage);
    setState(() {
      campaignList = result['campaigns'];
      maxPage = result['pagination']['totalPages'];
      page = newPage;
    });
  }

  // 함수 - 유저 정보 불러오기
  Future<void> loadMemberId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    memberId = prefs.getInt('memberId');
  }

  // 함수 - 캠페인 리스트 필터링
  Future<void> handleFilter() async {
    setState(() {
      isMine = !isMine;
    });
    await handlePage(1);
  }

  @override
  void initState() {
    super.initState();
    loadMemberId();
    handlePage(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFCF3),
      body: Column(
        children: [
          // 헤더
          CampaignHeaderWidget(
            isMine: isMine,
            lightBtn: () => handleMoveScreen(context),
            rightBtn: () => handleFilter(),
          ),
          // 가로선
          Divider(
              thickness: 1.5, height: 1, color: Colors.grey.withOpacity(0.4)),
          // 캠페인 리스트
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              scrollDirection: Axis.vertical,
              itemCount: campaignList.length,
              itemBuilder: (context, index) {
                var campaign = campaignList[index];
                return CampaignListItem(
                  memberId: memberId,
                  campaign: campaign,
                  resetPage: () => handlePage(page),
                );
              },
            ),
          ),
          // 가로선
          Divider(
              thickness: 1.5, height: 1, color: Colors.grey.withOpacity(0.4)),
          const SizedBox(
            height: 10,
          ),
          PaginationButtonWidget(
            page: page,
            maxPage: maxPage,
            handlePage: handlePage,
          ),
          const SizedBox(
            height: 44,
          ),
        ],
      ),
    );
  }
}
