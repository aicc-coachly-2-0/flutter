import 'package:flutter/material.dart';
import 'package:flutter_application_test/state_controller/loginProvider.dart';
import 'package:flutter_application_test/state_controller/question_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SubmitButton extends ConsumerWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionState = ref.watch(questionProvider);

    return ElevatedButton(
      onPressed: questionState.isAgree
          ? () async {
              await submitQuestion(ref, context); // context 전달
            }
          : null, // 동의하지 않으면 버튼 비활성화
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50), // 버튼 너비를 90%로 설정
        backgroundColor: Color.fromARGB(255, 255, 111, 97), // 버튼 색상 변경
        foregroundColor: Colors.white, // 텍스트 색상 변경
      ),
      child: Text('문의하기'),
    );
  }

  // 서버에 질문을 POST하는 함수
  Future<void> submitQuestion(WidgetRef ref, BuildContext context) async {
    final questionState = ref.read(questionProvider);
    final user = ref.read(authProvider);

    if (user != null && user.userNumber != null) {
      final userNumber = user.userNumber;
      final questionCategory = ['계정', '커뮤니티', '미션', 'AI', '결제/환불', '신고', '기타'];

      // 선택된 카테고리의 인덱스를 찾음
      final questionClassId =
          questionCategory.indexOf(questionState.category ?? '');

      // indexOf가 -1이면 유효한 카테고리를 찾지 못한 경우이므로 기본값 처리
      final validQuestionClassId =
          (questionClassId != -1) ? questionClassId + 1 : 1;

      // postQuestion 함수 호출하여 서버로 전송
      final response = await postQuestion(
        userNumber,
        validQuestionClassId, // 유효한 questionClassId 사용
        questionState.title,
        questionState.content,
      );

      if (response.success) {
        // 문의가 성공적으로 제출되었으면 SnackBar로 성공 메시지 표시
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('문의가 성공적으로 제출되었습니다.'),
            backgroundColor: Colors.green, // 성공 메시지 색상
          ),
        );
        // 상태 초기화
        ref.read(questionProvider.notifier).reset();
        // 이후 화면을 닫고 이전 화면으로 돌아가기
        Navigator.pop(context); // 뒤로 가기 (현재 화면 종료)
      } else {
        print('문의 제출 실패');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('문의 제출 실패, 다시 시도해 주세요.'),
            backgroundColor: Colors.red, // 실패 메시지 색상
          ),
        );
      }
    } else {
      print('사용자 정보가 없습니다.');
    }
  }
}

Future<Response> postQuestion(
  int userNumber,
  int questionClassId,
  String title,
  String content,
) async {
  // 서버 URL
  final url = Uri.parse('${dotenv.env['API_BASE_URL']}/qnas/questions');

  // 요청 데이터
  final requestData = {
    'user_number': userNumber,
    'question_classification_number': questionClassId,
    'title': title,
    'question_content': content,
  };
  print(requestData);
  print(url);

  try {
    // POST 요청 보내기
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(requestData),
    );

    // 응답 처리
    if (response.statusCode == 201) {
      // 성공적으로 요청이 처리된 경우
      return Response(success: true, message: '문의가 성공적으로 제출되었습니다.');
    } else {
      // 실패한 경우
      return Response(success: false, message: '문의 제출 실패');
    }
  } catch (e) {
    return Response(success: false, message: '서버와의 연결에 실패했습니다: $e');
  }
}

// 응답 처리용 모델 클래스
class Response {
  final bool success;
  final String message;

  Response({required this.success, required this.message});
}
