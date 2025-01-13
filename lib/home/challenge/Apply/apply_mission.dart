import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/challenge/all_mission_get.dart';
import 'package:flutter_application_test/nav/report_mission_button.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'mission_image.dart';
import 'mission_details.dart';
import 'points_info.dart';
import 'certification_method.dart';
import 'mission_terms.dart';
import 'apply_button.dart';

class ApplyMission extends StatelessWidget {
  final Mission mission;

  // 생성자에 mission을 전달받도록 추가
  const ApplyMission({required this.mission, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:
            Text(mission.title, style: TextStyle(color: Colors.black)), // 미션 제목
        automaticallyImplyLeading: true, // 뒤로가기 버튼
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {
              // 점점점 버튼 클릭 시 동작
              showModalBottomSheet(
                context: context,
                isScrollControlled: true, // 스크롤 가능하도록 설정
                backgroundColor: Colors.transparent, // 모달 배경을 투명하게 처리
                builder: (BuildContext context) {
                  return ReportMissionButton(); // ReportButton 컴포넌트 호출
                },
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 미션 이미지 및 제목
            mission.missionImgLink.isNotEmpty
                ? Image.network(
                    '${dotenv.env['FTP_URL']}${mission.missionImgLink}', // 이미지 표시
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: Colors.grey[300],
                    height: 200,
                    child: Icon(
                      Icons.image,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
            SizedBox(height: 16),

            // 미션 세부 정보 (작성자, 참여자, 날짜 등)
            MissionDetailsWidget(mission: mission),
            SizedBox(height: 16),

            // 포인트 관련 정보
            // PointsInfo(mission: mission),
            // SizedBox(height: 16),

            // 인증 방법
            CertificationMethod(),
            SizedBox(height: 16),

            // 미션 유의 사항
            MissionTerms(mission: mission),
            SizedBox(height: 16),

            // 참여하기 버튼
            ApplyButton(mission: mission),
          ],
        ),
      ),
    );
  }
}
