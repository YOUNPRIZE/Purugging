import 'package:flutter/material.dart';
import 'package:purugging/models/plogging_model.dart';
import 'package:purugging/screens/profile/history_detail_screen.dart';
import 'package:purugging/screens/profile/history_list_screen.dart';
import 'package:purugging/widgets/profile/profile_footer/footer_image_widget.dart';
import 'package:purugging/widgets/profile/profile_footer/footer_info_widget.dart';
import 'package:purugging/widgets/shared/icon_button_widget.dart';

class ProfileFooterWidget extends StatelessWidget {
  final List<PloggingModel> ploggingList;

  ProfileFooterWidget({super.key, required this.ploggingList}) {
    ploggingList.sort((a, b) => b.created_at.compareTo(a.created_at));
  }

  // 함수 - 히스토리 목록 스크린으로 이동
  void handleMoveList(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HistoryListScreen(
            ploggingList: ploggingList,
          ),
          fullscreenDialog: true,
        ));
  }

  // 함수 - 히스토리 목록 스크린으로 이동
  void handleMoveDetail(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HistoryDetailScreen(
            ploggingInfo: ploggingList[0],
          ),
          fullscreenDialog: true,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.grey, offset: Offset(0, 2), blurRadius: 5)
        ],
      ),
      child: Stack(children: [
        // 플로깅 이미지
        FooterImageWidget(plogging: ploggingList[0]),
        // 최근 플로깅 타이틀
        const Positioned(
          top: 20,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              '최근 플로깅',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        // 최근 플로깅 정보
        FooterInfoWidget(plogging: ploggingList[0]),
        // 이동 버튼
        Positioned(
          left: 0,
          right: 0,
          bottom: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButtonWidget(
                  handleFunc: () => handleMoveDetail(context),
                  icon: Icons.info_outline,
                  size: 48,
                  color: Colors.grey.shade800),
              IconButtonWidget(
                  handleFunc: () => handleMoveList(context),
                  icon: Icons.list_alt,
                  size: 48,
                  color: Colors.grey.shade800)
            ],
          ),
        )
      ]),
    );
  }
}
