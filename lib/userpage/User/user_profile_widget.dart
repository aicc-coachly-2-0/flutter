import 'package:flutter/material.dart';
import 'package:flutter_application_test/state_controller/loginProvider.dart';
import 'package:flutter_application_test/userpage/profile_update.dart';
import 'package:flutter_application_test/home/userinfo/follow_tap.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// 팔로우 상태를 관리하는 Provider
final followStateProvider = StateProvider<bool>((ref) => false);

class UserProfileWidget extends ConsumerWidget {
  final Map<String, dynamic> user;
  const UserProfileWidget({super.key, required this.user});

  Future<void> followUser(BuildContext context, String userToken,
      bool isFollowing, WidgetRef ref) async {
    final String userNumber = user['user_number'].toString();
    final String url =
        'http://localhost:8080/user/$userNumber/${isFollowing ? 'unfollow' : 'follow'}';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'user_number': userNumber,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(isFollowing ? '언팔로우 성공' : '팔로우 성공')),
        );
        // 팔로우/언팔로우 상태 변경
        ref.read(followStateProvider.notifier).state = !isFollowing;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('네트워크 오류 발생')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('네트워크 오류 발생')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // User 객체가 null이 아닌지 확인한 후 token에 접근
    final userToken = ref.watch(authProvider);

    if (userToken == null) {
      // 로그인되지 않은 상태에서는 토큰이 없으므로 적절한 처리
      return const Center(child: Text('로그인 필요'));
    }
    final token = userToken.token;

    // 팔로우 상태 (기본값은 팔로우 안 된 상태로 시작)
    final isFollowing = ref.watch(followStateProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // 사용자 프로필 섹션
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 프로필 사진
            CircleAvatar(
              radius: 40.0,
              backgroundImage: user['img_link'] != null
                  ? NetworkImage('${dotenv.env['FTP_URL']}${user['img_link']}')
                  : const AssetImage('assets/image.png') as ImageProvider,
            ),
            const SizedBox(width: 16.0),
            // 사용자 이름과 자기소개
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user['user_name'] ?? '이름 없음',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  user['bio'] ?? '자기소개 내용이 여기에 들어갑니다.',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16.0),

        // 팔로우 및 팔로워와 프로필 수정 버튼을 한 줄에 배치
        Row(
          children: [
            // 팔로우 및 팔로워 수를 버튼으로 묶기
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  backgroundColor: Colors.white,
                  side: BorderSide(
                    color: const Color.fromARGB(255, 255, 176, 123),
                    width: 1.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FollowTap(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: const Color.fromARGB(255, 255, 176, 123),
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '팔로우 ${user['following_users'].length}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '팔로워 ${user['followers'].length}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            // 팔로잉/언팔로잉 버튼 클릭 시 상태에 따라 처리
            ElevatedButton(
              onPressed: () {
                followUser(context, token, isFollowing, ref); // 팔로우/언팔로우 API 호출
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isFollowing
                    ? const Color.fromARGB(255, 255, 111, 97) // 언팔로우일 때 색상
                    : const Color.fromARGB(255, 255, 111, 97), // 팔로우일 때 색상
              ),
              child: Text(
                isFollowing ? '언팔로우' : '팔로잉',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
