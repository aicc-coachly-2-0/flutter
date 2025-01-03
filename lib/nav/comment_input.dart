import 'package:flutter/material.dart';

class CommentInput extends StatelessWidget {
  final TextEditingController commentController;
  final VoidCallback onSend;

  const CommentInput({
    super.key,
    required this.commentController,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
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
          // 본인 프로필 사진
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/image.png'), // 본인 프로필 사진
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
            onPressed: onSend,
          ),
        ],
      ),
    );
  }
}
