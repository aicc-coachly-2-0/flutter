import 'package:flutter/material.dart';
import 'package:flutter_application_test/state_controller/ai_question_notifier.dart';
import 'package:flutter_application_test/ai_questions_pt/focus_exercise.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpod 추가
import 'package:flutter_application_test/home/home.dart'; // 홈 페이지 임포트

class WeeklyExercisePage extends ConsumerWidget {
  const WeeklyExercisePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Riverpod 상태 관리
    final selectedExerciseFrequency = ref.watch(exerciseFrequencyProvider);
    final selectedGoal = ref.watch(exerciseGoalProvider);

    final List<String> frequencies = ['1번', '2번', '3~4회', '5~6회'];
    final List<String> goals = ['체중감량', '근육증가', '재활', '대회준비', '정한 목표 없음'];

    // 운동 가능 횟수 선택 함수
    void onFrequencySelected(String frequency) {
      ref
          .read(exerciseFrequencyProvider.notifier)
          .setExerciseFrequency(frequency);
    }

    // 운동 목표 선택 함수
    void onGoalSelected(String goal) {
      ref.read(exerciseGoalProvider.notifier).setExerciseGoal(goal);
    }

    // "다음에 이용하기" 버튼 클릭 시 실행되는 함수 (홈 페이지로 이동하며 상태 초기화)
    void onSkip() {
      ref.read(exerciseFrequencyProvider.notifier).reset(); // 운동 횟수 초기화
      ref.read(exerciseGoalProvider.notifier).reset(); // 운동 목표 초기화

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Homepage(), // 홈 페이지로 이동
        ),
      );
    }

    // "다음" 버튼 클릭 시 실행되는 함수 (다음 질문 페이지로 이동)
    void onNext() {
      print("$selectedExerciseFrequency $selectedGoal");

      if (selectedExerciseFrequency == null || selectedGoal == null) {
        // 운동 횟수나 목표가 선택되지 않은 경우 경고
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("운동 횟수와 목표를 선택해주세요"),
              content: const Text("운동 횟수와 목표를 모두 선택한 후 진행해주세요."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 다이얼로그 닫기
                  },
                  child: const Text("확인"),
                ),
              ],
            );
          },
        );
      } else {
        // 운동 횟수와 목표가 모두 선택된 경우 다음 질문 페이지로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const FocusOnExercisePage(), // 임시로 FocusOnExercisePage로 이동
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("운동 횟수와 목표 선택"),
        backgroundColor: const Color.fromARGB(255, 255, 111, 97),
        actions: [
          // "다음에 이용하기" 버튼 (오른쪽 상단)
          TextButton(
            onPressed: onSkip,
            child: const Text(
              "다음에 이용하기",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "운동 가능한 횟수를 선택해주세요.",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // 운동 횟수 선택 버튼
            Column(
              children: frequencies.map((frequency) {
                bool isSelected = selectedExerciseFrequency == frequency;

                return Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9, // 버튼 너비 90%
                    child: ElevatedButton(
                      onPressed: () => onFrequencySelected(frequency),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelected
                            ? const Color.fromARGB(255, 255, 111, 97)
                            : Colors.white,
                        foregroundColor:
                            isSelected ? Colors.white : Colors.black,
                        side: BorderSide(
                            color:
                                isSelected ? Colors.transparent : Colors.black),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child:
                          Text(frequency, style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              "운동 목표를 선택해주세요.",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // 운동 목표 선택 버튼
            Column(
              children: goals.map((goal) {
                bool isSelected = selectedGoal == goal;

                return Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9, // 버튼 너비 90%
                    child: ElevatedButton(
                      onPressed: () => onGoalSelected(goal),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelected
                            ? const Color.fromARGB(255, 255, 111, 97)
                            : Colors.white,
                        foregroundColor:
                            isSelected ? Colors.white : Colors.black,
                        side: BorderSide(
                            color:
                                isSelected ? Colors.transparent : Colors.black),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(goal, style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      // "다음" 버튼 (오른쪽 하단)
      floatingActionButton: FloatingActionButton(
        onPressed: onNext,
        backgroundColor: const Color.fromARGB(255, 255, 111, 97),
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
