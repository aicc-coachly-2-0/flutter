import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/question/Q&A/complete_questions.dart';
import 'package:flutter_application_test/home/question/Q&A/apply_question.dart';
import 'package:flutter_application_test/home/question/Q&A/question_list.dart';

class Question extends StatefulWidget {
  const Question({super.key});

  @override
  _Question createState() => _Question();
}

class _Question extends State<Question> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // TabController 설정: 2개의 탭을 사용
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose(); // TabController 종료
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255), // 앱바 색상
        title: const Text('문의하기'), // 알림 페이지 타이틀
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          // TabBar로 피드, 커뮤니티 버튼 만들기
          TabBar(
            controller: _tabController,
            indicatorColor: const Color.fromARGB(255, 255, 111, 97), // 밑줄 색상
            indicatorWeight: 3.0, // 밑줄 두께
            labelColor: Colors.black, // 선택된 탭 텍스트 색상
            unselectedLabelColor: Colors.grey, // 선택되지 않은 탭 텍스트 색상
            tabs: const [
              Tab(text: '문의 완료'), // 피드 탭
              Tab(text: '문의중'), // 커뮤니티 탭
            ],
          ),
          // TabBarView로 탭에 맞는 콘텐츠 표시
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                CompleteQuestions(), // 피드 페이지 내용
                QuestionList(), // 커뮤니티 페이지 내용
              ],
            ),
          ),
        ],
      ),
      // 오른쪽 하단에 동그란 버튼 추가
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 버튼을 눌렀을 때 동작할 내용 추가
          print("헤드셋 버튼 클릭됨");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ApplyQuestion(),
            ),
          );
        },
        backgroundColor: Color.fromARGB(255, 255, 111, 97),
        shape: CircleBorder(), // 동그란 버튼 모양을 확실하게 설정
        elevation: 6.0, // 버튼 배경 색상
        child: const Icon(
          Icons.headset_mic_outlined, // 아이콘 설정
          color: Colors.white, // 아이콘 색상
        ), // 그림자 추가 (원하는 경우 조정 가능)
      ),
    );
  }
}
