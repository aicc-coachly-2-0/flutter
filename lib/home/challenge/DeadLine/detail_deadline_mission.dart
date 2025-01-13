import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/challenge/all_mission_get.dart';
import 'package:flutter_application_test/home/notification/notification.dart';
import 'package:flutter_application_test/nav/sidebar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'mission_type_button.dart'; // 미션 종류 선택 버튼
import 'deadline_mission_card.dart'; // 미션 카드

class DetailDeadlineMission extends StatefulWidget {
  const DetailDeadlineMission({super.key});

  @override
  _DetailDeadlineMissionState createState() => _DetailDeadlineMissionState();
}

class _DetailDeadlineMissionState extends State<DetailDeadlineMission> {
  // 미션 종류 선택 버튼의 선택 상태
  String selectedMissionType = '전체';
  int selectedMissionTypeNumber =
      0; // 선택된 미션 번호 (전체=0, 운동=1, 식단=2, 걸음수=3, 러닝=4)

  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // GlobalKey 추가

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Scaffold에 key 설정
      endDrawer: SideBar(), // 오른쪽 사이드바 설정
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255), // 원하는 색으로 설정
        title: Text('마감임박 미션'), // 탭에 맞는 타이틀 표시
        centerTitle: true, // 타이틀을 중앙에 배치
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_sharp), // 알림 아이콘
            onPressed: () {
              // 알림 버튼 클릭 시 알림창 열기
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu), // 메뉴 아이콘
            onPressed: () {
              // 메뉴 버튼 클릭 시 사이드바 열기
              _scaffoldKey.currentState?.openEndDrawer(); // 오른쪽 사이드바 열기
            },
          ),
        ],
      ),
      backgroundColor: Colors.white, // 배경색 설정
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 미션 종류 텍스트
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                '미션 종류',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            // 미션 종류 선택 버튼 (전체, 운동, 식단, 걸음수, 러닝)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MissionTypeButton('전체', selectedMissionType, () {
                    setState(() {
                      selectedMissionType = '전체';
                      selectedMissionTypeNumber = 0; // 전체 미션
                    });
                  }),
                  MissionTypeButton('운동', selectedMissionType, () {
                    setState(() {
                      selectedMissionType = '운동';
                      selectedMissionTypeNumber = 1; // 운동 미션
                    });
                  }),
                  MissionTypeButton('식단', selectedMissionType, () {
                    setState(() {
                      selectedMissionType = '식단';
                      selectedMissionTypeNumber = 2; // 식단 미션
                    });
                  }),
                  MissionTypeButton('걸음수', selectedMissionType, () {
                    setState(() {
                      selectedMissionType = '걸음수';
                      selectedMissionTypeNumber = 3; // 걸음수 미션
                    });
                  }),
                  MissionTypeButton('러닝', selectedMissionType, () {
                    setState(() {
                      selectedMissionType = '러닝';
                      selectedMissionTypeNumber = 4; // 러닝 미션
                    });
                  }),
                ],
              ),
            ),

            // 미션 목록
            Expanded(
              child: Consumer(
                builder: (context, ref, _) {
                  return FutureBuilder<List<Mission>>(
                    // 미션 데이터를 가져오기 위한 Future 호출
                    future: fetchParticipatingMissions(ref, 1), // 초기 페이지 1 로딩
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator()); // 로딩 중
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text('에러: ${snapshot.error}'));
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('현재 참여 중인 미션이 없습니다.'));
                      }

                      // 미션 데이터 필터링
                      final missions = snapshot.data!;

                      // 미션 타입에 맞게 필터링
                      final filteredMissions = missions.where((mission) {
                        if (selectedMissionTypeNumber == 0) {
                          return true; // 전체
                        } else if (selectedMissionTypeNumber == 1) {
                          return mission.missionNumber == 1; // 운동
                        } else if (selectedMissionTypeNumber == 2) {
                          return mission.missionNumber == 2; // 식단
                        } else if (selectedMissionTypeNumber == 3) {
                          return mission.missionNumber == 3; // 걸음수
                        } else if (selectedMissionTypeNumber == 4) {
                          return mission.missionNumber == 4; // 러닝
                        }
                        return false;
                      }).toList();

                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 한 줄에 두 개
                          crossAxisSpacing: 16.0, // 가로 간격
                          mainAxisSpacing: 16.0, // 세로 간격
                          childAspectRatio: 0.75, // 이미지 크기 조정
                        ),
                        itemCount: filteredMissions.length, // 필터링된 미션 개수
                        itemBuilder: (context, index) {
                          return MissionCard(
                              mission: filteredMissions[
                                  index]); // MissionCard에 mission 객체를 넘김
                        },
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
