import 'package:flutter/material.dart';
import 'package:flutter_application_test/ai_questions_food/seven_question.dart';
import 'package:flutter_application_test/home/home.dart';
import 'package:flutter_application_test/state_controller/ai_food_questions_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SixQuestion extends ConsumerWidget {
  const SixQuestion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 상태값 가져오기
    final selectedExerciseType = ref.watch(exerciseTypeProvider);
    final selectedPostExerciseMeal = ref.watch(postExerciseMealProvider);
    final selectedSleepDuration = ref.watch(sleepDurationProvider);
    final selectedFoodStressLevel = ref.watch(foodStressLevelProvider);

    // 포인트 컬러
    const pointColor = Color.fromARGB(255, 255, 111, 97);

    // "다음에 이용할게요" 클릭 시 값 초기화 및 페이지 이동
    void onSkip() {
      // 상태 초기화
      ref.read(exerciseTypeProvider.notifier).setExerciseType(null);
      ref.read(postExerciseMealProvider.notifier).setPostExerciseMeal(null);
      ref.read(sleepDurationProvider.notifier).setSleepDuration(null);
      ref.read(foodStressLevelProvider.notifier).setFoodStressLevel(null);

      // Homepage로 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    }

    // 운동 종류, 식사 후 회복 여부, 수면 시간, 음식 스트레스 항목 리스트
    final exerciseTypes = ['웨이트 트레이닝', '유산소', '혼합형', '요가', '필라테스', '기타(작성란)'];
    final postExerciseMeals = ['예', '아니오'];
    final sleepDurations = ['6시간 이하', '6~7시간', '7~8시간', '8시간 이상'];
    final foodStressLevels = ['매우 많이', '보통', '아주 조금', '전혀 받지 않음'];

    // 버튼을 생성하는 함수
    Widget buildChoiceButton({
      required String title,
      required String currentSelection,
      required Function(String) onSelected,
    }) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              currentSelection == title ? pointColor : Colors.white,
          foregroundColor:
              currentSelection == title ? Colors.white : Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () => onSelected(title),
        child: Text(title, style: const TextStyle(fontSize: 16)),
      );
    }

    // onNext 함수 추가
    void onNext() {
      // 선택된 값 출력
      print("선택된 운동 종류: $selectedExerciseType");
      print("운동 후 회복을 위한 식사: $selectedPostExerciseMeal");
      print("하루에 잠자는 시간: $selectedSleepDuration");
      print("음식에 대한 스트레스: $selectedFoodStressLevel");

      // 값이 선택되었을 경우 페이지 이동
      if (selectedExerciseType != null &&
          selectedPostExerciseMeal != null &&
          selectedSleepDuration != null &&
          selectedFoodStressLevel != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SevenQuestion()),
        );
      } else {
        // 값이 선택되지 않으면 경고 메시지 표시
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("모든 질문에 답해주세요."),
          ),
        );
      }
    }

    const progress = 5 / 7; // 총 7단계에서 각 단계마다 13%씩

    return Scaffold(
      appBar: AppBar(
        title: const Text("운동 & 수면 & 음식 스트레스"),
        backgroundColor: const Color.fromARGB(255, 255, 111, 97),
        actions: [
          TextButton(
            onPressed: onSkip, // onSkip 함수 사용
            child: const Text(
              '다음에 이용할게요',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearProgressIndicator(
              value: progress, // 13%씩 증가
              backgroundColor: Colors.grey[300],
              color: pointColor,
              minHeight: 5,
            ),
            const SizedBox(height: 20),

            const Text(
              "운동 종류를 선택해주세요.",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),
            // 운동 종류 버튼 리스트 생성
            ...exerciseTypes.map((type) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: buildChoiceButton(
                    title: type,
                    currentSelection: selectedExerciseType ?? '',
                    onSelected: (selection) {
                      ref
                          .read(exerciseTypeProvider.notifier)
                          .setExerciseType(selection);
                    },
                  ),
                )),

            const SizedBox(height: 30),
            const Text(
              "운동 후 회복을 위한 식사를 하시나요?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            // 운동 후 회복을 위한 식사 여부 버튼 리스트 생성
            ...postExerciseMeals.map((meal) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: buildChoiceButton(
                    title: meal,
                    currentSelection: selectedPostExerciseMeal ?? '',
                    onSelected: (selection) {
                      ref
                          .read(postExerciseMealProvider.notifier)
                          .setPostExerciseMeal(selection);
                    },
                  ),
                )),

            const SizedBox(height: 30),
            const Text(
              "하루에 잠자는 시간을 선택해주세요.",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            // 잠자는 시간 버튼 리스트 생성
            ...sleepDurations.map((duration) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: buildChoiceButton(
                    title: duration,
                    currentSelection: selectedSleepDuration ?? '',
                    onSelected: (selection) {
                      ref
                          .read(sleepDurationProvider.notifier)
                          .setSleepDuration(selection);
                    },
                  ),
                )),

            const SizedBox(height: 30),
            const Text(
              "음식에 대한 스트레스를 많이 받으시나요?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            // 음식 스트레스 버튼 리스트 생성
            ...foodStressLevels.map((level) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: buildChoiceButton(
                    title: level,
                    currentSelection: selectedFoodStressLevel ?? '',
                    onSelected: (selection) {
                      ref
                          .read(foodStressLevelProvider.notifier)
                          .setFoodStressLevel(selection);
                    },
                  ),
                )),

            const SizedBox(height: 20),
            // "다음" 버튼 추가
            ElevatedButton(
              onPressed: onNext, // onNext 함수 호출
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: pointColor,
              ),
              child: const Text("다음",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
