import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/challenge/Upload/challenge_upload.dart';
import 'package:flutter_application_test/home/challenge/DeadLine/deadline_mission.dart';
import 'package:flutter_application_test/home/challenge/Focus/focus_mission.dart';
import 'package:flutter_application_test/home/hall_of_fame/hall_of_fame.dart';
import 'package:flutter_application_test/home/challenge/Mymission/my_minssion.dart';

class ChallengeMain extends StatelessWidget {
  const ChallengeMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색 설정
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // 미션 섹션을 임포트하여 사용
            MyMission(),
            FocusMission(),
            HallofFame(),
            DeadlineMission(),
            // 예시로 다른 섹션들 추가할 수 있음
            // AnotherSection(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ChallengeUpload(), // 임시로 FocusOnExercisePage로 이동
            ),
          );
          print('추가하기 버튼 눌림');
          // 추가 버튼을 눌렀을 때의 동작을 구현할 수 있습니다.
        },
        backgroundColor: const Color.fromARGB(255, 255, 111, 97), // + 아이콘
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0), // 원형 모양 설정
        ), // 버튼 색상
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
