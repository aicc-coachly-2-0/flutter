import 'package:flutter/material.dart';
import 'package:flutter_application_test/ai_questions_food/four_question.dart';
import 'package:flutter_application_test/state_controller/ai_food_questions_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThirdQuestion extends ConsumerWidget {
  const ThirdQuestion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 상태값 가져오기
    final allergy = ref.watch(allergyProvider);
    final isVegetarian = ref.watch(vegetarianProvider);
    final selectedDietPlans = ref.watch(dietPlanProvider);

    // 포인트 컬러
    const pointColor = Color.fromARGB(255, 255, 111, 97);

    // 알레르기 상태 업데이트
    void onAllergySelected(String? selection) {
      ref.read(allergyProvider.notifier).setAllergy(selection);
    }

    // 채식주의자 상태 업데이트
    void onVegetarianSelected(bool isVeg) {
      ref.read(vegetarianProvider.notifier).setVegetarian(isVeg);
    }

    // 다이어트 식단 선택 상태 업데이트
    void onDietPlanToggle(String dietPlan) {
      ref.read(dietPlanProvider.notifier).toggleDietPlan(dietPlan);
    }

    // "다음" 클릭 시
    void onNext(BuildContext context) {
      print('$allergy $isVegetarian $selectedDietPlans');
      if (allergy != null &&
          isVegetarian != null &&
          selectedDietPlans.isNotEmpty) {
        // 모든 값이 입력되었으면 다음 페이지로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FourQuestion(), // FourQuestion 페이지로 이동
          ),
        );
      } else {
        // 하나라도 값이 비어 있으면 경고 메시지 표시
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("모든 질문에 답해주세요.")),
        );
      }
    }

    // 다이어트 식단 옵션 리스트
    final dietPlans = ['저탄수화물', '고단백', '지중해식 식단', '간혈적 단식', '특정 칼로리 섭취 목표'];
    const progress = 2 / 7; // 총 7단계에서 각 단계마다 13%씩

    return Scaffold(
      appBar: AppBar(
        title: const Text("알레르기 및 다이어트 정보"),
        backgroundColor: pointColor,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/fourQuestion');
            },
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
              "알레르기나 주의해야 할 음식이 있나요?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: allergy == "예" ? pointColor : Colors.white,
                    foregroundColor:
                        allergy == "예" ? Colors.white : Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => onAllergySelected("예"),
                  child: const Text('예', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        allergy == "아니오" ? pointColor : Colors.white,
                    foregroundColor:
                        allergy == "아니오" ? Colors.white : Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => onAllergySelected("아니오"),
                  child: const Text('아니오', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
            if (allergy == "예") ...[
              const SizedBox(height: 10),
              const Text(
                "어떤 음식에 알레르기가 있나요?",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                  hintText: '알레르기 음식을 입력하세요',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
            const SizedBox(height: 20),
            const Text(
              "채식주의자이신가요?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isVegetarian == true ? pointColor : Colors.white,
                    foregroundColor:
                        isVegetarian == true ? Colors.white : Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => onVegetarianSelected(true),
                  child: const Text('예', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isVegetarian == false ? pointColor : Colors.white,
                    foregroundColor:
                        isVegetarian == false ? Colors.white : Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => onVegetarianSelected(false),
                  child: const Text('아니오', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "따르고 있는 다이어트 식단이 있나요?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 다이어트 식단 옵션들을 한 줄에 하나씩 배치
                ...dietPlans.map((dietPlan) {
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SizedBox(
                        width: double.infinity, // 버튼이 가로폭을 꽉 채우도록 설정
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                selectedDietPlans.contains(dietPlan)
                                    ? pointColor
                                    : Colors.white,
                            foregroundColor:
                                selectedDietPlans.contains(dietPlan)
                                    ? Colors.white
                                    : Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () => onDietPlanToggle(dietPlan),
                          child: Text(dietPlan,
                              style: const TextStyle(fontSize: 16)),
                        ),
                      ));
                }),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onNext(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: pointColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
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
