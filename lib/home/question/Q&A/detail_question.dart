import 'package:flutter/material.dart';
import 'package:flutter_application_test/get_method/my_question_get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailQuestionPage extends ConsumerWidget {
  final Question question;

  const DetailQuestionPage({super.key, required this.question});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answersAsyncValue =
        ref.watch(answersProvider(question.questionNumber)); // 답변 가져오기

    return Scaffold(
      appBar: AppBar(
        title: Text('문의 상세보기'),
        backgroundColor: Color.fromARGB(255, 255, 111, 97), // 상단바 색상
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목
            Text(
              question.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            // 내용
            Text(
              question.questionContent,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            // 생성일
            Text(
              '작성일: ${_formatDate(question.createdAt)}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            // 답변
            answersAsyncValue.when(
              data: (answers) {
                if (answers.isEmpty) {
                  return Text("답변이 없습니다.");
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   '답변:',
                    //   style: TextStyle(
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.black,
                    //   ),
                    // ),
                    const SizedBox(height: 8),
                    for (var answer in answers)
                      _buildAnswerSection(answer), // 답변 표시
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(child: Text('답변 대기중입니다')),
            ),
          ],
        ),
      ),
    );
  }

  // 날짜 포맷 함수
  String _formatDate(String dateStr) {
    DateTime dateTime = DateTime.parse(dateStr);
    return '${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}';
  }

  // 답변 섹션 빌드 함수
  Widget _buildAnswerSection(Answer answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '답변 내용:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            answer.answerContent,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '답변일: ${_formatDate(answer.answerAt)}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
