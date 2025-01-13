import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_test/state_controller/loginProvider.dart'; // authProvider 가져오기
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> joinMission(WidgetRef ref, int roomNumber) async {
  // 사용자 정보를 가져옵니다.
  final user = ref.read(authProvider);

  // 사용자 정보가 없다면 오류 처리
  if (user == null) {
    throw Exception('사용자 인증이 필요합니다.');
  }

  final token = user.token;
  final userNumber = user.userNumber; // authProvider에서 userNumber 가져오기

  // 요청 URL
  final url =
      Uri.parse('http://localhost:8080/missions/rooms/$roomNumber/join');

  // 요청 헤더
  final headers = {
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  };

  // 요청 본문 (Body)
  final body = json.encode({
    'user_number': userNumber,
    'room_number': roomNumber,
  });

  // POST 요청 보내기
  final response = await http.post(
    url,
    headers: headers,
    body: body,
  );

  if (response.statusCode == 201) {
    // 성공적인 요청 처리
    print('미션 참여 성공!');
    // 응답 내용도 필요하면 로그로 출력
    print(response.body);
  } else {
    // 요청 실패 처리
    print('미션 참여 실패: ${response.statusCode}');
    print('에러 내용: ${response.body}');
    throw Exception('미션 참여 실패');
  }
}
