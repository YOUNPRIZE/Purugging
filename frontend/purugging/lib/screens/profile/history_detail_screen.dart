import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:purugging/models/plogging_model.dart';
import 'package:purugging/services/time_services.dart';
import 'package:purugging/widgets/profile/profile_detail/detail_image_widget.dart';
import 'package:purugging/widgets/profile/profile_detail/detail_info_widget.dart';
import 'package:purugging/widgets/profile/profile_detail/detail_map_widget.dart';
import 'package:purugging/widgets/shared/info_header_widget.dart';

class HistoryDetailScreen extends StatelessWidget {
  // 생성자
  const HistoryDetailScreen({super.key, required this.ploggingInfo});
  final PloggingModel ploggingInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFCFCF3),
        body: SingleChildScrollView(
          child: Column(children: [
            // 상단부
            InfoHeaderWidget(
                titleTxt: Text(
              DateFormat('yyyy-MM-dd').format(ploggingInfo.updated_at),
              style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic),
            )),
            Divider(
                thickness: 1.5, height: 1, color: Colors.grey.withOpacity(0.4)),
            // 플로깅 기록 상세 내용
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                children: [
                  // 무게 정보
                  Text(
                    '${(ploggingInfo.distance / 1000).toStringAsFixed(2)} Km',
                    style: const TextStyle(
                      fontSize: 42,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  // 상세 정보 1번째 줄
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DetailInfoWidget(
                          category: '총 이동 시간',
                          info: TimeServices.timePlogging(
                              ploggingInfo.created_at,
                              ploggingInfo.updated_at)),
                      DetailInfoWidget(
                          category: '시작 시간',
                          info: DateFormat('HH:mm')
                              .format(ploggingInfo.created_at)),
                      DetailInfoWidget(
                          category: '종료 시간',
                          info: DateFormat('HH:mm')
                              .format(ploggingInfo.updated_at)),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // 상세 정보 2번째 줄
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DetailInfoWidget(
                          category: '쓰레기 무게',
                          info: '${ploggingInfo.general_trash_weight}Kg'),
                      DetailInfoWidget(
                          category: '페트병 개수',
                          info: '${ploggingInfo.pet_count}개'),
                      DetailInfoWidget(
                          category: '캔 개수', info: '${ploggingInfo.can_count}개'),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  // 플로깅 이미지
                  DetailImageWidget(
                    image: ploggingInfo.plogging_image,
                    ploggingId: ploggingInfo.plogging_id,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  // 지도 정보
                  DetailMapWidget(ploggingInfo: ploggingInfo),
                ],
              ),
            ),
          ]),
        ));
  }
}
