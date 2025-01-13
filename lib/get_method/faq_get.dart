import 'dart:convert';
import 'package:flutter_application_test/state_controller/loginProvider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FaqService {
  // FAQ 데이터 가져오기 (유저 정보 포함)
  Future<List<Faq>> fetchFaqs(WidgetRef ref) async {
    final user = ref.read(authProvider); // 로그인된 유저 정보 가져오기

    // 유저가 로그인되어 있지 않으면 예외 처리
    if (user == null) {
      throw Exception('로그인 정보가 없습니다.');
    }

    final response = await http.get(
      Uri.parse('${dotenv.env['API_BASE_URL']}/faqs'),
      headers: {
        'Authorization':
            'Bearer ${user.token}', // Authorization 헤더에 토큰 추가 (필요한 경우)
        'User-Id': user.userId, // 또는 쿼리 파라미터로 userId를 보낼 수 있음
      },
    );

    if (response.statusCode == 200) {
      // JSON 데이터를 파싱하여 FAQ 객체 리스트로 변환
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Faq.fromJson(item)).toList();
    } else {
      throw Exception('FAQ 데이터를 불러오는 데 실패했습니다.');
    }
  }
}

class Faq {
  final String content;
  final String answer;

  Faq({required this.content, required this.answer});

  // JSON 데이터를 Faq 객체로 변환하는 팩토리 메서드
  factory Faq.fromJson(Map<String, dynamic> json) {
    return Faq(
      content: json['content'] ?? '질문 없음',
      answer: json['answer'] ?? '답변 없음',
    );
  }
}
