import 'package:flutter/material.dart';
import 'package:flutter_application_test/get_method/community_get.dart'; // Post 클래스 임포트
import 'package:flutter_application_test/get_method/user_info_get.dart';
import 'package:flutter_application_test/state_controller/loginProvider.dart'; // authProvider 임포트
import 'package:flutter_application_test/userpage/User/user_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 임포트
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart'; // Riverpod 사용

class UserPostHeader extends ConsumerWidget {
  final Post post;
  final User user;

  const UserPostHeader({super.key, required this.post, required this.user});

  // 사용자 정보를 가져오는 함수
  Future<UserInfo> fetchUserInfo(WidgetRef ref) async {
    final userInfo = await fetchUserDetails(ref); // 로그인한 사용자의 정보 가져오기
    return userInfo;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userImg = post.userImgPath; // 게시글 작성자의 userNumber
    print(userImg);

    return FutureBuilder<UserInfo>(
      future: fetchUserInfo(ref), // 비동기로 사용자 정보 가져오기
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 10),
              Text('로딩 중...'),
            ],
          );
        }

        if (snapshot.hasError) {
          return Row(
            children: [
              Icon(Icons.error, color: Colors.red),
              SizedBox(width: 10),
              Text('오류 발생: ${snapshot.error}'),
            ],
          );
        }

        if (snapshot.hasData) {
          final userInfo = snapshot.data!;
          final PostUserNumber = post.userNumber;

          return Row(
            children: [
              // GestureDetector로 프로필 클릭 시 UserPage로 이동
              GestureDetector(
                onTap: () {
                  // 프로필 이미지를 클릭했을 때 UserPage로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UserPage(post: post), // UserPage로 데이터 전달
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      '${dotenv.env['FTP_URL']}$userImg'), // 프로필 이미지 URL 사용
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.userName,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(_formatDate(post.createdAt),
                      style: const TextStyle(color: Colors.grey)), // 게시글 작성 시간
                ],
              ),
            ],
          );
        }

        return SizedBox(); // 데이터가 없을 때는 빈 공간 반환
      },
    );
  }
}

// 날짜 형식을 yyyy-MM-dd로 변환하는 함수
String _formatDate(String date) {
  DateTime parsedDate = DateTime.parse(date); // 문자열을 DateTime으로 변환
  return DateFormat('yyyy-MM-dd HH:mm')
      .format(parsedDate); // yyyy-MM-dd HH:mm:ss 형식으로 반환
}
