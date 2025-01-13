import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/state_controller/loginProvider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> sendComment(
    WidgetRef ref, TextEditingController controller, int feedNumber) async {
  final String content = controller.text.trim();
  if (content.isEmpty) return; // 댓글 내용이 비어 있으면 전송하지 않음

  final user = ref.read(authProvider);
  if (user == null) {
    // 로그인 정보가 없으면 처리
    print('사용자를 찾을 수 없습니다');
    return;
  }

  final userNumber = user.userNumber;

  final response = await http.post(
    Uri.parse('http://localhost:8080/feeds/comment'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'user_number': userNumber,
      'feed_number': feedNumber,
      'content': content,
    }),
  );

  if (response.statusCode == 201) {
    // 댓글이 성공적으로 전송된 후 처리
    print('댓글 전송 성공');
    controller.clear(); // 댓글 입력 필드 초기화

    // 댓글 전송 성공 후 Snackbar 표시
    print('댓글이 성공적으로 전송되었습니다!');
  } else {
    // 실패 시 에러 메시지
    print('댓글 전송 실패: ${response.statusCode}');
  }
}
