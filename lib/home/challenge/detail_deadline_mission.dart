import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/challenge/apply_mission.dart';
import 'package:flutter_application_test/home/notification/notification.dart';
import 'package:flutter_application_test/nav/sidebar.dart';

class DetailDeadlineMission extends StatefulWidget {
  const DetailDeadlineMission({super.key});

  @override
  _DetailDeadlineMissionState createState() => _DetailDeadlineMissionState();
}

class _DetailDeadlineMissionState extends State<DetailDeadlineMission> {
  // 미션 종류 선택 버튼의 선택 상태
  String selectedMissionType = '전체';

  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // GlobalKey 추가

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Scaffold에 key 설정
      endDrawer: const SideBar(), // 오른쪽 사이드바 설정
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
                  missionTypeButton('전체'),
                  missionTypeButton('운동'),
                  missionTypeButton('식단'),
                  missionTypeButton('걸음수'),
                  missionTypeButton('러닝'),
                ],
              ),
            ),

            // 미션 목록
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 한 줄에 두 개
                  crossAxisSpacing: 16.0, // 가로 간격
                  mainAxisSpacing: 16.0, // 세로 간격
                  childAspectRatio: 0.75, // 이미지 크기 조정
                ),
                itemCount: 6, // 미션 개수 (예시로 6개)
                itemBuilder: (context, index) {
                  return missionButton(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 미션 종류 선택 버튼
  Widget missionTypeButton(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedMissionType = label;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedMissionType == label
              ? Color.fromARGB(255, 255, 111, 97) // 선택된 버튼 색상
              : Colors.white, // 선택되지 않은 버튼 배경색
          side: BorderSide(
            color: selectedMissionType == label
                ? Color.fromARGB(255, 255, 111, 97) // 선택된 상태에서의 테두리 색
                : Colors.grey.withOpacity(0.5), // 선택되지 않은 상태에서의 연한 테두리 색
            width: 1,
          ),
          padding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0), // 크기 조정
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // 둥근 모서리
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selectedMissionType == label
                ? Colors.white // 선택된 버튼의 텍스트 색상
                : Colors.black, // 선택되지 않은 버튼의 텍스트 색상
            fontSize: 12, // 작은 크기
          ),
        ),
      ),
    );
  }

  // 미션 버튼 (클릭 가능한 카드 형태)
  Widget missionButton(int index) {
    return GestureDetector(
      onTap: () {
        // 미션을 클릭하면 디테일 페이지로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ApplyMission(), // 상세 페이지로 이동
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 텍스트를 왼쪽 정렬
          children: [
            // 미션 이미지 (아이콘)
            Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  width: double.infinity,
                  height: 140,
                  color: Colors.grey[300], // 이미지 대신 회색 박스
                  child: Icon(
                    Icons.image, // 이미지 아이콘
                    size: 60,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.people, // 사람들이 아이콘
                        size: 14,
                        color: Colors.white,
                      ),
                      SizedBox(width: 4),
                      Text(
                        ': ${index + 10}명', // 예시로 10명부터 시작
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
                '시작 날짜: 2024-01-01',
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
                '미션 ${index + 1} 이름',
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
                '${index + 1}주간', // 예시 기간
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
