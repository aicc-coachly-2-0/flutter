import 'package:flutter/material.dart';
import 'package:flutter_application_test/get_method/community_get.dart'; // 커뮤니티 get 메서드 임포트
import 'package:flutter_application_test/community/UserPost/user_post.dart';
import 'package:intl/intl.dart'; // UserPost 임포트

class WorkoutCompleteSection extends StatefulWidget {
  const WorkoutCompleteSection({super.key});

  @override
  _WorkoutCompleteSectionState createState() => _WorkoutCompleteSectionState();
}

class _WorkoutCompleteSectionState extends State<WorkoutCompleteSection> {
  List<Post> posts = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  // 게시글을 가져오는 메서드
  Future<void> _fetchPosts() async {
    try {
      List<Post> fetchedPosts = await ApiService().getPosts(3);
      setState(() {
        posts = fetchedPosts;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = '게시글을 가져오는 데 실패했습니다: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator()); // 로딩 중이면 스피너 표시
    }

    if (errorMessage.isNotEmpty) {
      return Center(child: Text(errorMessage)); // 오류 메시지 표시
    }

    return Column(
      children: posts.map((post) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(post.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${post.content.substring(0, post.content.length < 50 ? post.content.length : 50)}...', // 길이에 맞게 수정
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 5),
                            Text(_formatDate(post.createdAt),
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                onTap: () {
                  // 게시글을 클릭했을 때 UserPost 화면으로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UserPost(post: post), // UserPost로 데이터 전달
                    ),
                  );
                },
              ),
            ),
            const Divider(thickness: 1.5),
          ],
        );
      }).toList(),
    );
  }
}

// 날짜 형식을 yyyy-MM-dd로 변환하는 함수
String _formatDate(String date) {
  DateTime parsedDate = DateTime.parse(date); // 문자열을 DateTime으로 변환
  return DateFormat('yyyy-MM-dd').format(parsedDate); // yyyy-MM-dd 형식으로 반환
}