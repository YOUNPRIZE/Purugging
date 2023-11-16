import 'package:flutter/material.dart';
import 'package:purugging/models/campaign_model.dart';

class CampaignParticipantWidget extends StatelessWidget {
  const CampaignParticipantWidget({
    super.key,
    required this.campaign,
    required this.size,
  });

  final CampaignModel campaign;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '${campaign.cur_participant} / ${campaign.max_participant}',
          style: TextStyle(
              fontSize: size,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              color: Colors.black),
        ),
      ],
    );
  }
}
