import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:purugging/screens/plogging/plogging_photo_screen.dart';
import 'package:purugging/services/qr_services.dart';
import 'package:purugging/widgets/shared/large_button_widget.dart';
import 'package:purugging/widgets/shared/alert_dialog_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PloggingRecycleScreen extends StatefulWidget {
  const PloggingRecycleScreen({super.key});
  @override
  State<PloggingRecycleScreen> createState() => _PloggingRecycleScreenState();
}

class _PloggingRecycleScreenState extends State<PloggingRecycleScreen> {
  final MqttClient mqttclient =
      MqttServerClient.withPort('k9a310.p.ssafy.io', 'recycling', 4883);
  // 변수 - qr 관련
  final qrTitle = '분리수거를 완료합니다.';

  // 함수 - 분리수거 중단
  Future<void> giveupRecycling(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false, // 다이얼로그 이외의 바탕 눌러도 안꺼지도록 설정
        builder: (BuildContext context) {
          // 알림창
          return AlertDialogWidget(
            title: '분리수거 미완료',
            body: '분리수거가 완료되지않았습니다.\n정말 중단하시겠습니까?',
            handleAlert: () {
              Navigator.of(context).pop();
            },
          );
        });
  }

  // 함수 - QR 모달 띄우기
  Future<void> handleQRModal(context) async {
    // mqtt 연결
    await connectMqtt();
    if (mqttclient.connectionStatus!.state != MqttConnectionState.connected) {
      return;
    }
    // 맴버 id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? memberId = prefs.getInt('memberId');
    // QR 창에 연결
    final qrData = jsonEncode({
      'request': 'plogging',
      'member-id': memberId,
      'plogging-status': 'PLOGGIGNG_PENDING_COMPLETION',
      'machine-id': 1
    });
    // QR 창에 연결
    QRServices.showQRModal(context, qrTitle, qrData);
    // mqtt 메시지를 받으면 다음 스크린으로 이동 구현
    mqttclient.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final result = c![0].payload as MqttPublishMessage;
      final payload = jsonDecode(
          MqttPublishPayload.bytesToStringAsString(result.payload.message));
      if (payload['member-id'] == memberId &&
          payload['message'] == 'update-success') {
        int ploggingId = payload['plogging-id'];
        mqttclient.disconnect();
        QRServices.closeQRModal(context);
        handleMoveScreen(context, ploggingId);
      }
    });
  }

  // 함수 - 사진 촬영 스크린으로 이동
  Future<void> handleMoveScreen(context, int ploggingId) async {
    // mqtt 플로우 추가해야합니다.
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PloggingPhotoScreen(
            ploggingId: ploggingId,
          ),
          fullscreenDialog: true,
        ));
  }

  // 함수 - mqtt 연결
  Future<void> connectMqtt() async {
    // mqtt 상태 확인
    final mqttStatus = mqttclient.connectionStatus!.state;
    // mqtt 연결
    if (mqttStatus != MqttConnectionState.connected) {
      await mqttclient.connect();
      mqttclient.subscribe('Server', MqttQos.atLeastOnce);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // 뒤로가기 키가 눌렸을 때 처리할 로직
        giveupRecycling(context);
        return false;
      },
      child: Scaffold(
          backgroundColor: const Color(0xFFFCFCF3),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: LargeButtonWidget(
            title: "완료",
            heroTag: "qrButton",
            icon: Icons.qr_code_2_outlined,
            color: const Color(0xFFBADD7A),
            textColor: Colors.black,
            handleFunc: () => handleQRModal(context),
          ),
          body: Padding(
            padding: const EdgeInsets.only(bottom: 120),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40)),
                      height: 500,
                      width: 300,
                      child: Image.asset('assets/image/recycle_image.jpg')),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "캔과 병, 나머지 재활용, 일반\n 위 세 부류로 분리수거해주세요",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'KCC'),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
