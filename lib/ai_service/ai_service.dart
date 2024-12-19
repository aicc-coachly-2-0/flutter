import 'package:flutter/material.dart';
import 'package:flutter_application_test/ai_questions_food/agree.dart';
import 'package:flutter_application_test/ai_questions_pt/agree.dart';

class AiServiceChoice extends StatelessWidget {
  const AiServiceChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 버튼들이 세로로 가운데 정렬
          crossAxisAlignment: CrossAxisAlignment.center, // 버튼들이 가로로 가운데 정렬
          children: [
            // 화면의 70% 높이를 차지하는 부분에 버튼을 배치
            Expanded(
              flex: 7, // 화면 높이의 70% 차지
              child: Align(
                alignment: Alignment.center, // 버튼들을 화면의 세로/가로로 가운데 정렬
                child: Wrap(
                  spacing: 16, // 가로 간격
                  runSpacing: 16, // 세로 간격
                  alignment: WrapAlignment.center, // 버튼을 가운데 정렬
                  children: [
                    // 첫 번째 버튼: 운동 루틴 추천받기
                    SizedBox(
                      height: 200, // 버튼의 고정 높이
                      width: MediaQuery.of(context).size.width *
                          0.4, // 버튼의 너비 (화면 너비의 40%)
                      child: ElevatedButton(
                        onPressed: () {
                          // 운동 루틴 추천받기 버튼 클릭 시 ExerciseLevelNotifier 페이지로 이동
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ExerciseStartPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.fitness_center,
                              size: 40, // 아이콘 크기
                              color:
                                  Color.fromARGB(255, 255, 90, 239), // 아이콘 색상
                            ),
                            const SizedBox(height: 10), // 아이콘과 텍스트 사이 간격
                            const Text(
                              'AI를 통한 운동 루틴 추천받기',
                              style: TextStyle(
                                fontSize: 20,
                                color:
                                    Color.fromARGB(255, 255, 90, 239), // 텍스트 색상
                              ),
                              textAlign: TextAlign.center, // 텍스트 가운데 정렬
                            ),
                          ],
                        ),
                      ),
                    ),
                    // 두 번째 버튼: 식단 관리 받기
                    SizedBox(
                      height: 200, // 버튼의 고정 높이
                      width: MediaQuery.of(context).size.width *
                          0.4, // 버튼의 너비 (화면 너비의 40%)
                      child: ElevatedButton(
                        onPressed: () {
                          // 식단 관리 받기 버튼 클릭 시 처리
                          print("식단 관리 받기 버튼 클릭됨");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DietStartPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.restaurant,
                              size: 40, // 아이콘 크기
                              color:
                                  Color.fromARGB(255, 255, 90, 239), // 아이콘 색상
                            ),
                            const SizedBox(height: 10), // 아이콘과 텍스트 사이 간격
                            const Text(
                              'AI를 통한 식단 관리 받기',
                              style: TextStyle(
                                fontSize: 20,
                                color:
                                    Color.fromARGB(255, 214, 90, 255), // 텍스트 색상
                              ),
                              textAlign: TextAlign.center, // 텍스트 가운데 정렬
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
