import 'package:flutter/material.dart';
import 'package:flutter_application_test/community/get_post_comment.dart';
import 'package:flutter_application_test/get_method/community_get.dart';
import 'package:flutter_application_test/nav/post_comment_report.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart'; // Post 클래스 임포트

class CommentsList extends StatefulWidget {
  final Post post;
  final Function(int) onToggleReplies;

  const CommentsList({
    super.key,
    required this.post,
    required this.onToggleReplies,
  });

  @override
  _CommentsListState createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  late Future<List<Map<String, dynamic>>> _commentsFuture;

  @override
  void initState() {
    super.initState();
    _commentsFuture = fetchComments(widget.post.postNumber); // 댓글 가져오기 함수 호출
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _commentsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('댓글을 가져오는 데 실패했습니다.'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('댓글이 없습니다.'));
        }

        final comments = snapshot.data!;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: comments.length,
          itemBuilder: (context, index) {
            final comment = comments[index];
            bool showReplies = comment['showReplies'] ?? false;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 댓글 내용
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: comment['userImg'] != null
                          ? NetworkImage(
                              '${dotenv.env['FTP_URL']}${comment['userImg']}')
                          : AssetImage('assets/image.png')
                              as ImageProvider, // 프로필 이미지
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(comment['userName']!,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        Text(_formatDate(comment['date']),
                            style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.more_horiz),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext context) {
                            return PostCommentReportButton(
                                comment: comment); // ReportButton 컴포넌트 호출
                          },
                        );
                        print('더보기 클릭');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(comment['content']!, style: const TextStyle(fontSize: 16)),

                // 대댓글 섹션 (showReplies가 true일 때만 보이게)
                if (showReplies)
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0), // 답글 들여쓰기
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage(
                                  'assets/image.png'), // 대댓글 작성자의 프로필 이미지
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('ReplyUser',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
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
                        const Text('대댓글 내용 예시입니다. 대댓글 내용이 여기에 표시됩니다.',
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),

                // 답글 보기/숨기기 버튼
                TextButton(
                  onPressed: () {
                    widget.onToggleReplies(index);
                  },
                  child: Text(
                    showReplies ? '답글 숨기기' : '답글 보기',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 111, 97)),
                  ),
                ),

                const SizedBox(height: 10),
              ],
            );
          },
        );
      },
    );
  }
}

// 날짜 형식을 yyyy-MM-dd로 변환하는 함수
String _formatDate(String date) {
  DateTime parsedDate = DateTime.parse(date); // 문자열을 DateTime으로 변환
  return DateFormat('yy-MM-dd HH:mm')
      .format(parsedDate); // yyyy-MM-dd HH:mm:ss 형식으로 반환
}
