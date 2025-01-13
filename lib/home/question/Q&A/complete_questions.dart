// complete_questions.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/question/Q&A/detail_question.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_test/get_method/my_question_get.dart';
import 'package:flutter_application_test/state_controller/loginProvider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CompleteQuestions extends ConsumerWidget {
  const CompleteQuestions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completeQuestionsAsyncValue = ref.watch(answeredQuestionsProvider);

    return Scaffold(
      backgroundColor: Colors.white, // 배경색 설정
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: completeQuestionsAsyncValue.when(
          data: (questions) {
            return ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final question = questions[index];
                return _buildQuestionSection(context, question);
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }

  // 문의 섹션 빌드 함수
  Widget _buildQuestionSection(BuildContext context, Question question) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          // 상세 보기 페이지로 이동
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailQuestionPage(question: question),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.green.withOpacity(0.1), // 완료된 질문 배경
            border: Border.all(
              color: Colors.green, // 완료된 질문은 초록색 테두리
            ),
          ),
          child: Row(
            children: [
              // 상태 아이콘
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 18,
              ),
              const SizedBox(width: 10),
              // 제목
              Expanded(
                child: Text(
                  question.title,
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
      ),
    );
  }
}
