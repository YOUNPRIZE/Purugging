import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:purugging/screens/start/start_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final GoogleSignIn googleSignIn = GoogleSignIn();
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // 메서드 - 구글 로그인
  static Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await firebaseAuth.signInWithCredential(credential);
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    } // 로그인 실패
  }

  // 메서드 - 등록된 회원인지 확인
  static Future<Map<String, dynamic>?> isMember() async {
    try {
      User? user = firebaseAuth.currentUser;
      if (user == null) {
        throw Error();
      }
      var response = await http.get(
        Uri.https('k9a310.p.ssafy.io', '/api/members/exists',
            {'google_uid': user.uid}),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        var memberData = json.decode(response.body)['data'];
        return memberData;
      } else {
        throw Error();
      }
    } catch (e) {
      return null;
    }
  }

  // 메서드 - FCM 토큰을 전송하는 메서드 추가
  static Future<void> sendFcmToken() async {
    // 맴버id 존재 여부 확인
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? memberId = prefs.getInt('memberId');
    if (memberId == null) {
      return;
    }
    // 파이어베이스 토큰 존재 여부 확인
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? fcmToken = await messaging.getToken();
    if (fcmToken != null) {
      return;
    }
    // 존재한다면 토큰 post
    try {
      var response = await http.post(
        Uri.parse('https://k9a310.p.ssafy.io/api/fcm/check'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'member_id': memberId,
          'fcm_token': fcmToken,
        }),
      );
      // 성공한 경우
      if (response.statusCode != 200) {}
      // 실패한 경우
    } catch (e) {
      print('Failed to send FCM token: $e');
    }
  }

  // 메서드 - 로그아웃
  static Future<void> signOut(context) async {
    // 파이어베이스 로그아웃
    await googleSignIn.signOut();
    await firebaseAuth.signOut();
    // 유저 정보 삭제
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('memberId');
    // 시작 페이지로 이동하면서 이전 페이지들 모두 제거
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const StartScreen()),
      (Route<dynamic> route) => false, // 모든 이전 페이지를 제거
    );
  }


}
