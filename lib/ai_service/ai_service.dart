import 'package:flutter/material.dart';
import 'package:flutter_application_test/ai_questions_food/agree.dart';
import 'package:flutter_application_test/ai_questions_pt/agree.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_test/ai_service/ai_page.dart';
import 'package:flutter_application_test/state_controller/loginProvider.dart';

class AiServiceChoice extends ConsumerStatefulWidget {
  const AiServiceChoice({super.key});

  @override
  _AiServiceChoiceState createState() => _AiServiceChoiceState();
}

class _AiServiceChoiceState extends ConsumerState<AiServiceChoice> {
  bool isLoading = true; // 데이터 로딩 상태
  bool hasBillingKey = false; // 빌링키 여부

  @override
  void initState() {
    super.initState();
    fetchSubscriptionData(); // 구독 정보 조회
  }

  Future<void> fetchSubscriptionData() async {
    final user = ref.read(authProvider); // 로그인된 사용자 정보 가져오기

    if (user == null) {
      print('로그인 정보가 없습니다.');
      return;
    }

    final String url =
        'http://localhost:8000/api/subscription/${user.userNumber}';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print('Received subscriptions data: $data');

        if (data['billing_key'] != null && data['billing_key'].isNotEmpty) {
          setState(() {
            hasBillingKey = true;
          });
        } else {
          setState(() {
            hasBillingKey = false;
          });
        }
      } else {
        throw Exception('구독 정보 조회 실패');
      }
    } catch (error) {
      print('구독 정보 조회 중 오류 발생: $error');
    } finally {
      setState(() {
        isLoading = false; // 데이터 로딩 완료
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 로딩 상태
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("AI 서비스 선택"),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // 빌링키 여부에 따라 다른 화면 표시
    if (!hasBillingKey) {
      return const AIPage(); // 빌링키가 없으면 AIPage로 이동
    }
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 버튼들이 세로로 가운데 정렬
          crossAxisAlignment: CrossAxisAlignment.center, // 버튼들이 가로로 가운데 정렬
          children: [
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
