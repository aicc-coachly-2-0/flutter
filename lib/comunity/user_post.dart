import 'package:flutter/material.dart';
import 'package:flutter_application_test/comunity/comunity_comments_list.dart';
import 'package:flutter_application_test/nav/comment_input.dart';
import 'package:flutter_application_test/nav/post_report.dart';

class UserPost extends StatefulWidget {
  const UserPost({super.key});

  @override
  _UserPostState createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  bool isLiked = false; // 좋아요 상태
  final TextEditingController _commentController =
      TextEditingController(); // 댓글 입력용 텍스트 컨트롤러

  // 더미 댓글 데이터
  List<Map<String, dynamic>> comments = [
    {
      'userName': 'User1',
      'date': '2024-12-30',
      'content': '이 게시글 너무 좋아요!',
      'replies': '안녕하세요!',
      'showReplies': false, // 각 댓글마다 showReplies 상태 관리
    },
    {
      'userName': 'User2',
      'date': '2024-12-29',
      'content': '멋진 글입니다!',
      'replies': '답글 달기 예시입니다.',
      'showReplies': false, // 각 댓글마다 showReplies 상태 관리
    },
  ];

  // 답글 보기/숨기기 토글
  void toggleReplies(int index) {
    setState(() {
      comments[index]['showReplies'] =
          !(comments[index]['showReplies'] ?? false);
    });
  }

  // 댓글 전송 처리
  void sendComment() {
    if (_commentController.text.isNotEmpty) {
      print('새 댓글: ${_commentController.text}');
      // 댓글을 추가하는 로직을 여기에 추가
      _commentController.clear(); // 댓글 작성 후 입력창 비우기
    }
  }

  @override
  Widget build(BuildContext context) {
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
                isScrollControlled: true, // 스크롤 가능하도록 설정
                backgroundColor: Colors.transparent, // 모달 배경을 투명하게 처리
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
              // 프로필 사진, 이름, 올린 날짜
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(
                      'assets/image.png', // 프로필 이미지
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('UserName',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('2024-12-30', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 게시글 제목
              const Text('게시글 제목',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),

              // 게시글 내용
              const Text(
                '이것은 게시글 내용입니다. 이 글은 상세 페이지에서 보여지는 게시글 내용입니다. 긴 내용을 작성할 수 있습니다.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              // 게시글 이미지
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/image.png', // 게시글 이미지 URL
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              // const Divider(thickness: 1, height: 20),

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
              CommentsList(
                comments: comments,
                onToggleReplies: toggleReplies, // 답글 보이기/숨기기 상태 토글 함수 전달
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        padding:
            const EdgeInsets.only(bottom: 20.0), // 바텀 마진을 20으로 설정하여 아래에서 띄움
        color: Color.fromARGB(255, 255, 255, 255),
        child: CommentInput(
          commentController: _commentController,
          onSend: sendComment, // 댓글 전송 함수 전달
        ),
      ),
    );
  }
}
