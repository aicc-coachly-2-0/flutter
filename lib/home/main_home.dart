import 'package:flutter/material.dart';
import 'package:flutter_application_test/comunity/anonymous_board.dart';
import 'package:flutter_application_test/comunity/beginner_fitness.dart';
import 'package:flutter_application_test/comunity/diet_plan.dart';
import 'package:flutter_application_test/comunity/fitness_challenge.dart';
import 'package:flutter_application_test/comunity/free_comunity.dart';
import 'package:flutter_application_test/comunity/running_board.dart';
import 'package:flutter_application_test/comunity/workout_complete.dart';
import 'package:flutter_application_test/home/challenge/deadline_mission.dart';
import 'package:flutter_application_test/home/challenge/my_minssion.dart';

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
            // "다양한 주제로 소통해요~" 문구
            const Text(
              '다양한 주제로 소통해요~',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 155, 155, 155)),
            ),

            // "커뮤니티 보러가기" 섹션
            const SizedBox(height: 20), // 문구와 버튼 사이 간격
            const Text(
              '커뮤니티 보러가기',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            // 게시판 버튼들을 한 줄로 배치하여 가로스크롤 가능
            SizedBox(
              height: 120, // 버튼들이 들어갈 영역 높이
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // 가로로 스크롤이 가능하도록 설정
                child: Row(
                  children: [
                    _buildGridItem(0),
                    _buildGridItem(1),
                    _buildGridItem(2),
                    _buildGridItem(3),
                    _buildGridItem(4),
                    _buildGridItem(5),
                    _buildGridItem(6),
                    _buildGridItem(7),
                  ],
                ),
              ),
            ),

            // "HOT 인기글" 섹션
            const SizedBox(height: 40), // 섹션 간 간격

            // "이번주 가장 인기가 많은 게시글은?" 텍스트
            const Text(
              '이번주 가장 인기가 많은 게시글은?',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 155, 155, 155),
              ),
            ),
            const Text(
              'HOT 인기글',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20), // 텍스트와 글 사이 간격

            // HOT 인기글 배경색 추가
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 243, 235), // 옅은 오렌지색 배경
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orangeAccent), // 경계선 추가
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHotPost('[자유] 게시판 제목 1'),
                  const SizedBox(height: 10),
                  _buildHotPost('[익명] 게시판 제목 2'),
                  const SizedBox(height: 10),
                  _buildHotPost('[오운완] 게시판 제목 3'),
                  const SizedBox(height: 10),
                  _buildHotPost('[러닝] 게시판 제목 4'),
                  const SizedBox(height: 10),
                  _buildHotPost('[헬린이] 게시판 제목 5'),
                  const SizedBox(height: 10),
                  _buildHotPost('[식단] 게시판 제목 6'),
                  const SizedBox(height: 10),
                  _buildHotPost('[첼린지] 게시판 제목 7'),
                  const SizedBox(height: 10),
                  _buildHotPost('[공지사항] 게시판 제목 8'),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),

            MyMission(),
            DeadlineMission(),
          ],
        ),
      ),
    );
  }

  // 그리드 아이템을 만드는 함수 (각 버튼의 스타일)
  Widget _buildGridItem(int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0), // 오른쪽 간격 추가
      child: Draggable<String>(
        data: boardList[index], // 드래그할 데이터
        feedback: Material(
          color: Colors.transparent,
          child: _buildItemContent(index), // 드래그 중에 보이는 아이템
        ),
        childWhenDragging: const SizedBox(), // 드래그 중일 때 빈 공간
        child: GestureDetector(
          onTap: () {
            // 아이템 클릭 시 해당 게시판으로 이동
            String boardName = boardList[index];
            switch (boardName) {
              case '자유':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FreeCommunity()),
                );
                break;
              case '익명':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnonymousBoard()),
                );
                break;
              case '오운완':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WorkoutComplete()),
                );
                break;
              case '러닝':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RunningBoard()),
                );
                break;
              case '헬린이':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BeginnerFitness()),
                );
                break;
              case '식단':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DietPlan()),
                );
                break;
              case '첼린지':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FitnessChallenge()),
                );
                break;
              // 다른 게시판들을 추가하려면 여기에 추가
              default:
                break;
            }
          },
          child: DragTarget<String>(
            onAcceptWithDetails: (details) {
              setState(() {
                // 드래그된 아이템의 위치를 받아서 새로운 위치로 이동
                int oldIndex = boardList.indexOf(details.data);
                String draggedItem = boardList.removeAt(oldIndex);
                IconData draggedIcon = boardIcons.removeAt(oldIndex);

                boardList.insert(index, draggedItem);
                boardIcons.insert(index, draggedIcon);
              });
            },
            builder: (context, candidateData, rejectedData) {
              return _buildItemContent(index);
            },
          ),
        ),
      ),
    );
  }

  // 아이템 콘텐츠 생성 (아이콘 + 텍스트)
  Widget _buildItemContent(int index) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        alignment: Alignment.center,
        width: 100, // 각 버튼의 너비
        height: 100, // 각 버튼의 높이
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              boardIcons[index], // 아이콘은 boardIcons 리스트에서 가져옴
              size: 40,
              color: Color.fromARGB(255, 255, 111, 97),
            ),
            const SizedBox(height: 10),
            Text(
              boardList[index], // 텍스트는 boardList에서 가져옴
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 핫한 게시글을 만드는 함수 (컨테이너로 감싸서 배경색 추가)
  Widget _buildHotPost(String title) {
    return Row(
      children: [
        // 카테고리 텍스트 컬러 변경
        Text(
          title.split(' ')[0], // '[자유]' 등의 텍스트 부분
          style: TextStyle(
            color: Color.fromARGB(255, 255, 111, 97), // 텍스트 컬러 변경
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 5),
        // 게시글 제목 텍스트
        Text(
          title.split(' ')[1], // '게시판 제목 1' 등의 나머지 텍스트
          style: TextStyle(
            color: Colors.black, // 기본 텍스트 색상은 검정
          ),
        ),
      ],
    );
  }
}
