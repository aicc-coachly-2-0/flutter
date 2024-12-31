import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/hall_of_fame/hof_main.dart';

class HallofFame extends StatelessWidget {
  const HallofFame({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 첫 번째 섹션 제목
        Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Text(
            '이번주 미션 포인트 누적 1등은?',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black38,
            ),
          ),
        ),

        // "명예의 전당" 제목과 오른쪽 상단 화살표 버튼을 같은 선상에 배치
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '명예의 전당',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                // 버튼 클릭 시 동작
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HofMain(), // 임시로 FocusOnExercisePage로 이동
                  ),
                );
                print('자세히 보기 버튼 클릭');
              },
            ),
          ],
        ),

        // 프로필 섹션 (1등, 2등, 3등)
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 243, 235), // 옅은 베이지색 배경
            borderRadius: BorderRadius.circular(12.0), // 모서리 둥글게
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 2등 프로필 (왼쪽)
              _buildProfile(2, 'User2', 1800, Colors.grey[300]!, 90),
              SizedBox(width: 20), // 간격
              // 1등 프로필 (가운데)
              _buildProfile(1, 'User1', 2300, Colors.amber[300]!, 100),
              SizedBox(width: 20), // 간격
              // 3등 프로필 (오른쪽)
              _buildProfile(3, 'User3', 1700, Colors.blueGrey[300]!, 80),
            ],
          ),
        ),
      ],
    );
  }

  // 프로필 위젯
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
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
