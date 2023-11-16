import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  final String title, body;
  final Function() handleAlert;
  const AlertDialogWidget({
    super.key,
    required this.title,
    required this.body,
    required this.handleAlert,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text(body),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('취소'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('확인'),
          onPressed: () async {
            Navigator.of(context).pop();
            handleAlert();
          },
        ),
      ],
    );
  }
}
