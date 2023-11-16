import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:purugging/models/machine_model.dart';
import 'package:http/http.dart' as http;

class MachineServices {
  // 메서드 - 머신 데이터 불러오기(시작/도착)
  static Future<MachineModel?> loadMachine(int machineId) async {
    try {
      var response = await http.get(
        Uri.https('k9a310.p.ssafy.io', '/api/machines/$machineId'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      // 성공 시
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body)['data'];
        MachineModel machineDate = MachineModel(
            machine_id: result['id'],
            bag_status: result['bag_capacity'],
            pet_status:
                result['pet_remaining_capacity'] / result['pet_total_capacity'],
            can_status:
                result['can_remaining_capacity'] / result['can_total_capacity'],
            trash_status: result['trash_remaining_capacity'] /
                result['trash_total_capacity'],
            machine_location: LatLng(result['machine_x'], result['machine_y']));
        return machineDate;
        // p실패 시
      } else {
        throw Error();
      }
      // 에러 발생시
    } catch (e) {
      return null;
    }
  }

  // 메서드 - 머신 데이터 전체 불러오기
  static Future<List<MachineModel>> loadMachineList() async {
    try {
      var response = await http.get(
        Uri.https('k9a310.p.ssafy.io', '/api/machines/'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      // 성공 시
      if (response.statusCode == 200) {
        final result =
            jsonDecode(utf8.decode(response.bodyBytes))['data']['details'];
        List<MachineModel> machineList = [];
        for (final item in result) {
          MachineModel machineDate = MachineModel(
              machine_id: item['id'],
              bag_status: item['bag_capacity'],
              pet_status: item['pet_remaining_capacity'] /
                  item['pet_total_capacity'] * 100,
              can_status: item['can_remaining_capacity'] /
                  item['can_total_capacity'] * 100,
              trash_status: item['trash_remaining_capacity'] /
                  item['trash_total_capacity'] * 100,
              machine_location: LatLng(item['machine_x'], item['machine_y']));
          machineList.add(machineDate);
        }
        return machineList;
        // p실패 시
      } else {
        throw Error();
      }
      // 에러 발생시
    } catch (e) {
      return [];
    }
  }
}
