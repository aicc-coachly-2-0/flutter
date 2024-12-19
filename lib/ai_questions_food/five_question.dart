import 'package:flutter/material.dart';
import 'package:flutter_application_test/ai_questions_food/six_question.dart';
import 'package:flutter_application_test/home/home.dart';
import 'package:flutter_application_test/state_controller/ai_food_questions_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiveQuestion extends ConsumerWidget {
  const FiveQuestion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 상태값 가져오기
    final snackFrequency = ref.watch(snackFrequencyProvider);
    final currentWeight = ref.watch(currentWeightProvider);
    final goalWeight = ref.watch(goalWeightProvider);
    final bloodSugarControl = ref.watch(bloodSugarControlProvider);
    final exerciseFrequency = ref.watch(dietExerciseFrequencyProvider);

    // 포인트 컬러
    const pointColor = Color.fromARGB(255, 255, 111, 97);

    // 각 옵션 리스트
    final snackFrequencies = ['자주 먹는다', '가끔 먹는다', '잘 먹지 않는다', '전혀 먹지 않는다'];

    final exerciseFrequencies = [
      '하루',
      '주 1~2회',
      '주 3~5회',
      '거의 매일 한다',
      '전혀 하지 않음'
    ];

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
      ref.read(snackFrequencyProvider.notifier).reset();
      ref.read(currentWeightProvider.notifier).reset();
      ref.read(goalWeightProvider.notifier).reset();
      ref.read(bloodSugarControlProvider.notifier).reset();
      ref.read(dietExerciseFrequencyProvider.notifier).reset();

      // 필요한 페이지로 이동 (예시: Homepage)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    }

    // "다음" 클릭 시 값 체크 후 페이지 이동
    void onNext() {
      print(
          '$snackFrequency $currentWeight $goalWeight $bloodSugarControl $exerciseFrequency');
      if (snackFrequency != null &&
          bloodSugarControl != null &&
          exerciseFrequency != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const SixQuestion()), // NextPage를 원하는 페이지로 변경
        );
      } else {
        // 하나라도 값이 비어 있으면 경고 메시지 표시
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("모든 질문에 답해주세요.")),
        );
      }
    }

    const progress = 4 / 7; // 총 7단계에서 각 단계마다 13%씩

    return Scaffold(
      appBar: AppBar(
        title: const Text("질문 5"),
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
              "간식을 자주 드시나요?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),
            // 간식 섭취 빈도 버튼 리스트 생성
            ...snackFrequencies.map((frequency) {
              return buildChoiceButton(
                title: frequency,
                currentSelection: snackFrequency,
                onSelected: (selection) {
                  ref
                      .read(snackFrequencyProvider.notifier)
                      .setSnackFrequency(selection);
                },
              );
            }),
            const SizedBox(height: 30),

            const Text(
              "현재 몸무게는 얼마인가요?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // 몸무게 입력 필드
            Slider(
              value: currentWeight,
              min: 30.0, // 최소값 30kg
              max: 150.0, // 최대값 150kg
              divisions: 240, // 0.5kg 단위로 나누기
              label: '${currentWeight.toStringAsFixed(1)} kg', // 값 표시
              onChanged: (double newValue) {
                ref
                    .read(currentWeightProvider.notifier)
                    .setCurrentWeight(newValue);
              },
            ),
            Text(
              '${currentWeight.toStringAsFixed(1)} kg', // 선택된 몸무게 표시
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),

            const Text(
              "목표 몸무게는 얼마인가요?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // 목표 몸무게 입력 필드
            Slider(
              value: goalWeight,
              min: 30.0, // 최소값 30kg
              max: 150.0, // 최대값 150kg
              divisions: 240, // 0.5kg 단위로 나누기
              label: '${goalWeight.toStringAsFixed(1)} kg', // 값 표시
              onChanged: (double newValue) {
                ref.read(goalWeightProvider.notifier).setGoalWeight(newValue);
              },
            ),
            Text(
              '${goalWeight.toStringAsFixed(1)} kg', // 선택된 목표 몸무게 표시
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),

            const Text(
              "식사 후 혈당 관리를 하고 있나요?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // 혈당 관리 여부 (예/아니오) 선택
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(bloodSugarControlProvider.notifier)
                        .setBloodSugarControl(true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        bloodSugarControl == true ? pointColor : Colors.white,
                    foregroundColor:
                        bloodSugarControl == true ? Colors.white : Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('예', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(bloodSugarControlProvider.notifier)
                        .setBloodSugarControl(false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        bloodSugarControl == false ? pointColor : Colors.white,
                    foregroundColor: bloodSugarControl == false
                        ? Colors.white
                        : Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('아니오', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
            const SizedBox(height: 30),

            const Text(
              "운동 빈도는 어떻게 되나요?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // 운동 빈도 버튼 리스트 생성
            ...exerciseFrequencies.map((frequency) {
              return buildChoiceButton(
                title: frequency,
                currentSelection: exerciseFrequency,
                onSelected: (selection) {
                  ref
                      .read(dietExerciseFrequencyProvider.notifier)
                      .setExerciseFrequency(selection);
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
