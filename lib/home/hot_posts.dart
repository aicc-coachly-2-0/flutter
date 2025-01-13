import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HotPosts extends StatefulWidget {
  const HotPosts({super.key});

  @override
  _HotPostsState createState() => _HotPostsState();
}

class _HotPostsState extends State<HotPosts> {
  List<Post> _posts = [];

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  // 데이터 API 호출
  Future<void> _fetchPosts() async {
    final url = Uri.parse('http://localhost:8080/posts/communitiy');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        List<Post> posts = (data['posts'] as List)
            .map((postData) => Post.fromJson(postData))
            .toList();

        // 커뮤니티 번호에 따라 필터링하여 가장 최신 순으로 정렬
        posts.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        // 커뮤니티 번호 1~7에 맞는 최신 게시글만 추출
        final communityOrder = [
          1,
          2,
          3,
          4,
          5,
          6,
          7
        ]; // 자유, 익명, 오운완, 러닝, 헬린이, 식단, 첼린지
        List<Post> filteredPosts = [];

        for (int communityNumber in communityOrder) {
          final post = posts.firstWhere(
            (p) => p.communityNumber == communityNumber,
            orElse: () => Post(
              postNumber: 0,
              userNumber: 0,
              communityNumber: 0,
              title: 'No Post',
              content: 'No Content',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              state: 'inactive',
              imgPath: '',
            ), // 기본값 반환
          );
          filteredPosts.add(post);
        }

        setState(() {
          _posts = filteredPosts;
        });
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      print(e);
      // 오류 처리 추가
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 텍스트 왼쪽 정렬
      children: [
        const Text(
          '이번주 가장 인기가 많은 게시글은?',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 155, 155, 155),
          ),
        ),
        const SizedBox(height: 8), // 텍스트 사이 간격

        const Text(
          'HOT 인기글',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20), // 텍스트와 컨테이너 사이 간격

        _posts.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 243, 235), // 배경 색상
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orangeAccent),
                ),
                height: 300, // 높이를 추가하여 크기 키우기
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _posts.map((post) => _buildHotPost(post)).toList(),
                ),
              ),
      ],
    );
  }

  Widget _buildHotPost(Post post) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0), // 위아래 간격 띄우기
      child: Align(
        alignment: Alignment.centerLeft, // 제목이 왼쪽에 맞춰지도록
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Row 내에서 위쪽 정렬
          children: [
            Text(
              _getCommunityName(post.communityNumber),
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 111, 97),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            const SizedBox(width: 5),
            Expanded(
              // 제목 텍스트가 남은 공간을 차지하게 함
              child: Text(
                post.title,
                style: const TextStyle(color: Colors.black, fontSize: 18),
                overflow: TextOverflow.ellipsis, // 제목이 길어지면 생략
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 커뮤니티 번호에 따른 이름 반환
  String _getCommunityName(int communityNumber) {
    switch (communityNumber) {
      case 1:
        return '[자유]';
      case 2:
        return '[익명]';
      case 3:
        return '[오운완]';
      case 4:
        return '[러닝]';
      case 5:
        return '[헬린이]';
      case 6:
        return '[식단]';
      case 7:
        return '[첼린지]';
      default:
        return '';
    }
  }
}

class Post {
  final int postNumber;
  final int userNumber;
  final int communityNumber;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String state;
  final String imgPath;

  Post({
    required this.postNumber,
    required this.userNumber,
    required this.communityNumber,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.state,
    required this.imgPath,
  });

  // JSON에서 Post 객체로 변환
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postNumber: json['post_number'],
      userNumber: json['user_number'],
      communityNumber: json['community_number'],
      title: json['title'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      state: json['state'],
      imgPath: json['img_path'],
    );
  }
}
