import 'package:flutter/material.dart';
import 'package:purugging/widgets/shared/icon_button_widget.dart';

class CampaignHeaderWidget extends StatelessWidget {
  const CampaignHeaderWidget(
      {super.key,
      required this.isMine,
      required this.lightBtn,
      required this.rightBtn});

  final bool isMine;
  final Function() lightBtn;
  final Function() rightBtn;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.grey, offset: Offset(0, 2), blurRadius: 2)
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButtonWidget(
              handleFunc: () => lightBtn(),
              icon: Icons.add,
              size: 48,
              color: Colors.black),
          const Text(
            "캠페인 리스트",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          IconButtonWidget(
              handleFunc: () => rightBtn(),
              icon: isMine ? Icons.manage_accounts_outlined : Icons.list_alt,
              size: 48,
              color: Colors.black),
        ],
      ),
    );
  }
}
