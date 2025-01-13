// feed_service.dart
import 'dart:convert';
import 'package:flutter_application_test/state_controller/loginProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FeedService {
  // 서버에서 피드 데이터를 가져오는 함수
  Future<List<Feed>> fetchFeeds(WidgetRef ref, int userNumber) async {
    final url =
        Uri.parse('${dotenv.env['API_BASE_URL']}/feeds/users/$userNumber');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['feeds'] == null) {
        throw Exception('피드 데이터가 없습니다.');
      }

      final List<dynamic> feedData = data['feeds'];

      if (feedData.isEmpty) {
        throw Exception('피드 데이터가 비어 있습니다.');
      }

      return feedData.map((item) => Feed.fromJson(item)).toList();
    } else {
      throw Exception('피드를 가져오는 데 실패했습니다');
    }
  }
}

// feed.dart
class Feed {
  final int feedNumber;
  final int userNumber;
  final String imgNumber;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  Feed({
    required this.feedNumber,
    required this.userNumber,
    required this.imgNumber,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  // JSON 데이터를 모델 객체로 변환
  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
      feedNumber: json['feed_number'],
      userNumber: json['user_number'],
      imgNumber: json['img_number'], // 서버에서 전달된 이미지 경로
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
