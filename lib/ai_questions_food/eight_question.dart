import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/state_controller/ai_food_questions_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_test/ai_service/ai_diet_answer.dart'; // AI 식단 응답 페이지 임포트

class DietRecommendationPage extends ConsumerStatefulWidget {
  const DietRecommendationPage({super.key});

  @override
  _DietRecommendationPageState createState() => _DietRecommendationPageState();
}

class _DietRecommendationPageState
    extends ConsumerState<DietRecommendationPage> {
  // "제출하기" 버튼 클릭 시 서버로 데이터를 보내는 함수
  Future<void> _submitData() async {
    ref.read(loadingStateProvider.notifier).startLoading();

    // 상태들 가져오기
    final selectedDietGoal = ref.read(dietGoalProvider);
    final selectedMealFrequency = ref.read(mealFrequencyProvider);
    final selectedActivityLevel = ref.read(activityLevelProvider);
    final selectedFoodPreferences = ref.read(foodPreferenceProvider);
    final selectedAllergy = ref.read(allergyProvider);
    final selectedVegetarian = ref.read(vegetarianProvider);
    final selectedDietPlan = ref.read(dietPlanProvider);
    final selectedCalorieGoal = ref.read(calorieGoalProvider);
    final selectedMealPrepTime = ref.read(mealPrepTimeProvider);
    final selectedDiningOut = ref.read(diningOutProvider);
    final selectedSnackFrequency = ref.read(snackFrequencyProvider);
    final currentWeight = ref.read(currentWeightProvider);
    final goalWeight = ref.read(goalWeightProvider);
    final selectedBloodSugarControl = ref.read(bloodSugarControlProvider);
    final selectedExerciseFrequency = ref.read(dietExerciseFrequencyProvider);
    final selectedExerciseType = ref.read(exerciseTypeProvider);
    final selectedPostExerciseMeal = ref.read(postExerciseMealProvider);
    final selectedSleepDuration = ref.read(sleepDurationProvider);
    final selectedFoodStressLevel = ref.read(foodStressLevelProvider);
    final selectedAlcoholConsumption = ref.read(alcoholConsumptionProvider);
    final selectedMealEnvironment = ref.read(mealEnvironmentProvider);
    final selectedMealPreferences = ref.read(mealPreferencesProvider);

    // 요청 본문 (사용자가 선택한 정보들)
    final data = {
      'question': '식단을 추천해 주세요',
      'context': '''
    운동 목표: $selectedDietGoal
    식사 빈도: $selectedMealFrequency    
    활동 수준: $selectedActivityLevel    
    음식 선호: ${selectedFoodPreferences.join(', ')}    
    알레르기: $selectedAllergy    
    채식 여부: $selectedVegetarian    
    다이어트 계획: $selectedDietPlan    
    칼로리 목표: $selectedCalorieGoal    
    식사 준비 시간: $selectedMealPrepTime    
    외식 여부: $selectedDiningOut    
    간식 빈도: $selectedSnackFrequency    
    현재 체중: $currentWeight    
    목표 체중: $goalWeight    
    혈당 조절 필요: $selectedBloodSugarControl    
    운동 빈도: $selectedExerciseFrequency    
    운동 종류: $selectedExerciseType    
    운동 후 식사: $selectedPostExerciseMeal    
    수면 시간: $selectedSleepDuration    
    음식 스트레스 수준: $selectedFoodStressLevel    
    음주 여부: $selectedAlcoholConsumption    
    식사 환경: $selectedMealEnvironment    
    식사 선호: $selectedMealPreferences
  '''
    };

    // 데이터가 제대로 설정되었는지 출력
    print('보내는 데이터: ${json.encode(data)}');
    // 서버 URL (로컬 API 서버)
    final url = Uri.parse('http://localhost:8000/chat-diet'); // 실제 API URL로 변경

    try {
      // POST 요청
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      // 서버 응답 처리
      if (response.statusCode == 200) {
        // 응답 데이터가 UTF-8로 인코딩되어 있다고 가정하고 디코딩
        final responseData = json.decode(utf8.decode(response.bodyBytes));

        // 'answers'가 배열로 오고 그 안에 여러 답변이 있을 때 처리
        List<String> aiAnswers = List<String>.from(responseData['answer']);

        ref.read(loadingStateProvider.notifier).stopLoading();

        // 응답 페이지로 이동 (aiAnswers를 리스트로 전달)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AiDietAnswer(aiAnswers: aiAnswers), // 여러 답변을 전달
          ),
        );
      } else {
        throw Exception('Failed to submit data');
      }
    } catch (error) {
      ref.read(loadingStateProvider.notifier).stopLoading();
      // 오류 처리
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("오류 발생"),
            content: Text(error.toString()),
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
    }
  }

  // '제출하기' 버튼 클릭 시 다이얼로그로 확인 요청
  void _onSubmit() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("제출 확인"),
          content: const Text("입력한 정보를 제출하시겠습니까?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: const Text("취소"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
                _submitData(); // 데이터 제출
              },
              child: const Text("확인"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loadingStateProvider); // 로딩 상태 구독

    return Scaffold(
      appBar: AppBar(
        title: const Text("식단 제출"),
        backgroundColor: const Color.fromARGB(255, 255, 111, 97),
      ),
      body: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                  ),
                  const SizedBox(height: 20), // 로딩 서클과 텍스트 사이에 간격 추가
                  const Text(
                    "AI가 식단관리를 위한 분석중입니다.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "제출할 정보를 확인한 후 제출 버튼을 눌러주세요.",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  // '제출하기' 버튼 (80% 너비 차지)
                  Center(
                    child: SizedBox(
                      width:
                          MediaQuery.of(context).size.width * 0.8, // 화면 너비의 80%
                      child: ElevatedButton(
                        onPressed: _onSubmit, // 제출 버튼 클릭 시 데이터 전송
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 255, 111, 97),
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          '제출하기',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
