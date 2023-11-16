import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:purugging/models/plogging_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PloggingServices {
  // 메서드 - 플로깅 경로 저장
  static Future<bool> sendRoutes(coordinates, startTime) async {
    // 맴버 id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? memberId = prefs.getInt('memberId');
    // body 정리
    final geoJson = {
      "type": "Feature",
      "geometry": {"type": "LineString", "coordinates": coordinates},
      "properties": {
        "startTime": DateFormat("yyyy-MM-ddTHH:mm:ss'Z'").format(startTime),
        "endTime": DateFormat("yyyy-MM-ddTHH:mm:ss'Z'").format(DateTime.now())
      }
    };
    // api 호출
    try {
      var response = await http.post(
          Uri.https('k9a310.p.ssafy.io', '/api/ploggings/path',
              {'memberId': memberId.toString()}),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(geoJson));
      // post 성공 시
      if (response.statusCode == 200) {
        return true;
        // post 실패 시
      } else {
        throw Error();
      }
      // 에러 발생시
    } catch (e) {
      return false;
    }
  }

  // 메서드 - 플로깅 사진 저장
  static Future<bool> sendPhoto(String path) async {
    // 맴버 id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? memberId = prefs.getInt('memberId');
    // 요청 관련 변수들
    final uri = Uri.https('k9a310.p.ssafy.io', '/api/ploggings/image',
        {'memberId': memberId.toString()});
    final request = http.MultipartRequest('PATCH', uri);
    final file = await http.MultipartFile.fromPath('file', path);
    request.files.add(file);
    try {
      final response = await request.send();
      // post 성공 시
      if (response.statusCode == 200) {
        return true;
        // post 실패 시
      } else {
        throw Error();
      }
      // 에러 발생시
    } catch (e) {
      return false;
    }
  }

  // 메서드 - 플로깅 데이터 개별 불러오기
  static Future<PloggingModel?> loadPlogging(int ploggingId) async {
    // 맴버 id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? memberId = prefs.getInt('memberId');
    try {
      var response = await http.get(
        Uri.https('k9a310.p.ssafy.io', '/api/ploggings/$ploggingId',
            {'memberId': memberId.toString()}),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      // post 성공 시
      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes))['data'];
        final PloggingModel plogging = PloggingModel(
          plogging_id: result['plogging_id'],
          member_id: result['member_id'],
          start_machine_id: result['start_machine_id'],
          end_machine_id: result['end_machine_id'],
          created_at: DateTime.parse(result['create_date']),
          updated_at: DateTime.parse(result['update_date']),
          distance: result['distance'],
          pet_count: result['pet_count'],
          can_count: result['can_count'],
          general_trash_weight: result['general_trash_weight'],
          plogging_image: result['plogging_image']['imageUrl'],
        );
        return plogging;
        // post 실패 시
      } else {
        throw Error();
      }
      // 에러 발생시
    } catch (e) {
      return null;
    }
  }

  // 메서드 - 플로깅 데이터 전체 불러오기
  static Future<List<PloggingModel>> loadPloggings() async {
    // 맴버 id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? memberId = prefs.getInt('memberId');
    int page = 1;
    List<PloggingModel> resultList = [];
    try {
      while (true) {
        var response = await http.get(
          Uri.https('k9a310.p.ssafy.io', '/api/ploggings/list', {
            'memberId': memberId.toString(),
            'page': page.toString(),
            'size': '10'
          }),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
        );
        // post 성공 시
        if (response.statusCode == 200) {
          final result =
              jsonDecode(utf8.decode(response.bodyBytes))['data']['contents'];
          // 더 이상 데이터가 없으면 종료
          if (result.length == 0) return resultList;
          for (final plogging in result) {
            try {
              final history = PloggingModel(
                plogging_id: plogging['plogging_id'],
                member_id: plogging['member_id'],
                start_machine_id: plogging['start_machine_id'],
                end_machine_id: plogging['end_machine_id'],
                created_at: DateTime.parse(plogging['create_date']),
                updated_at: DateTime.parse(plogging['update_date']),
                distance: plogging['distance'],
                pet_count: plogging['pet_count'],
                can_count: plogging['can_count'],
                general_trash_weight: plogging['general_trash_weight'],
                plogging_image: plogging['plogging_image'] != null
                    ? plogging['plogging_image']['imageUrl']
                    : null,
              );
              resultList.add(history);
            } catch (e) {
              continue;
            }
          }
          page++;
          // post 실패 시
        } else {
          throw Error();
        }
      }
      // 에러 발생시
    } catch (e) {
      return resultList;
    }
  }

  // 메서드 - 경로 데이터 불러오기
  static Future loadRoutes(int ploggingId) async {
    try {
      var response = await http.get(
        Uri.https('k9a310.p.ssafy.io', '/api/ploggings/path', {
          'ploggingId': ploggingId.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      // post 성공 시
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body)['data'];
        return result;
        // post 실패 시
      } else {
        throw Error();
      }
      // 에러 발생시
    } catch (e) {
      return null;
    }
  }
}
