import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

// 댓글 모델 클래스 정의
class Comment {
  final int feedCommentNumber;
  final int feedNumber;
  final int userNumber;
  final String? referenceCommentNumber;
  final String content;
  final String createdAt;
  final String? deletedAt;
  final String state;
  final String userName;
  final String userImg;

  Comment({
    required this.feedCommentNumber,
    required this.feedNumber,
    required this.userNumber,
    this.referenceCommentNumber,
    required this.content,
    required this.createdAt,
    this.deletedAt,
    required this.state,
    required this.userName,
    required this.userImg,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      feedCommentNumber: json['feed_comment_number'],
      feedNumber: json['feed_number'],
      userNumber: json['user_number'],
      referenceCommentNumber: json['reference_comment_number'],
      content: json['content'],
      createdAt: json['created_at'],
      deletedAt: json['deleted_at'],
      state: json['state'],
      userName: json['user_name'],
      userImg: json['img_link'], // 기본 이미지 설정
    );
  }
}

// 댓글 목록을 가져오는 메서드
Future<List<Comment>> getComments(int feedNumber) async {
  final url = Uri.parse(
      'http://localhost:8080/feeds/$feedNumber/comments'); // feed_number에 해당하는 URL

  final response = await http.get(url);

  if (response.statusCode == 200) {
    try {
      final Map<String, dynamic> data = jsonDecode(response.body);
      print("서버 응답 데이터: $data"); // 서버 응답 데이터 출력

      final List<dynamic> commentsJson =
          data['comments']; // "comments"는 서버 응답에서 댓글 목록을 포함하는 키

      // 서버에서 받은 댓글 데이터를 List<Comment>로 변환
      return commentsJson.map((json) => Comment.fromJson(json)).toList();
    } catch (e) {
      throw Exception('JSON 파싱 오류: $e');
    }
  } else {
    print('댓글을 가져오는 데 실패했습니다. 상태 코드: ${response.statusCode}');
    throw Exception('댓글을 가져오는 데 실패했습니다. 상태 코드: ${response.statusCode}');
  }
}
