import 'package:flutter/material.dart';
import 'package:flutter_application_test/comunity/anonymous_board.dart';
import 'package:flutter_application_test/comunity/beginner_fitness.dart';
import 'package:flutter_application_test/comunity/board_upload.dart';
import 'package:flutter_application_test/comunity/diet_plan.dart';
import 'package:flutter_application_test/comunity/fitness_challenge.dart';
import 'package:flutter_application_test/comunity/free_comunity.dart';
import 'package:flutter_application_test/comunity/running_board.dart';
import 'package:flutter_application_test/comunity/workout_complete.dart';

class MainCommunity extends StatelessWidget {
  const MainCommunity({super.key}); // const 생성자

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "다양한 주제로 소통해요~~",
                style: TextStyle(
                    fontSize: 15, color: Color.fromARGB(255, 170, 170, 170)),
              ),
              const SizedBox(height: 10),
              // 게시판 섹션
              const Text(
                "커뮤니티 보러가기",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // 게시판 목록
              GridView.builder(
                shrinkWrap: true, // 이 리스트는 내부 스크롤만 가능하게 만듭니다.
                physics:
                    const NeverScrollableScrollPhysics(), // 외부 스크롤과 중복되지 않게 설정
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 한 줄에 4개의 아이템
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 8, // 총 8개 게시판
                itemBuilder: (context, index) {
                  return _buildBoardButton(context, index);
                },
              ),
              const SizedBox(height: 10),
              const Text(
                "이번주 인기 많은 게시글은?",
                style: TextStyle(
                    fontSize: 15, color: Color.fromARGB(255, 170, 170, 170)),
              ),
              const SizedBox(height: 10),
              // 인기글 섹션
              const Text(
                "HOT 인기글",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // 인기글 박스
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 240, 205), // 옅은 베이지색 배경
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHotPost('자유', '자유게시판 인기글 제목'),
                    _buildHotPost('익명', '익명게시판 인기글 제목'),
                    _buildHotPost('오운완', '오운완 게시글 제목'),
                    _buildHotPost('러닝', '러닝 게시글 제목'),
                    _buildHotPost('헬린이', '헬린이 게시글 제목'),
                    _buildHotPost('식단', '식단 게시글 제목'),
                    _buildHotPost('첼린지', '첼린지 게시글 제목'),
                    _buildHotPost('공지사항', '공지사항 게시글 제목'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  BoardUpload(), // 임시로 FocusOnExercisePage로 이동
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

  // 게시판 버튼 생성
  Widget _buildBoardButton(BuildContext context, int index) {
    final boardList = ['자유', '익명', '오운완', '러닝', '헬린이', '식단', '첼린지', '공지사항'];
    final boardIcons = [
      Icons.chat,
      Icons.person_outline,
      Icons.fitness_center,
      Icons.run_circle,
      Icons.health_and_safety,
      Icons.food_bank,
      Icons.golf_course_sharp,
      Icons.note_alt_rounded
    ];

    return GestureDetector(
      onTap: () {
        // 자유게시판 클릭 시 이동
        if (boardList[index] == '자유') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FreeCommunity(), // 자유게시판으로 이동
            ),
          );
        } else if (boardList[index] == '익명') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AnonymousBoard(), // 자유게시판으로 이동
            ),
          );
        } else if (boardList[index] == '오운완') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WorkoutComplete(), // 자유게시판으로 이동
            ),
          );
        } else if (boardList[index] == '러닝') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RunningBoard(), // 자유게시판으로 이동
            ),
          );
        } else if (boardList[index] == '헬린이') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BeginnerFitness(), // 자유게시판으로 이동
            ),
          );
        } else if (boardList[index] == '식단') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DietPlan(), // 자유게시판으로 이동
            ),
          );
        } else if (boardList[index] == '첼린지') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FitnessChallenge(), // 자유게시판으로 이동
            ),
          );
        }
        print('${boardList[index]} 게시판으로 이동');
      },
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              boardIcons[index], // 아이콘
              size: 30,
              color: const Color.fromARGB(255, 255, 111, 97),
            ),
            const SizedBox(height: 8),
            Text(
              boardList[index], // 텍스트
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black, // 텍스트 색상
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 인기글 박스
  Widget _buildHotPost(String boardName, String postTitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            boardName, // 게시판 이름
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 111, 97), // 게시판 이름 색상
            ),
          ),
          const SizedBox(width: 10),
          Text(
            postTitle, // 인기글 제목
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
