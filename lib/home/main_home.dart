import 'package:flutter/material.dart';
import 'package:flutter_application_test/community/Anonymous/anonymous_board.dart';
import 'package:flutter_application_test/community/Beginner/beginner_fitness.dart';
import 'package:flutter_application_test/community/Diet/diet_plan.dart';
import 'package:flutter_application_test/community/Mission/fitness_challenge.dart';
import 'package:flutter_application_test/community/Free/free_community.dart';
import 'package:flutter_application_test/community/Running/running_board.dart';
import 'package:flutter_application_test/community/WorkoutComplete/workout_complete.dart';
import 'package:flutter_application_test/home/challenge/DeadLine/deadline_mission.dart';
import 'package:flutter_application_test/home/challenge/Mymission/my_minssion.dart';
import 'package:flutter_application_test/home/grid_item.dart';
import 'package:flutter_application_test/home/hot_posts.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  List<String> boardList = [
    '자유',
    '익명',
    '오운완',
    '러닝',
    '헬린이',
    '식단',
    '첼린지',
    '공지사항',
  ];

  List<IconData> boardIcons = [
    Icons.chat,
    Icons.person_outline,
    Icons.fitness_center,
    Icons.run_circle,
    Icons.health_and_safety,
    Icons.food_bank,
    Icons.golf_course_sharp,
    Icons.note_alt_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // 다양한 주제로 소통해요~ 문구
            const Text(
              '다양한 주제로 소통해요~',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 155, 155, 155)),
            ),
            const SizedBox(height: 10),
            const Text(
              '커뮤니티 보러가기',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            // 게시판 버튼들을 가로로 스크롤
            GridItem(boardList: boardList, boardIcons: boardIcons),

            // HOT 인기글 섹션
            const SizedBox(height: 40),
            HotPosts(),
            const SizedBox(height: 40),

            // 미션 섹션
            MyMission(),
            DeadlineMission(),
          ],
        ),
      ),
    );
  }
}
