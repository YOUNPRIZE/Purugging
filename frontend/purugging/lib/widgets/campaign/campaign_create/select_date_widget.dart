import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:purugging/widgets/shared/border_text_widget.dart';

class SelectDateWidget extends StatelessWidget {
  const SelectDateWidget({
    super.key,
    required this.date,
    required this.handleDateSelect,
    required this.handleTimeSelect,
  });

  final DateTime date;
  final Function() handleDateSelect;
  final Function() handleTimeSelect;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "시작 일시",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        // 날짜
        Row(
          children: [
            GestureDetector(
              onTap: () => handleDateSelect(),
              child: BorderTextWidget(
                  info: DateFormat('yy / MM / dd').format(date), txtSize: 18),
            ),
            const SizedBox(
              width: 10,
            ),
            // 시간
            GestureDetector(
                onTap: () => handleTimeSelect(),
                child: BorderTextWidget(
                    info: DateFormat('HH : mm').format(date), txtSize: 18)),
          ],
        )
      ],
    );
  }
}
