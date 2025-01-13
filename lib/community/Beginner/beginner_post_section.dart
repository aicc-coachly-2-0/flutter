import 'package:flutter/material.dart';
import 'package:flutter_application_test/get_method/community_get.dart'; // 커뮤니티 get 메서드 임포트
import 'package:flutter_application_test/community/UserPost/user_post.dart'; // UserPost 임포트

class PostListSection extends StatefulWidget {
  const PostListSection({super.key});

  @override
  _PostListSectionState createState() => _PostListSectionState();
}

class _PostListSectionState extends State<PostListSection> {
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
      List<Post> fetchedPosts = await ApiService().getPosts(5); // 커뮤니티 번호 5로 예시
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
                            Text(post.userName
                                .toString()), // author 정보는 없으니 userNumber로 대체
                            const SizedBox(width: 5),
                            Text(post.createdAt,
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
