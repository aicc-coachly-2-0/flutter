import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/challenge/all_mission_get.dart'; // 방금 만든 메서드
import 'package:flutter_application_test/state_controller/loginProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MissionTerms extends ConsumerWidget {
  final Mission mission;

  const MissionTerms({required this.mission, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // room_number를 이용해 미션 유의사항 정보를 가져오기
    final roomNumber = mission.roomNumber;

    // 유의사항 정보 가져오는 함수 호출 (비동기 처리 필요)
    Future<Map<String, String>> missionDetails =
        fetchMissionDetails(ref, roomNumber);

    return FutureBuilder<Map<String, String>>(
      future: missionDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // 로딩 상태
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}"); // 에러 처리
        } else if (snapshot.hasData) {
          var data = snapshot.data!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('미션 유의 사항',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              // 첫 번째 유의사항 수정
              _buildTerm(
                  '- 해당 첼린지는 기간 동안 "${data['certFreq']}", "하루 ${data['weeklyCertCount']}회 인증" 해주세요.'),
              // 나머지 기본 유의사항
              _buildTerm('- 00시 00분 ~ 23시 59분 사이에 인증해주세요.'),
              _buildTerm('- 인증 날짜 이전에 찍은 사진은 인증 시 사용하실 수 없습니다.'),
              _buildTerm('- 인증샷은 해당 미션 참가자에게만 공개됩니다.'),
              _buildTerm('- 적절하지 않은 인증샷의 경우 최종 검토 후 경고 처리됩니다.'),
            ],
          );
        } else {
          return Text('No data found'); // 데이터가 없는 경우
        }
      },
    );
  }

  // 유의사항을 받기 위한 메서드
  Future<Map<String, String>> fetchMissionDetails(
      WidgetRef ref, int roomNumber) async {
    final response = await http.get(
      Uri.parse('http://localhost:8080/missions/recruiting/$roomNumber'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final missionData = data['data'];

      // 필요한 데이터만 추출하여 반환
      return {
        'certFreq': missionData['cert_freq'],
        'weeklyCertCount': missionData['weekly_cert_count'].toString(),
      };
    } else {
      throw Exception('Failed to load mission details');
    }
  }

  Widget _buildTerm(String term) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(term, style: TextStyle(fontSize: 13)),
    );
  }
}
