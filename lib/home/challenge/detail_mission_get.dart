import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 미션 상세 정보 모델
class MissionDetails {
  final int roomNumber;
  final String missionRoomTitle;
  final String missionRoomContent;
  final String startedAt;
  final String endedAt;
  final String certFreq;
  final int weeklyCertCount;
  final String imgLink;
  final String missionCategoryTitle;
  final String roomCreatorName;
  final int participantCount; // 여기서 int 타입으로 수정

  MissionDetails({
    required this.roomNumber,
    required this.missionRoomTitle,
    required this.missionRoomContent,
    required this.startedAt,
    required this.endedAt,
    required this.certFreq,
    required this.weeklyCertCount,
    required this.imgLink,
    required this.missionCategoryTitle,
    required this.roomCreatorName,
    required this.participantCount,
  });

  factory MissionDetails.fromJson(Map<String, dynamic> json) {
    return MissionDetails(
      roomNumber: json['room_number'],
      missionRoomTitle: json['mission_room_title'],
      missionRoomContent: json['mission_room_content'],
      startedAt: json['started_at'],
      endedAt: json['ended_at'],
      certFreq: json['cert_freq'],
      weeklyCertCount:
          int.parse(json['weekly_cert_count'].toString()), // String -> int로 변환
      imgLink: json['img_link'],
      missionCategoryTitle: json['mission_category_title'],
      roomCreatorName: json['room_creator_name'],
      participantCount:
          int.parse(json['participant_count'].toString()), // String -> int로 변환
    );
  }
}

// 미션 상세 정보를 가져오는 함수
Future<MissionDetails> fetchMissionDetails(
    WidgetRef ref, int roomNumber) async {
  // 인증이 필요 없으므로, 헤더에서 토큰을 제거하고 요청을 보냄
  final response = await http.get(
    Uri.parse(
        'http://localhost:8080/missions/recruiting/$roomNumber'), // room_number로 요청
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final missionData = data['data']; // 'data' 부분을 추출

    return MissionDetails.fromJson(missionData); // MissionDetails 객체로 변환
  } else {
    final errorMessage = json.decode(response.body)['message'] ??
        'Failed to load mission details';
    throw Exception(errorMessage); // 서버에서 보내주는 에러 메시지 활용
  }
}
