import 'package:flutter/material.dart';
import 'package:flutter_application_test/community/community_comments_list.dart';
import 'package:flutter_application_test/community/get_post_comment.dart';
import 'package:flutter_application_test/nav/comment_input.dart';
import 'package:flutter_application_test/nav/post_report.dart';
import 'package:flutter_application_test/get_method/community_get.dart'; // Post 클래스 임포트
import 'package:flutter_application_test/state_controller/loginProvider.dart'; // authProvider 임포트
import 'package:flutter_riverpod/flutter_riverpod.dart'; // ref.read를 위해 추가
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 임포트
import 'user_post_header.dart'; // 사용자 정보 및 게시글 제목 컴포넌트
import 'post_image.dart'; // 게시글 이미지 컴포넌트
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserPost extends ConsumerStatefulWidget {
  final Post post;

  const UserPost({super.key, required this.post});

  @override
  _UserPostState createState() => _UserPostState();
}

class _UserPostState extends ConsumerState<UserPost> {
  bool isLiked = false;
  final TextEditingController _commentController = TextEditingController();

  late Future<List<Map<String, dynamic>>> _commentsFuture;

  @override
  void initState() {
    super.initState();
    _commentsFuture = fetchComments(widget.post.postNumber); // 댓글 데이터 가져오기
  }

  // 댓글을 서버로 보내는 함수
  Future<void> sendComment() async {
    final user = ref.read(authProvider);
    if (_commentController.text.isNotEmpty && user != null) {
      final url = Uri.parse(
          '${dotenv.env['API_BASE_URL']}/posts/${widget.post.postNumber}/comments');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'post_number': widget.post.postNumber,
          'user_number': user.userNumber, // 유저 번호
          'content': _commentController.text, // 댓글 내용
        }),
      );

      if (response.statusCode == 201) {
        print('댓글이 성공적으로 추가되었습니다!');
        _commentController.clear(); // 댓글 작성 후 입력창 비우기
        setState(() {
          _commentsFuture = fetchComments(widget.post.postNumber); // 댓글 새로고침
        });
      } else {
        print('댓글 전송 실패: ${response.body}');
      }
    } else {
      print('댓글 내용이 비어있거나 사용자 정보가 없습니다.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final user = ref.read(authProvider);

    // user 정보가 없거나, userId가 없으면 처리
    if (user == null || user.userNumber == null) {
      return const Center(child: Text('사용자 정보가 없습니다.'));
    }

    final userId = user.userId; // 사용자 아이디

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('게시글 상세', style: TextStyle(color: Colors.black)),
        actions: [
          // 오른쪽 점점점 아이콘
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {
              print('점점점 아이콘 클릭');
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) {
                  return PostReportButton(); // ReportButton 컴포넌트 호출
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 사용자 정보 및 게시글 제목 표시 부분
              UserPostHeader(post: post, user: user),

              const SizedBox(height: 20),

              // 게시글 내용
              Text(post.content, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),

              // 게시글 이미지 표시 부분
              PostImage(post: post),

              const SizedBox(height: 20),

              // 좋아요, 댓글 섹션
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                  ),
                  Text('12'), // 좋아요 개수

                  IconButton(
                    icon: const Icon(Icons.comment),
                    onPressed: () {
                      print('댓글 클릭');
                    },
                  ),
                  Text('5'), // 댓글 개수
                ],
              ),
              const Divider(thickness: 1, height: 10),

              // 댓글 리스트를 여기서 불러옴
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _commentsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('댓글을 가져오는 데 실패했습니다.'));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('댓글이 없습니다.'));
                  }

                  final comments = snapshot.data!;

                  return CommentsList(
                    onToggleReplies: (index) {
                      setState(() {
                        comments[index]['showReplies'] =
                            !(comments[index]['showReplies'] ?? false);
                      });
                    },
                    post: post,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.only(bottom: 20.0),
        color: const Color.fromARGB(255, 255, 255, 255),
        child: CommentInput(
            commentController: _commentController,
            onSend: sendComment, // 댓글 전송 함수 전달
            userId: userId, // userId 전달
            post: post),
      ),
    );
  }
}
