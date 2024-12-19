import 'package:flutter/material.dart';
import 'package:flutter_application_test/ai_questions_food/eight_question.dart';
import 'package:flutter_application_test/home/home.dart';
import 'package:flutter_application_test/state_controller/ai_food_questions_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SevenQuestion extends ConsumerWidget {
  const SevenQuestion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 상태값 가져오기
    final selectedAlcoholConsumption = ref.watch(alcoholConsumptionProvider);
    final selectedMealEnvironment = ref.watch(mealEnvironmentProvider);
    final selectedMealPreferences = ref.watch(mealPreferencesProvider);

    // 포인트 컬러
    const pointColor = Color.fromARGB(255, 255, 111, 97);

    // "다음에 이용할게요" 클릭 시 값 초기화 및 페이지 이동
    void onSkip() {
      // 상태 초기화
      ref.read(alcoholConsumptionProvider.notifier).setAlcoholConsumption(null);
      ref.read(mealEnvironmentProvider.notifier).setMealEnvironment(null);
      ref.read(mealPreferencesProvider.notifier).setMealPreferences(null);

      // Homepage로 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    }

    // 음주 여부, 식사 환경, 식사 관련 원하는 점 리스트
    final alcoholConsumptions = ['매일 마신다', '가끔 마신다', '전혀 하지 않는다'];
    final mealEnvironments = ['혼자', '가족 또는 친구', '밖에서', '일이 많은 환경에서 빠르게'];

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

    // "다음" 클릭 시 값 체크 후 페이지 이동
    void onNext() {
      print(
          '$selectedAlcoholConsumption $selectedMealEnvironment $selectedMealPreferences');
      if (selectedAlcoholConsumption != null &&
          selectedMealEnvironment != null &&
          selectedMealPreferences != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const DietRecommendationPage()), // NextPage를 원하는 페이지로 변경
        );
      } else {
        // 하나라도 값이 비어 있으면 경고 메시지 표시
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("모든 질문에 답해주세요.")),
        );
      }
    }

    const progress = 6 / 7; // 총 7단계에서 각 단계마다 13%씩

    return Scaffold(
      appBar: AppBar(
        title: const Text("음주, 식사 환경 및 식사 관련 요청"),
        backgroundColor: pointColor,
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
              "음주를 하시나요?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),
            // 음주 여부 버튼 리스트 생성
            ...alcoholConsumptions.map((consumption) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: buildChoiceButton(
                    title: consumption,
                    currentSelection: selectedAlcoholConsumption ?? '',
                    onSelected: (selection) {
                      ref
                          .read(alcoholConsumptionProvider.notifier)
                          .setAlcoholConsumption(selection);
                    },
                  ),
                )),

            const SizedBox(height: 30),
            const Text(
              "식사를 하실 때 어떤 환경을 선호하시나요?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            // 식사 환경 버튼 리스트 생성
            ...mealEnvironments.map((environment) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: buildChoiceButton(
                    title: environment,
                    currentSelection: selectedMealEnvironment ?? '',
                    onSelected: (selection) {
                      ref
                          .read(mealEnvironmentProvider.notifier)
                          .setMealEnvironment(selection);
                    },
                  ),
                )),

            const SizedBox(height: 30),
            const Text(
              "식사와 관련해 원하시는 점이 있나요?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // 식사 관련 요청을 입력하는 필드
            TextField(
              onChanged: (value) {
                ref
                    .read(mealPreferencesProvider.notifier)
                    .setMealPreferences(value);
              },
              decoration: const InputDecoration(
                labelText: '예) 조리법, 칼로리 제한 등',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onNext,
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
