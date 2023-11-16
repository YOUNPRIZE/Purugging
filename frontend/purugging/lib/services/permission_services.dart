import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:purugging/widgets/shared/alert_dialog_widget.dart';

class PermissionServices {
  // 메서드 - 위치정보 접근 허용
  static Future<bool> getPositionPermissions() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    // 위치 정보 접근 허용
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
    }
    // 위치 정보 접근을 차단했다면 권한 설정 페이지로 이동
    if (locationPermission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      locationPermission = await Geolocator.checkPermission();
    }

    return locationPermission == LocationPermission.whileInUse ||
        locationPermission == LocationPermission.always;
  }

  // 메서드 - 노티 알람 허용
  static Future<void> getNotiPermission(context) async {
    const notiPermission = Permission.notification;
    if (await notiPermission.status.isPermanentlyDenied) {
      await onNotiPermission(context);
    } else if (!await notiPermission.status.isGranted) {
      await notiPermission.request();
    }
  }

  // 메서드 - 위치 서비스 설정 창으로 이동
  static Future<void> onPositionService(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // 다이얼로그 이외의 바탕 눌러도 안꺼지도록 설정
      builder: (BuildContext context) {
        // 알림창
        return AlertDialogWidget(
          title: '위치 서비스가 필요합니다',
          body: '설정 창에서 위치 서비스를 켜주세요',
          handleAlert: () => Geolocator.openLocationSettings(),
        );
      },
    );
  }

  // 메서드 - 알람 설정창으로 이동
  static Future<void> onNotiPermission(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // 다이얼로그 이외의 바탕 눌러도 안꺼지도록 설정
      builder: (BuildContext context) {
        // 알림창
        return AlertDialogWidget(
          title: '알람 기능 권한이 필요합니다.',
          body: '설정 창에서 알람 권한을 허용해주세요.',
          handleAlert: () => openAppSettings(),
        );
      },
    );
  }
}
