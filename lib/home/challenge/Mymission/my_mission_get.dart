import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_test/state_controller/loginProvider.dart'; // authProvider
import 'package:flutter_dotenv/flutter_dotenv.dart';

// 미션 데이터 모델 정의
class ParticipatingMission {
  final int roomNumber;
  final int missionNumber;
  final int userNumber;
  final String title;
  final String content;
  final String startedAt;
  final String missionImgLink;
  final String endedAt;
  final String missionLevel;
  final String certFreq;
  final String userImgLink;

  ParticipatingMission({
    required this.roomNumber,
    required this.missionNumber,
    required this.userNumber,
    required this.title,
    required this.content,
    required this.startedAt,
    required this.missionImgLink,
    required this.endedAt,
    required this.missionLevel,
    required this.certFreq,
    required this.userImgLink,
  });

  factory ParticipatingMission.fromJson(Map<String, dynamic> json) {
    return ParticipatingMission(
      roomNumber: json['room_number'],
      missionNumber: json['mission_number'],
      userNumber: json['user_number'],
      title: json['title'],
      content: json['content'],
      startedAt: json['started_at'],
      missionImgLink: json['mission_img_link'],
      endedAt: json['ended_at'],
      missionLevel: json['mission_level'],
      certFreq: json['cert_freq'],
      userImgLink: json['user_img_link'],
    );
  }
}

// 미션 참여 리스트를 가져오는 함수
Future<List<ParticipatingMission>> fetchParticipatingMissions(
    WidgetRef ref) async {
  final user = ref.read(authProvider); // user 객체를 읽어오기

  if (user == null) {
    throw Exception('사용자 인증이 필요합니다.');
  }

  final userToken = user.token;

  // user_number는 authProvider에서 가져온 user.number 값으로 설정
  final userNumber = user.userNumber;

  final response = await http.get(
    Uri.parse('http://localhost:8080/missions/participating/$userNumber'),
    headers: {
      'Authorization': 'Bearer $userToken', // 헤더에 Authorization 토큰 추가
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final missionsData = data['data'] as List;
    // print(missionsData);
    return missionsData
        .map((missionJson) => ParticipatingMission.fromJson(missionJson))
        .toList();
  } else {
    final errorMessage = json.decode(response.body)['message'] ??
        'Failed to load participating missions';
    throw Exception(errorMessage); // 서버에서 보내주는 에러 메시지 활용
  }
}
