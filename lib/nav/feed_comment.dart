import 'package:flutter/material.dart';

class FeedComment extends StatefulWidget {
  const FeedComment({super.key});

  @override
  _FeedCommentState createState() => _FeedCommentState();
}

class _FeedCommentState extends State<FeedComment> {
  final TextEditingController _controller = TextEditingController();
  final List<bool> _heartStates = [false, false]; // 각 댓글마다 하트 상태를 관리
  bool isKeyboardVisible = false; // 키보드 상태 추적
  double currentChildSize = 0.4; // 기본 크기 (40%)
  final DraggableScrollableController _scrollController =
      DraggableScrollableController();

  @override
  void dispose() {
    _controller.dispose(); // 텍스트 필드의 컨트롤러 해제
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // 키보드 상태 변화 감지
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).addListener(() {
        final isKeyboardVisibleNow = FocusScope.of(context).hasFocus;
        setState(() {
          isKeyboardVisible = isKeyboardVisibleNow;
          if (isKeyboardVisible) {
            // 키보드가 올라올 때 시트를 최대 크기로 설정
            currentChildSize = 0.9;
            _scrollController.animateTo(
              0.9,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          } else {
            // 키보드가 내려갔을 때 시트를 기본 크기로 설정
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

  void _toggleHeart(int index) {
    setState(() {
      // 하트 클릭 시 상태 변경 (빈 하트 -> 채워진 하트)
      _heartStates[index] = !_heartStates[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // DraggableScrollableSheet
        DraggableScrollableSheet(
          controller: _scrollController,
          initialChildSize: currentChildSize, // 기본 크기
          maxChildSize: 0.9, // 최대 크기
          minChildSize: 0.4, // 최소 크기
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
                      // 드래그 가능한 선
                      Container(
                        height: 5,
                        width: 50,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      // 댓글 리스트
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: ListView.builder(
                          itemCount: _heartStates.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ListTile(
                                  leading: Icon(Icons.person),
                                  title: Text('사용자${index + 1}'),
                                  subtitle: Text('좋은 피드입니다!'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // 하트 아이콘
                                      IconButton(
                                        icon: Icon(
                                          _heartStates[index]
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: _heartStates[index]
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                        onPressed: () => _toggleHeart(index),
                                      ),
                                      // 답글 달기 버튼
                                      TextButton(
                                        onPressed: () {
                                          // 답글 달기 동작
                                          print('답글 달기 클릭');
                                        },
                                        child: Text(
                                          '답글 달기',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                  height: 1,
                                  thickness: 1,
                                  indent: 0,
                                  endIndent: 0,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),

        // 텍스트 입력란을 하단에 고정
        Positioned(
          bottom: isKeyboardVisible
              ? MediaQuery.of(context).viewInsets.bottom
              : 0, // 키보드 높이에 맞게 위치
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  // 댓글 입력란을 클릭하면 시트 크기를 최대 크기로 확장
                  setState(() {
                    currentChildSize = 0.9; // 최대 크기 설정
                    // 최대 크기로 변환을 트리거
                    _scrollController.animateTo(0.9,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  });
                },
                child: TextField(
                  controller: _controller,
                  maxLines: 1,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: '댓글을 입력하세요...',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
