import 'package:flutter/material.dart';
import 'package:purugging/models/plogging_model.dart';
import 'package:purugging/screens/profile/history_list_screen.dart';
import 'package:purugging/widgets/profile/plogging_item_widget.dart';

class ProfileFooterWidget extends StatelessWidget {
  final List<PloggingModel> ploggingList;

  ProfileFooterWidget({super.key, required this.ploggingList}) {
    ploggingList.sort((a, b) => b.created_at.compareTo(a.created_at));
  }

  // 함수 - 히스토리 목록 스크린으로 이동
  void handleMoveScreen(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HistoryListScreen(
            ploggingList: ploggingList,
          ),
          fullscreenDialog: true,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 상단 가이드 텍스트
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '최근 플로깅',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              TextButton(
                onPressed: () => handleMoveScreen(context),
                style: const ButtonStyle(),
                child: const Text(
                  '모두 보기 >',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w900),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        // 최근 플로깅 아이템
        PloggingItemWidget(ploggingInfo: ploggingList[0]),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
