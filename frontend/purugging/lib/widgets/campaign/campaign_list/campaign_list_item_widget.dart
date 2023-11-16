import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:purugging/models/campaign_model.dart';
import 'package:purugging/screens/campaign/campaign_detail_screen.dart';
import 'package:purugging/widgets/campaign/campaign_shared/campaign_participan_widget.dart';

class CampaignListItem extends StatelessWidget {
  // 생성자
  const CampaignListItem(
      {super.key,
      required this.campaign,
      required this.resetPage,
      required this.memberId});

  // 변수 - 캠페인 정보
  final CampaignModel campaign;
  final Function() resetPage;
  final int? memberId;

  // 함수 - 상세보기로 이동
  Future<void> handleMoveScreen(BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CampaignDetailScreen(
            campaign: campaign,
          ),
          fullscreenDialog: true,
        )).then((value) {
      resetPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () => handleMoveScreen(context),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  // 캠페인 타이틀
                  Text(
                    campaign.title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 날짜
                      Text(
                        DateFormat('yyyy-MM-dd').format(campaign.date),
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Colors.black),
                      ),
                      Row(
                        children: [
                          memberId == campaign.member_id
                              ? const Icon(
                                  Icons.assignment_ind_outlined,
                                  color: Colors.green,
                                )
                              : const SizedBox(
                                  width: 0,
                                ),
                          const SizedBox(
                            width: 10,
                          ),
                          CampaignParticipantWidget(
                              campaign: campaign, size: 20),
                        ],
                      )
                    ],
                  )
                ]),
              ],
            ),
          ),
        ),
        // 가로선
        Divider(thickness: 1.5, height: 1, color: Colors.grey.withOpacity(0.4)),
      ],
    );
  }
}
