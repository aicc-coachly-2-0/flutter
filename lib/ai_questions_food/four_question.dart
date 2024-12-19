import 'package:flutter/material.dart';
import 'package:flutter_application_test/ai_questions_food/five_question.dart';
import 'package:flutter_application_test/home/home.dart';
import 'package:flutter_application_test/state_controller/ai_food_questions_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FourQuestion extends ConsumerWidget {
  const FourQuestion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 상태값 가져오기
    final calorieGoal = ref.watch(calorieGoalProvider);
    final mealPrepTime = ref.watch(mealPrepTimeProvider);
    final diningOut = ref.watch(diningOutProvider);

    // 포인트 컬러
    const pointColor = Color.fromARGB(255, 255, 111, 97);

    // 각 옵션 리스트
    final calorieGoals = [
      '500kcal 이하',
      '500~1000 kcal',
      '1000~1500 kcal',
      '1500~2000 kcal',
      '2000~2500 kcal',
      '2500~3000 kcal',
      '3000 이상'
    ];

    final mealPrepTimes = ['30분 이하', '1시간 이하', '1시간 이상'];

    final diningOutOptions = ['예', '아니오'];

    // 버튼 생성 함수
    Widget buildChoiceButton({
      required String title,
      required String? currentSelection,
      required Function(String) onSelected,
    }) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
          width: double.infinity, // 버튼이 가로폭을 꽉 차게
          child: ElevatedButton(
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
          ),
        ),
      );
    }

    // "다음에 이용할게요" 클릭 시 값 초기화 및 페이지 이동
    void onSkip() {
      ref.read(calorieGoalProvider.notifier).reset();
      ref.read(mealPrepTimeProvider.notifier).reset();
      ref.read(diningOutProvider.notifier).reset();

      // 필요한 페이지로 이동 (예시: Homepage)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    }

    // "다음" 클릭 시 값 체크 후 페이지 이동
    void onNext() {
      print('$calorieGoal $mealPrepTime $diningOut');
      if (calorieGoal != null && mealPrepTime != null && diningOut != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const FiveQuestion()), // NextPage를 원하는 페이지로 변경
        );
      } else {
        // 하나라도 값이 비어 있으면 경고 메시지 표시
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("모든 질문에 답해주세요.")),
        );
      }
    }

    const progress = 3 / 7; // 총 7단계에서 각 단계마다 13%씩

    return Scaffold(
      appBar: AppBar(
        title: const Text("질문 4"),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LinearProgressIndicator(
              value: progress, // 13%씩 증가
              backgroundColor: Colors.grey[300],
              color: pointColor,
              minHeight: 5,
            ),
            const SizedBox(height: 20),

            const Text(
              "하루 섭취해야 할 목표 칼로리가 있나요?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),
            // 목표 칼로리 버튼 리스트 생성
            ...calorieGoals.map((goal) {
              return buildChoiceButton(
                title: goal,
                currentSelection: calorieGoal,
                onSelected: (selection) {
                  ref
                      .read(calorieGoalProvider.notifier)
                      .setCalorieGoal(selection);
                },
              );
            }),
            const SizedBox(height: 30),

            const Text(
              "한 끼 식사 준비에 걸리는 시간은 얼마나 되나요?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // 식사 준비 시간 버튼 리스트 생성
            ...mealPrepTimes.map((time) {
              return buildChoiceButton(
                title: time,
                currentSelection: mealPrepTime,
                onSelected: (selection) {
                  ref
                      .read(mealPrepTimeProvider.notifier)
                      .setMealPrepTime(selection);
                },
              );
            }),
            const SizedBox(height: 30),

            const Text(
              "주로 외식을 하나요?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // 외식 여부 버튼 생성
            ...diningOutOptions.map((option) {
              return buildChoiceButton(
                title: option,
                currentSelection: diningOut == true
                    ? '예'
                    : diningOut == false
                        ? '아니오'
                        : null,
                onSelected: (selection) {
                  ref
                      .read(diningOutProvider.notifier)
                      .setDiningOut(selection == '예');
                },
              );
            }),
            const SizedBox(height: 30),

            // "다음" 버튼
            ElevatedButton(
              onPressed: onNext, // onNext 함수 사용
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: pointColor,
              ),
              child: const Text(
                "다음",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
