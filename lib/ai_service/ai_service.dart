import 'package:flutter/material.dart';
import 'package:flutter_application_test/ai_questions_food/agree.dart';
import 'package:flutter_application_test/ai_questions_pt/agree.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_test/ai_service/ai_page.dart';
import 'package:flutter_application_test/state_controller/loginProvider.dart';
import 'package:flutter_application_test/ai_service/excerise_section.dart';
import 'diet_section.dart'; // 식단 섹션

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
        '${dotenv.env['API_BASE_URL']}/subscription/${user.userNumber}';
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
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          // SingleChildScrollView로 감싸서 스크롤 가능하도록 설정
          child: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height, // 화면 크기와 같은 높이로 설정
              child: const CircularProgressIndicator(), // 로딩 인디케이터
            ),
          ),
        ),
      );
    }

    // 빌링키 여부에 따라 다른 화면 표시
    if (!hasBillingKey) {
      return const AIPage(); // 빌링키가 없으면 AIPage로 이동
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // 전체 화면을 스크롤 가능하게 감싸기
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
          children: [
            ExerciseSection(), // 운동 섹션
            const SizedBox(height: 20),
            DietSection(), // 식단 섹션
          ],
        ),
      ),
    );
  }
}
