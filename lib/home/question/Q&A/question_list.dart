import 'package:flutter/material.dart';
import 'package:flutter_application_test/get_method/my_question_get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'detail_question.dart'; // 상세보기 페이지

class QuestionList extends ConsumerWidget {
  const QuestionList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncQuestions = ref.watch(myQuestionsProvider); // 질문 데이터 가져오기

    return Scaffold(
      backgroundColor: Colors.white, // 배경색 설정
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: asyncQuestions.when(
          data: (questions) {
            return ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final question = questions[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 섹션
                    _buildQuestionSection(
                      context,
                      title: question.title,
                      question: question, // `Question` 객체 전달
                    ),
                    Divider(color: Colors.grey, thickness: 1), // 구분선
                  ],
                );
              },
            );
          },
          loading: () =>
              const Center(child: CircularProgressIndicator()), // 로딩 중
          error: (error, stackTrace) => Center(
            child: Text('오류 발생: $error'),
          ), // 오류 처리
        ),
      ),
    );
  }

  // 문의 섹션 빌드 함수
  Widget _buildQuestionSection(BuildContext context,
      {required String title, required Question question}) {
    // questionClassificationNumber에 따른 카테고리 매핑
    String category = _getCategoryName(question.questionClassificationNumber);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          // 해당 질문을 클릭 시 상세 페이지로 이동
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DetailQuestionPage(question: question), // `Question` 객체 전달
            ),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 문의 유형
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 111, 97), // 색상 지정
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '[$category]', // 대괄호 안에 카테고리 표시
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 10), // 문의유형과 제목 간의 간격

            // 문의 제목
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// questionClassNumber에 따른 카테고리명 반환
String _getCategoryName(int questionClassificationNumber) {
  switch (questionClassificationNumber) {
    case 1:
      return '계정';
    case 2:
      return '커뮤니티';
    case 3:
      return '미션';
    case 4:
      return 'AI';
    case 5:
      return '결제/환불';
    case 6:
      return '신고';
    case 7:
      return '기타';
    default:
      return '기타'; // 기본값으로 '기타' 반환
  }
}
