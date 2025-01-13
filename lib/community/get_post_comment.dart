import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<Map<String, dynamic>>> fetchComments(int postNumber) async {
  final url =
      Uri.parse('${dotenv.env['API_BASE_URL']}/posts/$postNumber/comments');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final commentsData = data['comments'] as List;

      // 댓글 데이터를 Map으로 변환하여 반환
      return commentsData.map((comment) {
        return {
          'userName': comment['user_name'],
          'content': comment['content'],
          'date': comment['created_at'], // 서버에서 날짜 형식 맞춰서 받을 것
          'userImg': comment['img_link'],
          'postCommentNumber': comment['post_comment_number'],
          'state': comment['state'],
          'showReplies': false, // 기본적으로 답글 숨기기
        };
      }).toList();
    } else {
      throw Exception('댓글을 가져오는 데 실패했습니다.');
    }
  } catch (e) {
    print('Error fetching comments: $e');
    throw Exception('댓글을 가져오는 데 실패했습니다: $e');
  }
}
