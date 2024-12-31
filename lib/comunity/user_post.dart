import 'package:flutter/material.dart';
import 'package:flutter_application_test/nav/post_report.dart';

class UserPost extends StatefulWidget {
  const UserPost({super.key});

  @override
  _UserPostState createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  bool isLiked = false; // 좋아요 상태
  bool showReplies = true; // 대댓글 숨기기/보이기 상태
  final TextEditingController _commentController =
      TextEditingController(); // 댓글 입력용 텍스트 컨트롤러

  // 더미 댓글 데이터
  List<Map<String, String>> comments = [
    {
      'userName': 'User1',
      'date': '2024-12-30',
      'content': '이 게시글 너무 좋아요!',
      'replies': '안녕하세요!',
    },
    {
      'userName': 'User2',
      'date': '2024-12-29',
      'content': '멋진 글입니다!',
      'replies': '답글 달기 예시입니다.',
    },
  ];

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
              const Divider(thickness: 2, height: 30),

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

                  const SizedBox(width: 20),

                  IconButton(
                    icon: const Icon(Icons.comment),
                    onPressed: () {
                      print('댓글 클릭');
                    },
                  ),
                  Text('5'), // 댓글 개수
                ],
              ),
              const Divider(thickness: 2, height: 30),

              // 댓글 리스트
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 댓글 내용
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(
                              'assets/image.png', // 댓글 작성자의 프로필 이미지
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(comment['userName']!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Text(comment['date']!,
                                  style: const TextStyle(color: Colors.grey)),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.more_horiz),
                            onPressed: () {
                              print('더보기 클릭');
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(comment['content']!,
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 10),

                      // 대댓글 섹션
                      if (showReplies)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage(
                                    'assets/image.png', // 대댓글 작성자의 프로필 이미지
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('ReplyUser',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('2024-12-30',
                                        style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(Icons.more_horiz),
                                  onPressed: () {
                                    print('대댓글 더보기 클릭');
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            const Text('대댓글 내용 예시입니다. 대댓글 내용이 여기에 표시됩니다.',
                                style: TextStyle(fontSize: 16)),
                            const SizedBox(height: 10),
                          ],
                        ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            showReplies = !showReplies; // 대댓글 숨기기/보이기
                          });
                        },
                        child: Text(showReplies ? '대댓글 숨기기' : '대댓글 보기'),
                      ),
                      const Divider(thickness: 2, height: 30),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        margin: const EdgeInsets.only(bottom: 10), // 바텀 마진을 10으로 설정
        child: Container(
          width: double.infinity, // 가로폭 꽉 차게
          decoration: BoxDecoration(
            color: Colors.white, // 바깥쪽과 내부 배경색을 동일하게 설정
            borderRadius: BorderRadius.zero, // 바깥부분 둥글기 없애고 각지게 설정
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
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
                  controller: _commentController,
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
                  if (_commentController.text.isNotEmpty) {
                    print('새 댓글: ${_commentController.text}');
                    // 댓글을 추가하는 로직을 여기에 추가
                    _commentController.clear(); // 댓글 작성 후 입력창 비우기
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
