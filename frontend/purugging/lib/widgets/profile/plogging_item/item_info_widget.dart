import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:purugging/models/plogging_model.dart';

class ItemInfoWidget extends StatelessWidget {
  const ItemInfoWidget({
    super.key,
    required this.ploggingInfo,
  });

  final PloggingModel ploggingInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          DateFormat('yyyy-MM-dd').format(ploggingInfo.updated_at),
          style: const TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w900),
        ),
        Text(
          '${(ploggingInfo.distance / 1000).toStringAsFixed(2)}Km',
          style: const TextStyle(
              fontSize: 16,
              // fontFamily: 'KCC',
              fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
