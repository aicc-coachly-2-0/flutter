import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/home.dart';
import 'package:flutter_application_test/state_controller/ai_food_questions_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'third_question.dart'; // ThirdQuestion 페이지 임포트

class SecondQuestion extends ConsumerWidget {
  const SecondQuestion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 상태값 가져오기
    final selectedActivityLevel = ref.watch(activityLevelProvider);
    final selectedFoodPreferences = ref.watch(foodPreferenceProvider);

    // 포인트 컬러
    const pointColor = Color.fromARGB(255, 255, 111, 97);

    // "다음에 이용할게요" 클릭 시 값 초기화 및 페이지 이동
    void onSkip() {
      // activityLevelProvider와 foodPreferenceProvider 초기화
      ref.read(activityLevelProvider.notifier).setActivityLevel(null);
      ref.read(foodPreferenceProvider.notifier).reset(); // 음식 선호 초기화

      // Homepage로 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    }

    // 활동량 및 음식 선호 항목 리스트
    final activityLevels = [
      '앉아서 일하는 직장인',
      '가벼운 운동을 함',
      '활동적인 운동을 함',
      '매우 활동적인 직업'
    ];

    final foodPreferences = ['고기', '채소', '해산물', '곡물', '유제품', '달거나 기름진 음식'];

    // 버튼을 생성하는 함수
    Widget buildChoiceButton({
      required String title,
      required List<String> currentSelection,
      required Function(String) onSelected,
    }) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              currentSelection.contains(title) ? pointColor : Colors.white,
          foregroundColor:
              currentSelection.contains(title) ? Colors.white : Colors.black,
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
      print("선택된 활동량: $selectedActivityLevel");
      print("선택된 음식 선호: $selectedFoodPreferences");

      // 값이 선택되었을 경우 페이지 이동
      if (selectedActivityLevel != null && selectedFoodPreferences.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ThirdQuestion()),
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

    const progress = 1 / 7; // 총 7단계에서 각 단계마다 13%씩

    return Scaffold(
      appBar: AppBar(
        title: const Text("활동량 & 음식 선호 선택"),
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
              "평균적인 하루 활동량은?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),
            // 활동량 버튼 리스트 생성
            ...activityLevels.map((level) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: buildChoiceButton(
                    title: level,
                    currentSelection: selectedActivityLevel != null
                        ? [selectedActivityLevel]
                        : [],
                    onSelected: (selection) {
                      ref
                          .read(activityLevelProvider.notifier)
                          .setActivityLevel(selection);
                    },
                  ),
                )),

            const SizedBox(height: 30),
            const Text(
              """어떤 음식을 주로 선호하시나요?
  (중복선택가능)""",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            // 음식 선호 버튼 리스트 생성
            ...foodPreferences.map((preference) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: buildChoiceButton(
                    title: preference,
                    currentSelection: selectedFoodPreferences,
                    onSelected: (selection) {
                      ref
                          .read(foodPreferenceProvider.notifier)
                          .toggleFoodPreference(selection);
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
