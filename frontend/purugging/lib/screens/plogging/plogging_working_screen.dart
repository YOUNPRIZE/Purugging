import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:purugging/models/machine_model.dart';
import 'package:purugging/screens/plogging/plogging_recycle_screen.dart';
import 'package:purugging/services/google_map_services.dart';
import 'package:purugging/services/machine_services.dart';
import 'package:purugging/services/plogging_services.dart';
import 'package:purugging/services/qr_services.dart';
import 'package:purugging/widgets/shared/google_map_widget.dart';
import 'package:purugging/widgets/plogging/plogging_status_widget.dart';
import 'package:purugging/widgets/shared/large_button_widget.dart';
import 'package:purugging/widgets/shared/small_button_widget.dart';
import 'package:purugging/widgets/shared/alert_dialog_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PloggingWorkingScreen extends StatefulWidget {
  const PloggingWorkingScreen({super.key});
  @override
  State<PloggingWorkingScreen> createState() => _PloggingWorkingScreenState();
}

class _PloggingWorkingScreenState extends State<PloggingWorkingScreen> {
  // 변수 - 구글맵 컨트롤러
  late final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  // 변수 - 진행 시간 관련
  late Timer timer;
  int minutes = 0;
  String currentTime = '0시간 0분';
  DateTime startTime = DateTime.now();
  // 변수 - 이동거리 관련
  int distance = 0;
  String distanceText = '0.00 Km';
  // 변수 - 이동한 경로 관련
  Future<LatLng> currentPosition = GoogleMapServices.getCurrentPosition();
  late StreamSubscription<Position> positionStream;
  Set<Polyline> polylines = {};
  List<Map<String, double>> coordinates = [];
  // 변수 - 머신 정보 리스트
  List<Marker> markers = [];
  // 변수 - mqtt 관련
  final MqttClient mqttclient =
      MqttServerClient.withPort('k9a310.p.ssafy.io', 'jogging', 4883);
  // 변수 - QR 관련
  final qrTitle = "분리수거를 시작합니다";

  // 함수 - 진행 시간 표시 시작
  void handleRecordTime() {
    timer = Timer.periodic(const Duration(minutes: 1), (Timer timer) {
      setState(() {
        minutes++;
        currentTime = '${(minutes ~/ 60)}시간 ${(minutes % 60)}분';
      });
    });
  }

  // 함수 - 이동 거리 표시 시작
  void handleRecordDistance() async {
    // 시작 위치
    LatLng nowPosition = await currentPosition;
    coordinates.add({'x': nowPosition.latitude, 'y': nowPosition.longitude});
    // 이동 경로 표시
    positionStream = Geolocator.getPositionStream(
            locationSettings: GoogleMapServices.androidSettings)
        .listen((Position? position) {
      setState(() {
        // 새로운 위치
        final LatLng newPosition =
            LatLng(position!.latitude, position.longitude);
        coordinates.add({'x': position.latitude, 'y': position.longitude});
        // 거리값 재구성
        distance += 8;
        distanceText =
            '${distance ~/ 1000}.${(distance ~/ 10).toString().padLeft(2, '0')} Km';
        // 폴리라인 그리기
        polylines.add(
            GoogleMapServices.getPolyline(distance, nowPosition, newPosition));
        // 현재 위치 갱신
        nowPosition = newPosition;
      });
    });
  }

  // 함수 - 머신 마커 생성 로드
  Future<void> loadMachineList() async {
    List<MachineModel> result = await MachineServices.loadMachineList();
    for (MachineModel machine in result) {
      final Marker marker = await GoogleMapServices.getMarker(
          machine.machine_location,
          'machine${machine.machine_id}',
          "일반: ${machine.trash_status.toStringAsFixed(0)}% / 캔 ${machine.can_status.toStringAsFixed(0)}% / 플라스틱 ${machine.pet_status.toStringAsFixed(0)}%");
      setState(() {
        markers.add(marker);
      });
    }
  }

  // 함수 - 플로깅 포기
  Future<void> giveupPlogging(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false, // 다이얼로그 이외의 바탕 눌러도 안꺼지도록 설정
        builder: (BuildContext context) {
          // 알림창
          return AlertDialogWidget(
            title: '플로깅 미완료',
            body: '진행 중인 플로깅을 중단하시겠습니까?\n중단 시 현재까지 기록은 저장되지 않습니다.',
            handleAlert: () {
              Navigator.of(context).pop();
              stopPlogging();
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
      'plogging-status': 'PLOGGOGING_IN_PROGRESS',
      'machine-id': 1,
      'distance': distance
    });
    QRServices.showQRModal(context, qrTitle, qrData);
    // mqtt 메시지를 받으면 다음 스크린으로 이동 구현
    mqttclient.updates!
        .listen((List<MqttReceivedMessage<MqttMessage?>>? c) async {
      final result = c![0].payload as MqttPublishMessage;
      final payload = jsonDecode(
          MqttPublishPayload.bytesToStringAsString(result.payload.message));
      if (payload['member-id'] == memberId &&
          payload['message'] == 'termination-success') {
        // api 호출
        bool result = await PloggingServices.sendRoutes(coordinates, startTime);
        // api가 성공적으로 호출된 경우
        if (result) {
          mqttclient.disconnect();
          QRServices.closeQRModal(context);
          stopPlogging();
          handleMoveScreen(context);
        }
      }
    });
  }

  // 함수 - 분리수거 스크린으로 이동
  Future<void> handleMoveScreen(context) async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const PloggingRecycleScreen(),
          fullscreenDialog: true,
        ));
  }

  // 함수 - 플로깅 종료
  void stopPlogging() async {
    timer.cancel();
    positionStream.cancel();
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
    handleRecordTime();
    handleRecordDistance();
    loadMachineList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // 뒤로가기 키가 눌렸을 때 처리할 로직
        giveupPlogging(context);
        return false;
      },
      child: Scaffold(
          // 플로팅 버튼
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SmallButtonWidget(
                  title: "중단",
                  heroTag: "quitButton",
                  icon: Icons.logout_outlined,
                  color: Colors.black,
                  textColor: Colors.white,
                  handleFunc: () => giveupPlogging(context),
                ),
                LargeButtonWidget(
                  title: "완료",
                  heroTag: "qrButton",
                  icon: Icons.qr_code_2_outlined,
                  color: const Color(0xFFBADD7A),
                  textColor: Colors.black,
                  handleFunc: () => handleQRModal(context),
                ),
                const SizedBox(
                  width: 56,
                )
              ],
            ),
          ),
          body: FutureBuilder(
              future: currentPosition,
              builder: (context, snapShot) {
                if (snapShot.hasData) {
                  return Stack(
                    children: [
                      GoogleMapWidget(
                        controller: _controller,
                        startPosition: snapShot.data!,
                        followingUser: true,
                        polylines: polylines,
                        markers: markers,
                      ),
                      // 시간과 거리 표시
                      Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        child: PloggingStatusWidget(
                            distanceText: distanceText,
                            currentTime: currentTime),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              })),
    );
  }
}
