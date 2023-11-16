import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:purugging/models/machine_model.dart';
import 'package:purugging/screens/plogging/plogging_working_screen.dart';
import 'package:purugging/services/google_map_services.dart';
import 'package:purugging/services/machine_services.dart';
import 'package:purugging/services/permission_services.dart';
import 'package:purugging/services/qr_services.dart';
import 'package:purugging/widgets/shared/google_map_widget.dart';
import 'package:purugging/widgets/plogging/plogging_denied_widget.dart';
import 'package:purugging/widgets/shared/large_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PloggingStartScreen extends StatefulWidget {
  const PloggingStartScreen({super.key});

  @override
  State<PloggingStartScreen> createState() => _PloggingStartScreenState();
}

class _PloggingStartScreenState extends State<PloggingStartScreen> {
  // 변수 - 위치 정보 권한
  late bool positionPermission = false;
  // 변수 - 구글맵 컨트롤러
  late final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  // 변수 - 현재 위치 정보
  late Future<LatLng> startPosition = GoogleMapServices.getCurrentPosition();
  // 변수 - 머신 정보 리스트
  List<Marker> markers = [];
  // 변수 - mqtt 관련
  final MqttClient mqttclient =
      MqttServerClient.withPort('k9a310.p.ssafy.io', 'start', 4883);
  // 변수 - QR관련 정보
  final qrTitle = '플로깅을 시작합니다';

  // 함수 - 현재 위치 권한 저장
  Future<void> handlePositionPermission() async {
    final hasPermission = await PermissionServices.getPositionPermissions();
    setState(() {
      positionPermission = hasPermission;
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

  // 함수 - 시작 QR 모달 띄우기
  Future<void> handleQRModal(context) async {
    // mqtt 연결
    await connectMqtt();
    if (mqttclient.connectionStatus?.state != MqttConnectionState.connected) {
      return;
    }
    // 맴버 id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? memberId = prefs.getInt('memberId');
    // 위치 서비스 활성화
    if (!await Geolocator.isLocationServiceEnabled()) {
      await PermissionServices.onPositionService(context);
      // 알람 활성화
    } else if (!await Permission.notification.status.isGranted) {
      await PermissionServices.getNotiPermission(context);
      // 현재 위치로 이동 후 QR창 열기
    } else {
      // 구글 맵 현재 위치로 포커스 이동
      final position = await GoogleMapServices.getCurrentPosition();
      await GoogleMapServices.handleMapCamera(position, _controller);
      // QR 창에 연결
      final qrData = jsonEncode({
        'request': 'plogging',
        'member-id': memberId,
        'plogging-status': 'PLOGGING_INCOMPLETE',
        'machine-id': 1
      });
      // mqtt 연결
      QRServices.showQRModal(context, qrTitle, qrData);
      // mqtt 메시지를 받으면 다음 스크린으로 이동 구현
      mqttclient.updates?.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        final result = c![0].payload as MqttPublishMessage;
        final payload = jsonDecode(
            MqttPublishPayload.bytesToStringAsString(result.payload.message));
        if (payload['member-id'] == memberId &&
            payload['message'] == 'initiation-success') {
          mqttclient.disconnect();
          QRServices.closeQRModal(context);
          handleMoveScreen(context);
        }
      });
    }
  }

  // 함수 - 플로깅 진행 중 스크린으로 이동
  Future<void> handleMoveScreen(context) async {
    // mqtt 플로우 추가해야합니다.
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PloggingWorkingScreen(),
          fullscreenDialog: true,
        ));
  }

  // 함수 - mqtt 연결
  Future<void> connectMqtt() async {
    // mqtt 상태 확인
    final mqttStatus = mqttclient.connectionStatus!.state;
    // mqtt 연결
    if (mqttStatus != MqttConnectionState.connected) {
      try {
        await mqttclient.connect();
        mqttclient.subscribe('Server', MqttQos.atLeastOnce);
      } catch (e) {
        return;
      }
    }
  }

  // init 라이프사이클
  @override
  void initState() {
    super.initState();
    mqttclient.disconnect();
    handlePositionPermission();
    loadMachineList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: positionPermission
            // 위치 정보 접근이 허용되었을 때
            ? Scaffold(
                // qr 버튼 파트
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: LargeButtonWidget(
                  title: '시작',
                  heroTag: 'qrButton',
                  icon: Icons.qr_code_2_outlined,
                  color: const Color(0xFFBADD7A),
                  textColor: Colors.black,
                  handleFunc: () => handleQRModal(context),
                ),
                // 맵 파트
                body: FutureBuilder(
                  future: startPosition,
                  builder: (context, snapShot) {
                    // 위치 정보가 불러와졌을 때
                    if (snapShot.hasData) {
                      return GoogleMapWidget(
                        controller: _controller,
                        startPosition: snapShot.data!,
                        followingUser: true,
                        polylines: const {},
                        markers: markers,
                      );
                      // 위치 정보를 불러오는 중
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              )
            // 위치 정보 접근이 허용되지 않았을 때
            : PloggingDeniedWidget(
                onRetry: () {
                  handlePositionPermission();
                },
              ));
  }
}
