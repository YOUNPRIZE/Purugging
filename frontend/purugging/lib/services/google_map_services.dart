import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapServices {
  // 변수 - 기본 시작 위치(역삼 멀티캠퍼스)
  static LatLng basicLatLng = const LatLng(37.50126, 127.0396);
  // 변수 - 기본 줌
  static double basicZoom = 18;
  // 변수 - 마커 아이콘

  // 변수 - 안드로이드 지도 기본 설정
  static LocationSettings androidSettings = AndroidSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 8,
      forceLocationManager: true,
      intervalDuration: const Duration(seconds: 1),
      foregroundNotificationConfig: const ForegroundNotificationConfig(
        setOngoing: true,
        notificationTitle: "현재 플로깅 중입니다.",
        notificationText: "플로깅 중입니다! 플로깅 종료 후 앱을 닫아주세요.",
      ));

  // 함수 - 현재 위치 정보 로드
  static Future<LatLng> getCurrentPosition() async {
    late Position position;
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      return basicLatLng;
    }
    return LatLng(position.latitude, position.longitude);
  }

  // 함수 - 현재 위치로 카메라 이동
  static Future<void> handleMapCamera(
      LatLng position, Completer<GoogleMapController> mapController) async {
    final GoogleMapController controller = await mapController.future;
    final cameraPosition = CameraPosition(target: position, zoom: basicZoom);
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  // 함수 - 폴리 라인으로 변형
  static Polyline getPolyline(int distance, LatLng p1, LatLng p2) {
    final polyline = Polyline(
      polylineId: PolylineId(distance.toString()),
      visible: true,
      width: 5, //width of polyline
      points: [
        p1,
        p2,
      ],
      color: const Color(0xFFBADD7A), //color of polyline
    );
    return polyline;
  }

  // 함수 - 마커로 변형
  static Future<Marker> getMarker(
      LatLng position, String makerId, String message) async {
    final maker = Marker(
        markerId: MarkerId(makerId),
        position: position,
        icon: await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(
              // devicePixelRatio: 0.1,
              size: Size(32, 32),
            ),
            "assets/logo/start_logo.png"),
        infoWindow: InfoWindow(title: message));

    return maker;
  }
}
