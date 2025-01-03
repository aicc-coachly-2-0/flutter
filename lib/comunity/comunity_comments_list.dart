import 'package:flutter/material.dart';

class CommentsList extends StatefulWidget {
  final List<Map<String, dynamic>> comments;
  final Function(int) onToggleReplies;

  const CommentsList(
      {super.key, required this.comments, required this.onToggleReplies});

  @override
  _CommentsListState createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.comments.length,
      itemBuilder: (context, index) {
        final comment = widget.comments[index];
        bool showReplies = comment['showReplies'] ?? false;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 댓글 내용
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/image.png'),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(comment['userName']!,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
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
                                style: TextStyle(fontWeight: FontWeight.bold)),
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
                style:
                    const TextStyle(color: Color.fromARGB(255, 255, 111, 97)),
              ),
            ),

            const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}
