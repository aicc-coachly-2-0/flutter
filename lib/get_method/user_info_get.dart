import 'package:flutter_application_test/state_controller/loginProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// 사용자 정보 모델
class UserInfo {
  final int userNumber;
  final String userId;
  final String userName;
  final String userEmail;
  final String userPhone;
  final String userDateOfBirth;
  final String userGender;
  final String createdAt;
  final String status;
  final String nickname;
  final String bio;
  final String profilePicture;
  final int totalPoints;

  UserInfo({
    required this.userNumber,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.userDateOfBirth,
    required this.userGender,
    required this.createdAt,
    required this.status,
    required this.nickname,
    required this.bio,
    required this.profilePicture,
    required this.totalPoints,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      userNumber: int.parse(json['user_number']),
      userId: json['user_id'],
      userName: json['user_name'],
      userEmail: json['user_email'],
      userPhone: json['user_phone'],
      userDateOfBirth: json['user_date_of_birth'],
      userGender: json['user_gender'],
      createdAt: json['created_at'],
      status: json['status'],
      nickname: json['nickname'],
      bio: json['bio'],
      profilePicture: json['profile_picture'],
      totalPoints: json['total_points'],
    );
  }
}

// 사용자 정보를 가져오는 함수
Future<UserInfo> fetchUserDetails(WidgetRef ref) async {
  // authProvider에서 사용자 정보 가져오기
  final user = ref.read(authProvider);

  // 사용자 정보가 없으면 에러 처리
  if (user == null) {
    throw Exception('사용자 인증이 필요합니다.');
  }

  final userNumber = user.userNumber; // authProvider에서 user_number 추출

  // 요청 URL에 사용자 번호를 넣어서 GET 요청을 보냄
  final response = await http.get(
    Uri.parse('http://localhost:8080/user/$userNumber'),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final userData = data['data']; // 'data' 부분을 추출

    return UserInfo.fromJson(userData); // User 객체로 변환하여 반환
  } else {
    final errorMessage =
        json.decode(response.body)['message'] ?? 'Failed to load user details';
    throw Exception(errorMessage); // 서버에서 보내주는 에러 메시지 활용
  }
}
