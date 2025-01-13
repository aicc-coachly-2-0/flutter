import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // 게시글 가져오기
  Future<List<Post>> getPosts(int communityNumber) async {
    final url = Uri.parse(
        '${dotenv.env['API_BASE_URL']}/posts/communities/$communityNumber');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // 서버에서 성공적으로 데이터를 받았다면
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['posts'] == null) {
          throw Exception('게시글 데이터가 없습니다.');
        }

        final List<dynamic> postsData = data['posts'];

        if (postsData.isEmpty) {
          throw Exception('게시글 데이터가 비어 있습니다.');
        }

        return postsData.map((post) => Post.fromJson(post)).toList();
      } else {
        throw Exception('게시글을 가져오는 데 실패했습니다: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching posts: $e');
      throw Exception('게시글을 가져오는 데 실패했습니다: $e');
    }
  }
}

Future<List<Post>> fetchPosts(int userNumber) async {
  final url =
      '${dotenv.env['API_BASE_URL']}/posts/users/$userNumber'; // API URL 수정

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final postsData = data['posts'] as List;

      // postsData를 Post 객체의 리스트로 변환
      return postsData.map((postJson) => Post.fromJson(postJson)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  } catch (error) {
    print('Error: $error');
    throw Exception('Failed to load posts');
  }
}

class Post {
  final int postNumber;
  final int userNumber;
  final int communityNumber;
  final String title;
  final String content;
  final String createdAt;
  final String updatedAt;
  final String state;
  final String imgPath;
  final String userImgPath;
  final String userName; // 추가된 user_name 필드

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
    required this.userImgPath,
    required this.userName, // 생성자에서 userName 추가
  });

  // JSON 데이터를 모델 객체로 변환
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postNumber: json['post_number'],
      userNumber: json['user_number'],
      communityNumber: json['community_number'],
      title: json['title'],
      content: json['content'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      state: json['state'],
      imgPath: json['img_path'],
      // userImgPath가 null일 수 있으므로, null 체크 후 기본값 설정
      userImgPath: json['user_img_link'] ?? '', // null일 경우 빈 문자열로 처리
      // userName을 받아오는 부분 추가
      userName: json['user_name'] ?? '', // null일 경우 빈 문자열로 처리
    );
  }
}
