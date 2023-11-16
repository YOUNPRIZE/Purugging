import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRServices {
  // 메서드 - QR 하단 모달창 보여주기
  static Future<dynamic> showQRModal(context, qrTitle, qrData) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 상단 부분
              Text(
                qrTitle,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              // QR 부분
              Container(
                padding: const EdgeInsets.all(20),
                height: 250,
                decoration: BoxDecoration(
                    color: const Color(0xFFBADD7A),
                    borderRadius: BorderRadius.circular(20)),
                child: QrImageView(
                  data: qrData,
                  version: QrVersions.auto,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              // 하단 부분
              const Text(
                "QR 코드를 스캐너에 인식시켜주세요.",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        );
      },
    );
  }

  // 메서드 - QR 하단 모달창 없애기
  static void closeQRModal(BuildContext context) {
    Navigator.of(context).pop();
  }
}
