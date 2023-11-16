import 'package:flutter/material.dart';
import 'package:purugging/models/plogging_model.dart';
import 'package:purugging/widgets/profile/plogging_item_widget.dart';
import 'package:purugging/widgets/shared/info_header_widget.dart';

class HistoryListScreen extends StatelessWidget {
  // 생성자
  const HistoryListScreen({super.key, required this.ploggingList});

  // 변수 - 플로깅 정보
  final List<PloggingModel> ploggingList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFCF3),
      body: Column(
        children: [
          // 상단부
          const InfoHeaderWidget(
              titleTxt: Text(
            "플로깅 히스토리",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
          )),
          // 히스토리 리스트
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: ploggingList.length,
              itemBuilder: (context, index) {
                var history = ploggingList[index];
                return Row(
                  children: [
                    PloggingItemWidget(
                      ploggingInfo: history,
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 20,
                );
              },
            ),
          ),
          const SizedBox(
            height: 80,
          )
        ],
      ),
    );
  }
}
