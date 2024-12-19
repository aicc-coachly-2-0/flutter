import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/state_controller/ai_food_questions_notifier.dart';
import 'package:flutter_application_test/state_controller/ai_question_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_test/home/home.dart'; // 홈 페이지 임포트
import 'package:flutter_application_test/ai_service/ai_pt_answer.dart'; // AI 응답 페이지 임포트

class ExerciseAbilityPage extends ConsumerStatefulWidget {
  const ExerciseAbilityPage({super.key});

  @override
  _ExerciseAbilityPageState createState() => _ExerciseAbilityPageState();
}

class _ExerciseAbilityPageState extends ConsumerState<ExerciseAbilityPage> {
  // "제출하기" 버튼 클릭 시 서버로 데이터를 보내는 함수
  Future<void> _submitData() async {
    ref.read(loadingStateProvider.notifier).startLoading();

    // 상태들 가져오기
    final selectedLevel = ref.read(exerciseLevelProvider);
    final selectedPlace = ref.read(exercisePlaceProvider);
    final selectedGoal = ref.read(exerciseGoalProvider);
    final selectedFrequency = ref.read(exerciseFrequencyProvider);
    final selectedFocus = ref.read(focusOnExerciseProvider);
    final age = ref.read(ageProvider);
    final gender = ref.read(genderProvider);
    final height = ref.read(heightProvider);
    final weight = ref.read(weightProvider);
    final injuryStatus = ref.read(injuryStatusProvider);

    // 부상 부위 목록 만들기
    List<String> injuryParts = [];
    injuryStatus.forEach((part, isInjured) {
      if (isInjured) {
        injuryParts.add(part);
      }
    });

    // 요청 본문 (사용자가 선택한 정보들)
    final data = {
      'question': '운동 루틴을 만들어 주세요',
      'context': '''
        운동 수준: $selectedLevel
        운동 장소: $selectedPlace
        일주일 운동 가능 횟수: $selectedFrequency
        운동 목표: $selectedGoal
        부상 부위: ${injuryParts.join(', ')}
        나이: $age
        성별: $gender
        키: $height
        몸무게: $weight
        운동 초점: ${selectedFocus.join(', ')}
      '''
    };

    // 데이터가 제대로 설정되었는지 출력
    print('보내는 데이터: ${json.encode(data)}');
    // 서버 URL (로컬 API 서버)
    final url = Uri.parse('http://localhost:8000/chat-pt'); // 실제 API URL로 변경

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
        List<String> aiAnswers = List<String>.from(responseData['answer']);

        ref.read(loadingStateProvider.notifier).stopLoading();

        // 응답 페이지로 이동
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AiAnswerPage(aiAnswers: aiAnswers), // 응답을 페이지에 전달
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
        title: const Text("정보 제출"),
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
                    "AI가 운동루틴을 분석중입니다.",
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
