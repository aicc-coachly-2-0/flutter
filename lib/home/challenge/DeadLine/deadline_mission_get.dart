import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Mission>> fetchUpcomingMissions() async {
  final response =
      await http.get(Uri.parse('http://localhost:8080/missions/upcoming'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List<dynamic> missionsJson = data['data'];

    return missionsJson.map((mission) => Mission.fromJson(mission)).toList();
  } else {
    throw Exception('Failed to load missions');
  }
}

class Mission {
  final int roomNumber;
  final String title;
  final String startedAt;
  final String imgLink;
  final String participantCount;
  final String duration;

  Mission({
    required this.roomNumber,
    required this.title,
    required this.startedAt,
    required this.imgLink,
    required this.participantCount,
    required this.duration,
  });

  // JSON 데이터를 받아서 Mission 객체로 변환
  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      roomNumber: json['room_number'],
      title: json['title'],
      startedAt: json['started_at'],
      imgLink: json['img_link'],
      participantCount: json['participant_count'],
      duration: json['duration'],
    );
  }
}
