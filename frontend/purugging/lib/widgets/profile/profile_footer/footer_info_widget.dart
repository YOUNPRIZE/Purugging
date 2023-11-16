import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:purugging/models/plogging_model.dart';

class FooterInfoWidget extends StatelessWidget {
  const FooterInfoWidget({
    super.key,
    required this.plogging,
  });

  final PloggingModel plogging;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Text(
            DateFormat('yyyy-MM-dd').format(plogging.updated_at),
            style: const TextStyle(
                fontSize: 26,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w900),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${(plogging.distance / 1000).toStringAsFixed(2)} Km',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
