import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/notification/notification.dart';

class HofMain extends StatelessWidget {
  HofMain({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // GlobalKey 추가

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Scaffold에 key 설정
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text("명예의 전당"),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 내 누적 포인트
            _buildMyPoints(2300),
            const SizedBox(height: 16), // 간격
            // 랭킹 TOP10 텍스트
            Text(
              '랭킹 TOP10',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            // 1등, 2등, 3등 프로필 섹션
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 243, 235), // 옅은 베이지색 배경
                borderRadius: BorderRadius.circular(12.0), // 모서리 둥글게
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 2등 프로필
                  _buildProfile(2, 'User2', 1800, Colors.grey[300]!, 90),
                  SizedBox(width: 20),
                  // 1등 프로필
                  _buildProfile(1, 'User1', 2300, Colors.amber[300]!, 100),
                  SizedBox(width: 20),
                  // 3등 프로필
                  _buildProfile(3, 'User3', 1700, Colors.blueGrey[300]!, 80),
                ],
              ),
            ),
            const SizedBox(height: 20), // 간격
            // 4등부터 10등까지 프로필 리스트
            _buildLeaderboardSection(),
          ],
        ),
      ),
    );
  }

  // 내 누적 포인트를 표시하는 위젯
  Widget _buildMyPoints(int points) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양옆에 배치
      children: [
        Text(
          '내 누적 포인트',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          '$points P',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 111, 97), // 설정한 포인트 색상
          ),
        ),
      ],
    );
  }

  // 프로필 위젯 (순위, 이름, 포인트)
  Widget _buildProfile(
      int rank, String name, int points, Color color, double size) {
    return Column(
      children: [
        // 원형 프로필 이미지
        ClipOval(
          child: Container(
            width: size, // 1등은 크기가 크고, 2등, 3등은 동일한 크기
            height: size, // 크기 조정
            color: color, // 배경색
            child: Icon(
              Icons.person, // 프로필 이미지 (아이콘으로 대체)
              size: size * 0.5, // 이미지 크기 (원형에 맞춰서 크기 조절)
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 8), // 간격
        // 이름
        Text(
          name,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 4),
        // 포인트 점수
        Text(
          '$points P',
          style: TextStyle(
            fontSize: 12,
            color: Color.fromARGB(255, 255, 111, 97),
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardSection() {
    List<Map<String, dynamic>> rankings = [
      {'rank': 1, 'name': 'User1', 'points': 2300},
      {'rank': 2, 'name': 'User2', 'points': 1800},
      {'rank': 3, 'name': 'User3', 'points': 1700},
      {'rank': 4, 'name': 'User4', 'points': 1600},
      {'rank': 5, 'name': 'User5', 'points': 1500},
      {'rank': 6, 'name': 'User6', 'points': 1400},
      {'rank': 7, 'name': 'User7', 'points': 1300},
      {'rank': 8, 'name': 'User8', 'points': 1200},
      {'rank': 9, 'name': 'User9', 'points': 1100},
      {'rank': 10, 'name': 'User10', 'points': 1000},
    ];

    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 243, 235), // 옅은 베이지색 배경
        borderRadius: BorderRadius.circular(12.0), // 모서리 둥글게
      ),
      child: Column(
        children: rankings.map((ranking) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // 순위는 왼쪽, 포인트는 오른쪽
              children: [
                // 순위
                Text(
                  '${ranking['rank']}.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                // 이름 (중앙 배치)
                Center(
                  child: SizedBox(
                    width: 100, // 이름의 고정 크기
                    child: Text(
                      ranking['name'],
                      textAlign: TextAlign.center, // 이름을 중앙 정렬
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                // 포인트
                Text(
                  '${ranking['points']}P',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 111, 97), // 포인트 색상
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
