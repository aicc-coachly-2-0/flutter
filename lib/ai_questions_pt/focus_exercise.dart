import 'package:flutter/material.dart';
import 'package:flutter_application_test/state_controller/ai_question_notifier.dart';
import 'package:flutter_application_test/ai_questions_pt/user_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_test/home/home.dart'; // 홈 페이지 임포트

class FocusOnExercisePage extends ConsumerWidget {
  const FocusOnExercisePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Riverpod 상태 관리: 이전 상태 값들

    // Focus 상태 값
    final Set<String> selectedFocus = ref.watch(focusOnExerciseProvider);

    // 운동 초점 옵션
    final List<String> focusOptions = [
      '💪 반드시 근육 키운다!',
      '🏃‍♀️ 달리기 한번 해보자!',
      '🧘‍♂️ 스트레칭으로 유연성 증가!',
      '🏋️‍♂️ 다이어트 한다!',
      '🔥 칼로리 불태운다!',
      '🏆 대회 준비 완료!',
      '💃 춤추듯 운동!',
      '🛀 근육 피로 풀기!',
      '🚴‍♀️ 자전거 타면서 다이어트!',
      '🏃‍♂️ 유산소로 달리기!',
      '⚖️ 몸무게 줄여야 한다!',
      '🏋️‍♀️ 웨이트 트레이닝으로 근육 만들기!',
      '⛹️‍♂️ 농구처럼 즐기며 운동!',
      '🤸‍♀️ 전신 운동으로 칼로리 연소!',
      '🥇 목표 달성 위해 대회 준비!'
    ];

    // 운동 초점 선택 함수
    void onFocusSelected(String focus) {
      ref.read(focusOnExerciseProvider.notifier).toggleFocus(focus);
    }

    // "다음에 이용하기" 버튼 클릭 시 실행되는 함수 (홈 페이지로 이동하며 상태 초기화)
    void onSkip() {
      ref.read(focusOnExerciseProvider.notifier).reset(); // 선택된 항목 초기화
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Homepage(), // 홈 페이지로 이동
        ),
      );
    }

    // "다음" 버튼 클릭 시 실행되는 함수 (다음 질문 페이지로 이동)
    void onNext() {
      print("$selectedFocus");
      if (selectedFocus.isEmpty) {
        // 운동 초점이 선택되지 않은 경우 경고
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("운동 초점을 선택해주세요"),
              content: const Text("최소 하나 이상의 운동 초점을 선택해주세요."),
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
        // 선택된 운동 초점이 있으면, 이전에 선택한 상태들과 함께 다음 페이지로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PersonalInfoPage(), // 선택된 초점, 횟수, 목표, 수준, 장소 모두 전달
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("운동 초점 선택"),
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
              "어떤 부분에 초점을 두고 운동하고 싶나요? (최대 3개 선택)",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // 운동 초점 버튼 목록 (Wrap으로 2개씩 배치)
            Expanded(
              child: Wrap(
                spacing: 16, // 가로 간격
                runSpacing: 16, // 세로 간격
                children: focusOptions.map((focus) {
                  bool isSelected = selectedFocus.contains(focus);

                  return SizedBox(
                    width: (MediaQuery.of(context).size.width - 48) /
                        2, // 한 줄에 2개씩 배치 (간격 고려)
                    height: 50, // 버튼 높이를 고정
                    child: ElevatedButton(
                      onPressed: () => onFocusSelected(focus),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelected
                            ? Color.fromARGB(255, 255, 111, 97) // 선택된 버튼 색상
                            : Colors.white, // 선택되지 않은 버튼 색상
                        foregroundColor:
                            isSelected ? Colors.white : Colors.black,
                        side: BorderSide(
                            color:
                                isSelected ? Colors.transparent : Colors.black),
                        padding: const EdgeInsets.symmetric(
                            vertical: 0), // 세로 패딩을 0으로 설정
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        focus,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600), // 텍스트 크기도 적당히 줄임
                        textAlign: TextAlign.center, // 텍스트 가운데 정렬
                      ),
                    ),
                  );
                }).toList(),
              ),
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
