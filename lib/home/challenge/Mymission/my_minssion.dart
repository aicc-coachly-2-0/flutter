import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/challenge/Mymission/my_mission_get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_test/home/challenge/Confirm/confirm_mission.dart';

class MyMission extends ConsumerWidget {
  const MyMission({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // FutureBuilder를 사용하여 미션 데이터를 비동기적으로 로드
    return FutureBuilder<List<ParticipatingMission>>(
      future: fetchParticipatingMissions(ref), // 미션 데이터를 가져오는 함수 호출
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('참여 중인 미션이 없습니다.'));
        }

        final missions = snapshot.data!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 첫 번째 섹션 제목
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Text(
                '인증하고 포인트 꼭 받아가세요!',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
              ),
            ),
            // "참여중인 미션" 제목
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                '참여중인 미션',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            // 참여중인 미션이 있을 때 표시하는 박스 (ListView 사용)
            SizedBox(
              height: 250, // 이미지 크기
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // 가로 스크롤
                itemCount: missions.length, // 실제 데이터 개수
                itemBuilder: (context, index) {
                  final mission = missions[index];

                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        // 미션 클릭 시 상세 페이지로 바로 이동
                        _navigateToMissionDetail(context, mission);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 미션 이미지 (아이콘 대신 실제 이미지 사용)
                          Stack(
                            alignment: Alignment.topLeft, // 왼쪽 상단에 텍스트 위치
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                color: Colors.grey[300], // 이미지 대신 회색 박스
                                child: mission.missionImgLink.isNotEmpty
                                    ? Image.network(
                                        '${dotenv.env['FTP_URL']}${mission.missionImgLink}',
                                        fit: BoxFit.cover,
                                      )
                                    : Icon(
                                        Icons.image, // 이미지 아이콘
                                        size: 60,
                                        color: Colors.white,
                                      ),
                              ),
                              // 참여자 수 (사람들 모티콘)
                            ],
                          ),
                          SizedBox(height: 8), // 간격
                          // 시작 날짜
                          Text(
                            '시작 날짜: ${mission.startedAt}',
                            style: TextStyle(
                              fontSize: 14,
                              color: const Color.fromARGB(255, 255, 126, 51),
                            ),
                          ),
                          SizedBox(height: 4),
                          // 미션 이름
                          Text(
                            mission.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          // 기간
                          Text(
                            mission.missionLevel,
                            style:
                                TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // 미션 상세 페이지로 바로 이동하는 함수
  void _navigateToMissionDetail(
      BuildContext context, ParticipatingMission participatingmission) {
    // 미션 상세 페이지로 바로 이동
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmMission(
            participatingmission:
                participatingmission), // ConfirmMission으로 데이터 전달
      ),
    );
  }
}
