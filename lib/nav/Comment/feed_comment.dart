import 'package:flutter/material.dart';
import 'package:flutter_application_test/get_method/get_feed_comment.dart';
import 'package:flutter_application_test/nav/Comment/comment_send.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_test/get_method/user_feed_get.dart'; // Feed 모델

class FeedComment extends ConsumerStatefulWidget {
  final Feed feed;
  const FeedComment({super.key, required this.feed});

  @override
  _FeedCommentState createState() => _FeedCommentState();
}

class _FeedCommentState extends ConsumerState<FeedComment> {
  final TextEditingController _controller = TextEditingController();
  bool isKeyboardVisible = false;
  double currentChildSize = 0.4;
  final DraggableScrollableController _scrollController =
      DraggableScrollableController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).addListener(() {
        final isKeyboardVisibleNow = FocusScope.of(context).hasFocus;
        setState(() {
          isKeyboardVisible = isKeyboardVisibleNow;
          if (isKeyboardVisible) {
            currentChildSize = 0.9;
            _scrollController.animateTo(
              0.9,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          } else {
            currentChildSize = 0.4;
            _scrollController.animateTo(
              0.4,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DraggableScrollableSheet(
          controller: _scrollController,
          initialChildSize: currentChildSize,
          maxChildSize: 0.9,
          minChildSize: 0.4,
          builder: (BuildContext context, ScrollController scrollController) {
            return ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      Container(
                        height: 5,
                        width: 50,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      FutureBuilder<List<Comment>>(
                        future: getComments(widget.feed.feedNumber),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('댓글을 가져오는 데 실패했습니다.'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(child: Text('댓글이 없습니다.'));
                          } else {
                            final comments = snapshot.data!;
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: comments.length,
                              itemBuilder: (context, index) {
                                final comment = comments[index];
                                return Column(
                                  children: [
                                    ListTile(
                                      leading: comment.userImg != null
                                          ? ClipOval(
                                              child: Image.network(
                                                '${dotenv.env['FTP_URL']}${comment.userImg}',
                                                width: 40,
                                                height: 40,
                                                fit: BoxFit
                                                    .cover, // 원형에 맞게 이미지 잘리도록 처리
                                              ),
                                            )
                                          : Icon(Icons.person,
                                              size: 40), // 기본 이미지
                                      title: Text(comment.userName),
                                      subtitle: Text(comment.content),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.favorite_border,
                                              color: Colors.grey,
                                            ),
                                            onPressed: () {
                                              // 하트 클릭 이벤트 처리
                                            },
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              print('답글 달기 클릭');
                                            },
                                            child: Text('답글 달기',
                                                style: TextStyle(
                                                    color: Colors.blue)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        Positioned(
          bottom:
              isKeyboardVisible ? MediaQuery.of(context).viewInsets.bottom : 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    currentChildSize = 0.9;
                    _scrollController.animateTo(0.9,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  });
                },
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: '댓글을 입력하세요...',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        sendComment(
                            ref, _controller, widget.feed.feedNumber); // 댓글 전송
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
