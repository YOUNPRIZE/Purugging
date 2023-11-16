import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:purugging/models/machine_model.dart';
import 'package:purugging/models/plogging_model.dart';
import 'package:purugging/services/google_map_services.dart';
import 'package:purugging/services/machine_services.dart';
import 'package:purugging/services/plogging_services.dart';
import 'package:purugging/widgets/shared/google_map_widget.dart';

class DetailMapWidget extends StatefulWidget {
  const DetailMapWidget({super.key, required this.ploggingInfo});

  final PloggingModel ploggingInfo;

  @override
  State<DetailMapWidget> createState() => _DetailMapWidgetState();
}

class _DetailMapWidgetState extends State<DetailMapWidget> {
  // 변수 - 구글맵 컨트롤러
  late final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  // 변수 - 시작, 도착 머신 정보
  MachineModel? startMachine;
  List<Marker> markers = [];
  // 변수 - 루트 정보
  Set<Polyline> polylines = {};

  // 함수 - 시작, 도착 머신 정보 로드
  Future<void> loadMachineInfos() async {
    int startId = widget.ploggingInfo.start_machine_id;
    int endId = widget.ploggingInfo.end_machine_id;
    // 출발지와 도착지가 같은 경우
    if (startId == endId) {
      MachineModel? startData = await MachineServices.loadMachine(startId);
      if (startData == null) return;
      final Marker startMarker = await GoogleMapServices.getMarker(
          startData.machine_location,
          'machine${startData.machine_id}',
          "출발과 도착");
      setState(() {
        startMachine = startData;
        markers.add(startMarker);
      });
      // 다른 경우
    } else {
      MachineModel? startData = await MachineServices.loadMachine(startId);
      MachineModel? endData = await MachineServices.loadMachine(endId);
      if (startData == null || endData == null) return;
      final Marker startMarker = await GoogleMapServices.getMarker(
          startData.machine_location,
          'machine${startData.machine_id}',
          "출발과 도착");
      final Marker endMarker = await GoogleMapServices.getMarker(
          endData.machine_location, 'machine${endData.machine_id}', "출발과 도착");
      setState(() {
        startMachine = startData;
        markers.add(startMarker);
        markers.add(endMarker);
      });
    }
  }

  // 함수 - 경로 데이터 불러오기
  Future loadRoutes() async {
    final result =
        await PloggingServices.loadRoutes(widget.ploggingInfo.plogging_id);
    if (result != null) {
      final routes = result['geometry']['coordinates'];
      for (var i = 0; i < routes.length - 1; i++) {
        LatLng start = LatLng(routes[i]['x'], routes[i]['y']);
        LatLng end = LatLng(routes[i + 1]['x'], routes[i + 1]['y']);
        // 폴리라인 그리기
        setState(() {
          polylines.add(GoogleMapServices.getPolyline(i, start, end));
        });
      }
    }
  }

  // 시작 라이프사이클
  @override
  void initState() {
    super.initState();
    loadMachineInfos();
    loadRoutes();
  }

  // 종료 라이프사이클
  @override
  void dispose() {
    super.dispose();
    _controller.future.then((controller) {
      controller.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
              spreadRadius: 4.0,
              offset: Offset(0, 3),
            ),
          ],
        ),
        height: 400,
        child: startMachine != null
            ? GoogleMapWidget(
                zoom: 15,
                controller: _controller,
                startPosition: startMachine!.machine_location,
                polylines: polylines,
                markers: markers,
                followingUser: false)
            : const Center(child: CircularProgressIndicator()));
  }
}
