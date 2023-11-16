import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:purugging/models/campaign_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CampaignServices {
  // 메서드 - 해당 캠페인 조회하기
  static Future<CampaignModel?> loadCampaign(int id) async {
    try {
      var response = await http.get(
          Uri.https(
            'k9a310.p.ssafy.io',
            '/api/campaigns/$id',
          ),
          headers: <String, String>{
            'Content-Type': 'application/json',
          });
      // post 성공 시
      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes))['data'];
        CampaignModel campaignInfo = CampaignModel(
          campaign_id: result['id'],
          member_id: result['writer_id'],
          max_participant: result['max_participant_number'],
          cur_participant: result['current_participant_number'],
          title: result['title'],
          content: result['content'],
          date: DateTime.parse(result['date']),
        );
        return campaignInfo;
        // post 실패 시
      } else {
        throw Error();
      }
      // 에러 발생시
    } catch (e) {
      return null;
    }
  }

  // 메서드 - 캠페인 데이터 불러오기
  static Future loadCampaigns(int page) async {
    try {
      var response = await http.get(
        Uri.https('k9a310.p.ssafy.io', '/api/campaigns',
            {'page': page.toString(), 'size': '10'}),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      // post 성공 시
      if (response.statusCode == 200) {
        List<CampaignModel> campaigns = [];
        final result = jsonDecode(utf8.decode(response.bodyBytes))['data'];
        for (final campaign in result['contents']) {
          // if (campaign['campaign_status'] != 'CAMPAIGN_ACTIVE') {continue;}
          final item = CampaignModel(
            campaign_id: campaign['id'],
            member_id: campaign['writer_id'],
            max_participant: campaign['max_participant_number'],
            cur_participant: campaign['current_participant_number'],
            title: campaign['title'],
            content: campaign['content'],
            date: DateTime.parse(campaign['date']),
          );
          campaigns.add(item);
        }
        return {'campaigns': campaigns, 'pagination': result['page_info']};
        // post 실패 시
      } else {
        throw Error();
      }
      // 에러 발생시
    } catch (e) {
      return {
        'campaigns': [],
        'pagination': {
          "page": 1,
          "size": 10,
          "totalElements": 0,
          "totalPages": 1
        }
      };
    }
  }

  // 메서드 - 내 캠페인 불러오기
  static Future loadMine(int page) async {
    // 맴버 id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? memberId = prefs.getInt('memberId');
    try {
      var response = await http.get(
        Uri.https('k9a310.p.ssafy.io', '/api/campaigns/writer', {
          'page': page.toString(),
          'size': '10',
          'memberId': memberId.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      // post 성공 시
      if (response.statusCode == 200) {
        List<CampaignModel> campaigns = [];
        final result = jsonDecode(utf8.decode(response.bodyBytes))['data'];
        for (final campaign in result['contents']) {
          // if (campaign['campaign_status'] != 'CAMPAIGN_ACTIVE') {continue;}
          final item = CampaignModel(
            campaign_id: campaign['id'],
            member_id: campaign['writer_id'],
            max_participant: campaign['max_participant_number'],
            cur_participant: campaign['current_participant_number'],
            title: campaign['title'],
            content: campaign['content'],
            date: DateTime.parse(campaign['date']),
          );
          campaigns.add(item);
        }
        return {'campaigns': campaigns, 'pagination': result['page_info']};
        // post 실패 시
      } else {
        throw Error();
      }
      // 에러 발생시
    } catch (e) {
      return {
        'campaigns': [],
        'pagination': {
          "page": 1,
          "size": 10,
          "totalElements": 0,
          "totalPages": 1
        }
      };
    }
  }

  // 메서드 - 캠페인 개최
  static Future<bool> createCampaign(capaign) async {
    // 맴버 id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? memberId = prefs.getInt('memberId');
    try {
      var response = await http.post(
          Uri.https('k9a310.p.ssafy.io', '/api/campaigns',
              {'memberId': memberId.toString()}),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(capaign));
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

  // 메서드 - 캠페인 삭제
  static Future<bool> deleteCampaign(int id) async {
    try {
      var response = await http.delete(
          Uri.https(
            'k9a310.p.ssafy.io',
            '/api/campaigns/$id',
          ),
          headers: <String, String>{
            'Content-Type': 'application/json',
          });
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

  // 메서드 - 캠페인 수정
  static Future<bool> patchCampaign(capaign, int id) async {
    try {
      var response = await http.patch(
          Uri.https(
            'k9a310.p.ssafy.io',
            '/api/campaigns/$id',
          ),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(capaign));
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

  // 메서드 - 캠페인 참석자 명단 불러오기
  static Future<List> loadMembers(int id) async {
    // 맴버 id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? memberId = prefs.getInt('memberId');
    try {
      var response = await http.get(
        Uri.https('k9a310.p.ssafy.io', '/api/campaigns/attendance/$id',
            {'memberId': memberId.toString(), 'page': '1', 'size': '50'}),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      // post 성공 시
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body)['data']['contents'];
        return result;
      } else {
        return [];
      }
    }
    // 에러 발생시
    catch (e) {
      return [];
    }
  }

  // 메서드 - 캠페인 참가
  static Future<bool> addAttendance(int id) async {
    // 맴버 id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? memberId = prefs.getInt('memberId');
    try {
      var response = await http.post(
        Uri.https('k9a310.p.ssafy.io', '/api/campaigns/attendance/$id', {
          'memberId': memberId.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      // post 성공 시
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }
    // 에러 발생시
    catch (e) {
      return false;
    }
  }

  // 메서드 - 캠페인 취소
  static Future<bool> deleteAttendance(int id) async {
    // 맴버 id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? memberId = prefs.getInt('memberId');
    try {
      var response = await http.delete(
        Uri.https('k9a310.p.ssafy.io', '/api/campaigns/attendance/$id', {
          'memberId': memberId.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      // post 성공 시
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }
    // 에러 발생시
    catch (e) {
      return false;
    }
  }

  // 메서드 - 캠페인 참여 승인
  static Future<bool> approval(int attendantId, int campaignId) async {
    // 맴버 id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? memberId = prefs.getInt('memberId');
    try {
      var response = await http.patch(
          Uri.https('k9a310.p.ssafy.io', '/api/campaigns/attendance/approval', {
            'memberId': memberId.toString(),
          }),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "attendant_id": attendantId,
            "campaign_id": campaignId
          }));
      // post 성공 시
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }
    // 에러 발생시
    catch (e) {
      return false;
    }
  }
}
