import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// 프로필 이미지 위젯
class ProfileImage extends StatelessWidget {
  final String userId;
  final int userNumber;
  final String userName;

  const ProfileImage(
      {super.key,
      required this.userId,
      required this.userNumber,
      required this.userName});

  // 유저의 프로필 이미지를 가져오는 URL 생성
  String getProfileImageUrl(String userId) {
    // FTP 서버 URL을 환경변수에서 가져오고 기본값을 설정
    final ftpBaseUrl =
        dotenv.env['FTP_URL'] ?? 'http://default.url'; // FTP URL을 기본값으로 설정

    // 유효성 검사: ftpBaseUrl이 유효한 URL인지 확인
    if (ftpBaseUrl.isEmpty || !Uri.parse(ftpBaseUrl).isAbsolute) {
      print('경고: 유효하지 않은 FTP URL입니다. 기본 URL을 사용합니다.');
    }

    // 프로필 이미지 URL 생성
    final imageUrl = '$ftpBaseUrl/coachly/profile/user_$userId.jpg';

    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 프로필 사진
        CircleAvatar(
          radius: 40.0, // 반지름 설정으로 크기 조절
          backgroundImage:
              NetworkImage(getProfileImageUrl(userId)), // 프로필 이미지 URL
        ),
        const SizedBox(width: 16.0), // 프로필 사진과 텍스트 사이 간격
        // 사용자 이름과 자기소개
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName, // 로그인된 사용자의 이름
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const Text('자기소개 내용이 여기에 들어갑니다.', style: TextStyle(fontSize: 16)),
          ],
        ),
      ],
    );
  }
}
