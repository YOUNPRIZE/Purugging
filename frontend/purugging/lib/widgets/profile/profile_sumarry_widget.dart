import 'package:flutter/material.dart';
import 'package:purugging/models/user_model.dart';
import 'package:purugging/widgets/profile/profile_summary/plogging_cnt_widget.dart';

class ProfileSummaryWidget extends StatelessWidget {
  const ProfileSummaryWidget({
    super.key,
    required this.user,
  });

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.grey, offset: Offset(2, 2), blurRadius: 10)
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        PloggingCntWidget(
          imgUrl: 'assets/logo/logo.png',
          cnt: user!.plogging_cnt.toString(),
          category: '번의 플로깅',
        ),
        const SizedBox(
          height: 14,
        ),
        PloggingCntWidget(
          imgUrl: 'assets/logo/trash.png',
          cnt: user!.cum_weight.toStringAsFixed(2),
          category: 'Kg의 쓰레기',
        ),
        const SizedBox(
          height: 14,
        ),
        PloggingCntWidget(
          imgUrl: 'assets/logo/pet.png',
          cnt: user!.cum_pet.toString(),
          category: '개의 병',
        ),
        const SizedBox(
          height: 14,
        ),
        PloggingCntWidget(
          imgUrl: 'assets/logo/can.png',
          cnt: user!.cum_can.toString(),
          category: '개의 캔',
        ),
      ]),
    );
  }
}
