import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/home.dart';
import 'package:flutter_application_test/ai_questions_food/second_question.dart';
import 'package:flutter_application_test/state_controller/ai_food_questions_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirstQuestion extends ConsumerWidget {
  const FirstQuestion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 상태값 가져오기
    final selectedGoal = ref.watch(dietGoalProvider);
    final selectedMealsPerDay = ref.watch(mealFrequencyProvider);

    // 포인트 컬러
    const pointColor = Color.fromARGB(255, 255, 111, 97);

    // "다음에 이용할게요" 클릭 시 값 초기화 및 페이지 이동
    void onSkip() {
      // dietGoalProvider와 mealFrequencyProvider 초기화
      ref.read(dietGoalProvider.notifier).setDietGoal(null);
      ref.read(mealFrequencyProvider.notifier).setMealFrequency(null);

      // Homepage로 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    }

    // 목표와 끼니 리스트
    final dietGoals = ['체중감량', '체중증가', '근육증가', '체중유지'];
    final mealsPerDayOptions = ['1끼', '2끼', '3끼', '4끼', '5끼 이상'];

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
          // side: BorderSide(color: pointColor),
        ),
        onPressed: () => onSelected(title),
        child: Text(title, style: const TextStyle(fontSize: 16)),
      );
    }

    // onNext 함수 추가
    void onNext() {
      // 값이 선택되었을 경우 출력 및 페이지 이동
      if (selectedGoal != null && selectedMealsPerDay != null) {
        // 선택된 값 출력
        print("선택된 식단 목표: $selectedGoal");
        print("선택된 하루 끼니 수: $selectedMealsPerDay");

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SecondQuestion()),
        );
      } else {
        // 값이 선택되지 않았을 경우 경고 메시지 표시
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("모든 질문에 답해주세요."),
          ),
        );
      }
    }

    // 진행 상황 계산 (13%씩 차는 구조)
    const progress = 0 / 7; // 총 7단계에서 각 단계마다 13%씩

    return Scaffold(
      appBar: AppBar(
        title: const Text("식단 목표 선택"),
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
        // 여기서 SingleChildScrollView로 감싸기
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 진행 상태 표시
            LinearProgressIndicator(
              value: progress, // 13%씩 증가
              backgroundColor: Colors.grey[300],
              color: pointColor,
              minHeight: 5,
            ),
            const SizedBox(height: 20),

            const Text(
              "당신의 식단 목표는 무엇인가?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            // 식단 목표 버튼 리스트 생성
            ...dietGoals.map((goal) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: buildChoiceButton(
                    title: goal,
                    currentSelection: selectedGoal ?? '',
                    onSelected: (selection) {
                      ref
                          .read(dietGoalProvider.notifier)
                          .setDietGoal(selection);
                    },
                  ),
                )),

            const SizedBox(height: 30),
            const Text(
              "하루에 몇 끼를 먹나요?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            // 하루에 몇 끼를 먹는지 선택하는 버튼 리스트 생성
            ...mealsPerDayOptions.map((meal) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: buildChoiceButton(
                    title: meal,
                    currentSelection: selectedMealsPerDay ?? '',
                    onSelected: (selection) {
                      ref
                          .read(mealFrequencyProvider.notifier)
                          .setMealFrequency(selection);
                    },
                  ),
                )),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onNext, // onNext 함수 호출
              style: ElevatedButton.styleFrom(
                backgroundColor: pointColor,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text(
                '다음',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
