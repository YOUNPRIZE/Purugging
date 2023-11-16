import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:purugging/models/plogging_model.dart';
import 'package:purugging/screens/profile/history_detail_screen.dart';
import 'package:purugging/widgets/profile/plogging_item/item_image_widget.dart';

class PloggingItemWidget extends StatelessWidget {
  // 생성자
  const PloggingItemWidget({super.key, required this.ploggingInfo});

  // 변수 - 플로깅 정보
  final PloggingModel ploggingInfo;

  // 함수 - 플로깅 상세정보 스크린으로 이동
  Future<void> handleMoveScreen(context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HistoryDetailScreen(
            ploggingInfo: ploggingInfo,
          ),
          fullscreenDialog: true,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => handleMoveScreen(context),
        child: Container(
          width: 300,
          height: 450,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(color: Colors.grey, offset: Offset(0, 2), blurRadius: 5)
            ],
          ),
          child: Stack(
            children: [
              // 이미지
              ItemImageWidget(
                  photo: ploggingInfo.plogging_image,
                  ploggingId: ploggingInfo.plogging_id),
              // 날짜
              Positioned(
                top: 150,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    DateFormat('yyyy-MM-dd').format(ploggingInfo.updated_at),
                    style: const TextStyle(
                        fontSize: 32,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              // 이동거리
              Positioned(
                bottom: 180,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    '${(ploggingInfo.distance / 1000).toStringAsFixed(2)} Km',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'JungChul',
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
