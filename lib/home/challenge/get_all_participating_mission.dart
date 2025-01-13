import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_test/state_controller/loginProvider.dart'; // authProvider 경로

// 미션 모델
class Mission {
  final int roomNumber;
  final String title;
  final String startedAt;
  final String imgLink;
  final int participantCount;
  final String validationStatus;
  final String duration;

  Mission({
    required this.roomNumber,
    required this.title,
    required this.startedAt,
    required this.imgLink,
    required this.participantCount,
    required this.validationStatus,
    required this.duration,
  });

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      roomNumber: json['room_number'],
      title: json['title'],
      startedAt: json['started_at'],
      imgLink: json['img_link'],
      participantCount: json['participant_count'],
      validationStatus: json['validation_status'],
      duration: json['duration'],
    );
  }
}

// 미션 데이터를 가져오는 함수
Future<void> fetchAllParticipatingMissions(WidgetRef ref,
    {String? category}) async {
  // authProvider에서 사용자 정보 가져오기
  final user = ref.read(authProvider);

  // 사용자 인증이 없으면 에러 처리
  if (user == null) {
    throw Exception('사용자 인증이 필요합니다.');
  }

  final token = user.token; // authProvider에서 토큰 추출

  // 요청 URL 설정
  final url = Uri.parse('http://localhost:8080/missions/participating-all');

  // 요청 헤더 설정
  final headers = {
    'Authorization': 'Bearer $token', // Authorization 헤더에 토큰 추가
  };

  // 쿼리 파라미터 설정 (카테고리 필터링)
  final Map<String, String> queryParams = {};
  if (category != null && category.isNotEmpty) {
    queryParams['category'] = category;
  }

  // GET 요청 보내기
  final response = await http.get(url.replace(queryParameters: queryParams),
      headers: headers);

  if (response.statusCode == 200) {
    // 요청이 성공하면 반환된 JSON 데이터 처리
    final data = json.decode(response.body);

    // 응답에서 미션 목록 가져오기 (여기서는 data['data']라고 가정)
    final List<dynamic> missionsJson = data['data'];

    // 미션 데이터를 리스트로 변환
    List<Mission> missions = missionsJson
        .map((missionJson) => Mission.fromJson(missionJson))
        .toList();

    // 반환된 미션들을 출력
    for (var mission in missions) {
      print(
          '미션 번호: ${mission.roomNumber}, 제목: ${mission.title}, 시작일: ${mission.startedAt}, 이미지 링크: ${mission.imgLink}, 참여자 수: ${mission.participantCount}, 인증 상태: ${mission.validationStatus}, 기간: ${mission.duration}');
    }
  } else {
    // 오류가 발생한 경우
    print('요청 실패: ${response.statusCode}');
    print('응답 내용: ${response.body}');
  }
}
