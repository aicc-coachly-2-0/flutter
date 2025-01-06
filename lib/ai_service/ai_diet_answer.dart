import 'package:flutter/material.dart';
import 'package:flutter_application_test/state_controller/ai_answer_cotroller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_test/state_controller/ai_food_questions_notifier.dart';
import 'package:flutter_application_test/home/home.dart'; // 홈 페이지 임포트

class AiDietAnswer extends ConsumerStatefulWidget {
  final List<String> aiAnswers;

  const AiDietAnswer({super.key, required this.aiAnswers});

  @override
  _AiDietAnswerState createState() => _AiDietAnswerState();
}

class _AiDietAnswerState extends ConsumerState<AiDietAnswer> {
  int currentAnswerIndex = 0; // 현재 페이지의 인덱스를 추적

  @override
  Widget build(BuildContext context) {
    // 현재 답변을 currentAnswerIndex에 맞게 설정
    String currentAnswer = widget.aiAnswers[currentAnswerIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("AI 식단 추천"),
        backgroundColor: const Color.fromARGB(255, 255, 111, 97),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "AI가 추천하는 식단입니다:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // 현재 답변 표시
            Text(
              currentAnswer,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            // 버튼들
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // 버튼을 한 줄에 세 개 배치
              children: [
                // '이전' 버튼
                if (currentAnswerIndex > 0) // 두 번째 이상 페이지에서 "이전" 버튼 표시
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentAnswerIndex--; // 이전 답변으로 이동
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 111, 97),
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        '이전',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                // '저장하기' 버튼
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ref
                          .read(aiDietAnswersProvider.notifier)
                          .addAnswer(currentAnswer);
                      print("저장된 답변: ${ref.read(aiDietAnswersProvider)}");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Homepage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 111, 97),
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      '저장하기',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                // '다음' 버튼
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // 마지막 답변이 아니면 인덱스를 증가시켜서 다음 답변으로 이동
                      if (currentAnswerIndex < widget.aiAnswers.length - 1) {
                        setState(() {
                          currentAnswerIndex++; // 답변 인덱스를 증가시킴
                        });
                      } else {
                        // 마지막 답변을 본 경우, 홈 화면으로 돌아가기
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Homepage(),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 111, 97),
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      currentAnswerIndex == widget.aiAnswers.length - 1
                          ? '확인'
                          : '다음',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
