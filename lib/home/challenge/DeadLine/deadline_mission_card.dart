import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/challenge/Apply/apply_mission.dart';
import 'package:flutter_application_test/home/challenge/all_mission_get.dart';
import 'package:flutter_application_test/home/challenge/detail_mission_get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart'; // 날짜 포맷을 위한 패키지

class MissionCard extends StatelessWidget {
  final Mission mission;

  const MissionCard({required this.mission, super.key});

  // 비동기적으로 미션 상세 데이터를 가져오기 위한 FutureBuilder
  Future<MissionDetails> _fetchMissionDetails(WidgetRef ref) async {
    try {
      // fetchMissionDetails 함수 호출하여 데이터를 가져옴
      return await fetchMissionDetails(ref, mission.roomNumber);
    } catch (e) {
      print("미션 상세 정보 불러오기 실패: $e");
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return FutureBuilder<MissionDetails>(
          // 미션 상세 정보를 비동기적으로 가져오는 FutureBuilder
          future: _fetchMissionDetails(ref), // ref를 사용하여 호출
          builder: (context, snapshot) {
            // 로딩 중인 경우
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            // 에러가 발생한 경우
            if (snapshot.hasError) {
              return Center(child: Text('미션 상세 정보를 불러오는 데 실패했습니다.'));
            }

            // 데이터가 준비된 경우
            if (snapshot.hasData) {
              final missionDetails = snapshot.data!;

              // 시작 날짜 포맷을 'yyyy-MM-dd'로 변경
              String formattedStartDate = '';
              if (mission.startedAt.isNotEmpty) {
                try {
                  DateTime startDate = DateTime.parse(mission.startedAt);
                  formattedStartDate = DateFormat('yyyy-MM-dd')
                      .format(startDate); // 'yyyy-MM-dd' 포맷으로 변경
                } catch (e) {
                  formattedStartDate =
                      mission.startedAt; // 포맷에 문제가 있으면 원본 날짜 사용
                }
              }

              return GestureDetector(
                onTap: () {
                  // 미션을 클릭하면 디테일 페이지로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ApplyMission(mission: mission), // 상세 페이지로 이동
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 미션 이미지
                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          mission.missionImgLink.isNotEmpty
                              ? Container(
                                  width: double.infinity,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          '${dotenv.env['FTP_URL'] ?? ''}${mission.missionImgLink}'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: double.infinity,
                                  height: 140,
                                  color: Colors.grey[300],
                                  child: Icon(
                                    Icons.image,
                                    size: 60,
                                    color: Colors.white,
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.people,
                                  size: 14,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 4),
                                // 참여자 수 가져온 데이터로 변경
                                Text(
                                  ': ${missionDetails.participantCount}명', // 참여자 수
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      // 시작 날짜
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '시작 날짜: $formattedStartDate', // 포맷된 날짜 사용
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 255, 126, 51),
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      // 미션 이름
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          mission.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      // 미션 기간
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          mission.duration,
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return SizedBox.shrink();
          },
        );
      },
    );
  }
}
