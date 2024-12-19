import 'package:flutter/material.dart';
import 'package:flutter_application_test/state_controller/ai_question_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // flutter_riverpod 추가
import 'package:flutter_application_test/ai_questions_pt/select_place.dart';
import 'package:flutter_application_test/home/home.dart';

class ExerciseLevelPage extends ConsumerWidget {
  const ExerciseLevelPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLevel = ref.watch(exerciseLevelProvider); // 선택된 운동 수준 상태
    final List<String> levels = ['입문', '초급', '중급', '고급', '선수'];

    // 운동 수준 선택 함수
    void onLevelSelected(String level) {
      ref
          .read(exerciseLevelProvider.notifier)
          .setExerciseLevel(level); // 운동 수준 상태 업데이트
    }

    // ExerciseLevelPage에서 상태 관리
    void onNext() {
      print("$selectedLevel");
      if (selectedLevel == null) {
        // 운동 수준이 선택되지 않은 경우 경고
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("운동 수준을 선택해주세요"),
              content: const Text("운동 수준을 선택한 후 진행해주세요."),
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
        // 운동 수준 선택 후 운동 장소 선택 페이지로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SelectPlacePage(), // 값을 넘기지 않고 이동
          ),
        );
      }
    }

    // "다음에 이용하기" 버튼 클릭 시 실행되는 함수 (상태 초기화 후 홈 페이지로 이동)
    void onSkip() {
      // 상태 초기화
      ref
          .read(exerciseLevelProvider.notifier)
          .setExerciseLevel(null); // 운동 수준 초기화

      // 홈 페이지로 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Homepage(), // 홈 페이지로 이동
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("운동 수준 선택"),
        backgroundColor: const Color.fromARGB(255, 255, 111, 97),
        actions: [
          // "다음에 이용하기" 버튼 (오른쪽 상단)
          TextButton(
            onPressed: onSkip, // 상태 초기화 및 홈 페이지로 이동
            child: const Text(
              "다음에 이용하기",
              style: TextStyle(color: Colors.black),
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
              "운동 수준을 선택해주세요.",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // 운동 수준 버튼
            Column(
              children: levels.map((level) {
                bool isSelected = selectedLevel == level;

                return Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      onPressed: () => onLevelSelected(level), // 운동 수준 설정
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelected
                            ? const Color.fromARGB(255, 255, 111, 97)
                            : Colors.white,
                        foregroundColor:
                            isSelected ? Colors.white : Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(level, style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onNext,
        backgroundColor: const Color.fromARGB(255, 255, 111, 97),
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
