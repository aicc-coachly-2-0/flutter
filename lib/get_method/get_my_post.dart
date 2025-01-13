// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// // 게시글을 가져오는 함수
// Future<List<Post>> fetchPosts(int userNumber) async {
//   final url =
//       '${dotenv.env['API_BASE_URL']}/posts/users/$userNumber'; // API URL 수정

//   try {
//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final postsData = data['posts'] as List;

//       // postsData를 Post 객체의 리스트로 변환
//       return postsData.map((postJson) => Post.fromJson(postJson)).toList();
//     } else {
//       throw Exception('Failed to load posts');
//     }
//   } catch (error) {
//     print('Error: $error');
//     throw Exception('Failed to load posts');
//   }
// }

// class Post {
//   final int postNumber;
//   final String title;
//   final String content;
//   final String createdAt;
//   final String updatedAt;
//   final String imgPath;

//   Post({
//     required this.postNumber,
//     required this.title,
//     required this.content,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.imgPath,
//   });

//   // JSON 데이터를 받아서 객체로 변환하는 팩토리 메소드
//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(
//       postNumber: json['post_number'],
//       title: json['title'],
//       content: json['content'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       imgPath: json['img_path'],
//     );
//   }
// }
