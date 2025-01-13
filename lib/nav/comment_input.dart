import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/get_method/community_get.dart';
import 'package:flutter_application_test/state_controller/loginProvider.dart'; // authProvider 임포트
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpod 사용

class CommentInput extends ConsumerWidget {
  final TextEditingController commentController;
  final VoidCallback onSend;
  final String userId; // 유저의 ID를 받아옵니다
  final Post post;

  const CommentInput({
    super.key,
    required this.commentController,
    required this.onSend,
    required this.userId, // userId 추가
    required this.post, // post 추가
  });

  // 유저 프로필 이미지를 가져오는 URL 생성 함수
  String getProfileImageUrl(String userId) {
    final ftpBaseUrl = dotenv.env['FTP_URL'] ?? 'default_value';
    return '$ftpBaseUrl/coachly/profile/user_$userId.jpg'; // 유저 프로필 이미지 URL 생성
  }

  // 댓글을 서버로 전송하는 함수
  Future<void> _sendComment(WidgetRef ref) async {
    final user = ref.read(authProvider); // 로그인한 사용자 정보 가져오기
    final userNumber = user?.userNumber; // 로그인한 유저의 userNumber 가져오기
    final comment = commentController.text; // 입력한 댓글 내용

    if (userNumber == null || comment.isEmpty) {
      return; // 유효하지 않은 데이터일 경우 아무것도 하지 않음
    }

    final url = Uri.parse('http://localhost:8080/posts/comment');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'post_number': post.postNumber,
        'user_number': userNumber,
        'content': comment,
      }),
    );

    if (response.statusCode == 201) {
      print('댓글 전송 성공');
      // 댓글 전송 후 추가 작업을 할 수 있음 (예: 화면 갱신 등)
    } else {
      print('댓글 전송 실패: ${response.statusCode}');
      // 실패 시 처리할 로직 추가 (예: 오류 메시지 표시)
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userImg = post.userImgPath; // 게시글 작성자의 userNumber
    print(userImg);

    return Container(
      width: double.infinity, // 가로폭 꽉 차게
      decoration: BoxDecoration(
        color: Colors.white, // 바깥쪽과 내부 배경색을 동일하게 설정
        borderRadius: BorderRadius.zero, // 바깥부분 둥글기 없애고 각지게 설정
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2), // 그림자 위치
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          // 유저 프로필 사진
          CircleAvatar(
            radius: 20,
            backgroundImage:
                NetworkImage(getProfileImageUrl(userId)), // 동적으로 프로필 이미지 가져오기
          ),
          const SizedBox(width: 10),

          // 댓글 입력 필드
          Expanded(
            child: TextField(
              controller: commentController,
              decoration: InputDecoration(
                hintText: '댓글을 작성하세요...',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white, // 내부 배경색을 흰색으로 설정
              ),
            ),
          ),

          // 메시지 보내기 아이콘
          IconButton(
            icon: const Icon(Icons.send,
                color: Color.fromARGB(255, 255, 111, 97)),
            onPressed: () {
              _sendComment(ref); // 댓글을 보내는 함수 호출
              onSend(); // onSend 콜백 함수 호출
            },
          ),
        ],
      ),
    );
  }
}
