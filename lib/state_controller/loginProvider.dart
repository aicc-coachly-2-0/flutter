import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 로그인 정보 모델
class User {
  final String userId;
  final String userEmail;
  final String token;

  User({required this.userId, required this.userEmail, required this.token});
}

// 로그인 상태를 관리하는 프로바이더
final authProvider = StateProvider<User?>((ref) => null);

// 로그인 처리 함수
Future<void> loginUser(WidgetRef ref, String id, String password) async {
  try {
    // 아이디와 비밀번호를 하나의 Map으로 묶어서 보내기

    // 서버로 로그인 요청 (API 호출)
    final loginData = {
      'user_id': id,
      'user_pw': password,
    };
    print('로그인 요청 데이터: $loginData'); // 데이터 확인

    final response = await http.post(
      Uri.parse('${dotenv.env['API_BASE_URL']}/auth/user-signin'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(loginData), // JSON 형식으로 인코딩하여 전송
    );

    print('응답 상태 코드: ${response.statusCode}');
    print('응답 본문: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final user = responseData['user'];
      final token = responseData['token'];

      // 로그인 성공 후 프로바이더에 로그인 정보 저장
      ref.read(authProvider.notifier).state = User(
        userId: user['user_id'],
        userEmail: user['user_email'],
        token: token,
      );

      // 추가적으로 로그인 성공 후 처리할 동작
      print('로그인 성공: ${user['user_email']}');
    } else {
      throw Exception('로그인 실패');
    }
  } catch (error) {
    print('로그인 중 오류 발생: $error');
    // 예외 처리 (UI 표시, 에러 메시지 등)
  }
}
