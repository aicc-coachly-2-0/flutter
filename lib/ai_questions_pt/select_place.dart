import 'package:flutter/material.dart';
import 'package:flutter_application_test/state_controller/ai_question_notifier.dart';
import 'package:flutter_application_test/ai_questions_pt/frequency.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_test/home/home.dart'; // 홈 페이지로 이동

class SelectPlacePage extends ConsumerWidget {
  const SelectPlacePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLevel = ref.watch(exerciseLevelProvider); // 운동 수준
    final selectedPlace = ref.watch(exercisePlaceProvider); // 선택된 운동 장소

    final List<String> places = ['헬스장', '집'];

    // 운동 장소 선택 함수
    void onPlaceSelected(String place) {
      ref
          .read(exercisePlaceProvider.notifier)
          .setSelectedPlace(place); // 운동 장소 상태 업데이트
    }

    // "다음" 버튼 클릭 시 실행되는 함수 (다음 페이지로 이동)
    void onNext() {
      print("$selectedPlace");
      if (selectedPlace == null) {
        // 운동 장소가 선택되지 않은 경우 경고
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("운동 장소를 선택해주세요"),
              content: const Text("운동 장소를 선택한 후 진행해주세요."),
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
      } else if (selectedLevel == null) {
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
        // 운동 수준과 운동 장소가 모두 선택된 상태에서 다음 페이지로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WeeklyExercisePage(),
          ),
        );
      }
    }

    // "다음에 이용하기" 버튼 클릭 시 실행되는 함수 (홈 페이지로 이동하며 상태 초기화)
    void onSkip() {
      ref
          .read(exerciseLevelProvider.notifier)
          .setExerciseLevel(null); // 운동 수준 초기화
      ref
          .read(exercisePlaceProvider.notifier)
          .setSelectedPlace(null); // 운동 장소 초기화

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Homepage(), // 홈 페이지로 이동
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("운동 장소 선택"),
        backgroundColor: const Color.fromARGB(255, 255, 111, 97),
        actions: [
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
              "운동 장소를 선택해주세요.",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // 운동 장소 선택 버튼
            Column(
              children: places.map((place) {
                bool isSelected = selectedPlace == place;

                return Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      onPressed: () => onPlaceSelected(place), // 선택된 장소 상태 업데이트
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
                      child: Text(place, style: const TextStyle(fontSize: 16)),
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
