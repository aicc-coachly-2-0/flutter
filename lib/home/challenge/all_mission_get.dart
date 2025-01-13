import 'package:flutter_application_test/state_controller/loginProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Mission {
  final String title;
  final String startedAt;
  final String missionImgLink;
  final int participantCount;
  final String duration;
  final List<Map<String, String>> certificationMethods; // 인증 방법 추가
  final int roomNumber; // room_number 추가
  final int missionNumber; // mission_number 추가
  final int userNumber; // mission_number 추가
  final String usersImgLink; // 유저 img_link 추가

  Mission({
    required this.title,
    required this.startedAt,
    required this.missionImgLink,
    required this.participantCount,
    required this.duration,
    required this.certificationMethods, // 인증 방법 추가
    required this.roomNumber, // room_number 추가
    required this.missionNumber, // mission_number 추가
    required this.userNumber, // mission_number 추가
    required this.usersImgLink, // 유저 img_link 추가
  });

  factory Mission.fromJson(Map<String, dynamic> json) {
    var methods = json['certification_methods'] as List<dynamic>? ?? [];
    String usersImgLink = json['user_img_link'] ?? ''; // null 처리

    return Mission(
      title: json['title'] ?? '', // null 처리
      startedAt: json['started_at'] ?? '', // null 처리
      missionImgLink: json['mission_img_link'] ?? '', // null 처리
      participantCount: int.parse(json['participant_count'] ?? '0'), // null 처리
      duration: json['duration'] ?? '', // null 처리
      certificationMethods: List<Map<String, String>>.from(
          methods.map((item) => Map<String, String>.from(item))),
      roomNumber: json['room_number'] ?? 0, // null 처리
      missionNumber: json['mission_number'] ?? 0, // null 처리
      userNumber: json['user_number'] ?? 0, // null 처리
      usersImgLink: usersImgLink, // 유저 이미지 링크
    );
  }
}

// 미션 데이터를 가져오는 함수 (페이지 번호 추가)
Future<List<Mission>> fetchParticipatingMissions(
    WidgetRef ref, int page) async {
  // authProvider에서 토큰을 가져옴
  final user = ref.read(authProvider);

  // user가 null일 경우 처리
  if (user == null) {
    throw Exception('사용자 인증이 필요합니다.');
  }

  final token = user.token;

  // 요청 헤더에 Authorization 추가
  final response = await http.get(
    Uri.parse('http://localhost:8080/missions/popular?page=$page'), // 페이지 번호 추가
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List<dynamic> missionsJson = data['data'];

    // 데이터 처리
    List<Mission> missions =
        missionsJson.map((mission) => Mission.fromJson(mission)).toList();

    // 시작 날짜를 기준으로 정렬 (날짜가 가까운 순서대로)
    missions.sort((a, b) {
      DateTime dateA = DateFormat('yyyy-MM-dd').parse(a.startedAt);
      DateTime dateB = DateFormat('yyyy-MM-dd').parse(b.startedAt);
      return dateA.compareTo(dateB);
    });

    // roomNumber 기준으로 중복된 미션 제거
    final uniqueMissions = <int, Mission>{}; // roomNumber를 키로 하는 Map 사용

    for (var mission in missions) {
      if (!uniqueMissions.containsKey(mission.roomNumber)) {
        uniqueMissions[mission.roomNumber] = mission; // roomNumber가 없으면 추가
      }
    }

    // 중복이 제거된 미션 목록 반환
    return uniqueMissions.values.toList();
  } else {
    final errorMessage =
        json.decode(response.body)['message'] ?? 'Failed to load missions';
    throw Exception(errorMessage); // 서버에서 보내주는 에러 메시지 활용
  }
}
