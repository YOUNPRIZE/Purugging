import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:purugging/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberServices {
  // 메서드 - 회원가입
  static Future<bool> signUp(memberData) async {
    try {
      var response = await http.post(
        Uri.parse('https://k9a310.p.ssafy.io/api/members/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode(memberData),
      );
      // post 성공 시
      if (response.statusCode == 200) {
        return true;
        // post 실패 시
      } else {
        // print(response.request.body);
        return false;
      }
      // 에러 발생시
    } catch (e) {
      return false;
    }
  }

  // 메서드 - 회원정보 수정
  static Future<bool> editInfo(memberData) async {
    // 맴버 id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? memberId = prefs.getInt('memberId');
    try {
      var response = await http.patch(
        Uri.https('k9a310.p.ssafy.io', '/api/members/me',
        {'my_member_id': memberId.toString()}),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode(memberData),
      );
      // 성공 시
      if (response.statusCode == 200) {
        return true;
        // 실패 시
      } else {
        return false;
      }
      // 에러 발생시
    } catch (e) {
      return false;
    }
  }

  // 메서드 - 회원탈퇴
  static Future<bool> deleteMember(int memberId) async {
    try {
      var response = await http.delete(
        Uri.https('k9a310.p.ssafy.io', '/api/members/me',
            {'my_member_id': memberId.toString()}),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      // post 성공 시
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Error();
      }
      // 에러 발생시
    } catch (e) {
      return false;
    }
  }

  // 메서드 - 회원 재가입
  static Future<bool> rejoin(int memberId) async {
    try {
      var response = await http.patch(
        Uri.https('k9a310.p.ssafy.io', '/api/members/rejoin',
        {'my_member_id': memberId.toString()}),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      // 성공 시
      if (response.statusCode == 200) {
        return true;
        // 실패 시
      } else {
        return false;
      }
      // 에러 발생시
    } catch (e) {
      return false;
    }
  }

  // 메서드 - 닉네임 중복 체크
  static Future<bool> checkNickname(nickname) async {
    try {
      var response = await http.get(
        Uri.https('k9a310.p.ssafy.io', '/api/members/nickname',
            {'nickname': nickname}),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      // post 성공 시
      if (response.statusCode == 200) {
        bool result = json.decode(response.body)['data'];
        return result;
        // post 실패 시
      } else {
        return false;
      }
      // 에러 발생시
    } catch (e) {
      return false;
    }
  }

  // 메서드 - 전화번호 중복 체크
  static Future<bool> checkPhone(number) async {
    try {
      var response = await http.get(
        Uri.https('k9a310.p.ssafy.io', '/api/members/phone_number',
            {'phone_number': number}),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      // post 성공 시
      if (response.statusCode == 200) {
        bool result = json.decode(response.body)['data'];
        return result;
        // post 실패 시
      } else {
        return false;
      }
      // 에러 발생시
    } catch (e) {
      return false;
    }
  }

  // 메서드 - 내 정보 불러오기
  static Future<UserModel?> loadMyInfo(int number) async {
    try {
      var response = await http.get(
        Uri.https('k9a310.p.ssafy.io', '/api/members/me',
            {'my_member_id': number.toString()}),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      // post 성공 시
      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes))['data'];
        UserModel userData = UserModel(
            grade: result['grade'],
            cum_weight: result['cum_weight'],
            cum_pet: result['cum_pet'],
            cum_can: result['cum_can'],
            plogging_cnt: result['plogging_cnt'],
            name: result['name'],
            nickname: result['nickname'],
            phone_number: result['phone_number'],
            profile_image: result['profile_image']['imageUrl']);
        return userData;
        // post 실패 시
      } else {
        throw Error();
      }
      // 에러 발생시
    } catch (e) {
      return null;
    }
  }

  // 메서드 - 프로필사진 변경
  static Future<bool> editProfileImage(String path) async {
    // 맴버 id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? memberId = prefs.getInt('memberId');
    // 요청 관련 변수들
    final uri = Uri.https('k9a310.p.ssafy.io', '/api/members/profile_image',
        {'my_member_id': memberId.toString()});
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

  // 메서드 - 회원 정보 불러오기
  static Future<UserModel?> loadMemberInfo(int id) async {
    try {
      var response = await http.get(
        Uri.https('k9a310.p.ssafy.io', '/api/members/info',
            {'member_id': id.toString()}),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      // post 성공 시
      if (response.statusCode == 200) {
        final result = jsonDecode(utf8.decode(response.bodyBytes))['data'];
        UserModel userData = UserModel(
            grade: result['grade'],
            cum_weight: result['cum_weight'],
            cum_pet: result['cum_pet'],
            cum_can: result['cum_can'],
            plogging_cnt: result['plogging_cnt'],
            name: result['name'],
            nickname: result['nickname'],
            phone_number: result['phone_number'],
            profile_image: result['profile_image']['imageUrl']);
        return userData;
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
