import 'package:flutter/material.dart';

class CampaignButtonWidget extends StatelessWidget {
  const CampaignButtonWidget({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.campaign_outlined,
            size: 35,
            color: currentIndex == 0 ? Colors.green : Colors.black,
          ),
          Text(
            "캠페인",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: currentIndex == 0 ? Colors.green : Colors.black),
          )
        ],
      ),
    );
  }
}
