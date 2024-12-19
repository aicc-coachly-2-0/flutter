import 'package:flutter/material.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '게시판 보러가기',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20), // 문구와 버튼 사이 간격

            // 게시판 버튼들을 한 줄에 3개씩 배치하여 2줄로 구성
            SizedBox(
              height: 250, // 버튼들이 들어갈 영역 높이
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // 가로로 스크롤이 가능하도록 설정
                child: Column(
                  children: [
                    // 첫 번째 줄: 3개의 버튼
                    Row(
                      children: [
                        _buildGridItem(0),
                        _buildGridItem(1),
                        _buildGridItem(2),
                        _buildGridItem(3),
                      ],
                    ),
                    const SizedBox(height: 16), // 두 줄 사이의 간격

                    // 두 번째 줄: 3개의 버튼
                    Row(
                      children: [
                        _buildGridItem(4),
                        _buildGridItem(5),
                        _buildGridItem(6),
                        _buildGridItem(7),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // 두 번째 섹션: 핫한 글 보러가기 (텍스트 형식)
            const SizedBox(height: 40), // 섹션 간 간격
            const Text(
              '핫한 글 보러가기',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20), // 문구와 버튼 사이 간격

            // 핫한 글을 텍스트로 3개만 표시 (데이터베이스와 연결 전)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '1. 가장 인기 있는 글 제목 1',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '2. 최근 인기 급상승 글 제목 2',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '3. 핫한 트렌드 글 제목 3',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
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
}
