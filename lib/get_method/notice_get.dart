import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class Notice {
  final int noticeNumber;
  final String title;
  final String content;
  final String createdAt;

  Notice({
    required this.noticeNumber,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  // JSON 파싱을 위한 factory
  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      noticeNumber: json['notice_number'],
      title: json['title'],
      content: json['content'],
      createdAt: json['created_at'], // 날짜는 그대로 string으로 저장
    );
  }
}

Future<List<Notice>> getNotices() async {
  final url = Uri.parse('${dotenv.env['API_BASE_URL']}/notice/notices');

  try {
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      // 'state'가 'active'인 공지사항만 필터링
      final activeNotices = data
          .where((notice) => notice['state'] == 'active')
          .map((notice) => Notice.fromJson(notice))
          .toList();

      // 최신 순으로 정렬 (created_at 기준)
      activeNotices.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return activeNotices;
    } else {
      throw Exception('공지사항을 가져오는 데 실패했습니다.');
    }
  } catch (e) {
    print('Error fetching notices: $e');
    throw Exception('공지사항을 가져오는 데 실패했습니다.');
  }
}
