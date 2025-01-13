import 'package:flutter/material.dart';
import 'package:flutter_application_test/state_controller/loginProvider.dart';
import 'package:flutter_application_test/userpage/Mypage/follow_and_profile_buttons.dart';
import 'package:flutter_application_test/userpage/Mypage/profile_image.dart';
import 'package:flutter_application_test/userpage/Mypage/tab_section.dart';
import 'package:flutter_application_test/userpage/Mypage/user_comunity.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_test/home/userinfo/follow_tap.dart';
import 'package:flutter_application_test/userpage/feed_upload.dart';
import 'package:flutter_application_test/userpage/profile_update.dart';
import 'package:flutter_application_test/userpage/Mypage/user_feed.dart';

// 유저 마이페이지
class UserMyPage extends ConsumerStatefulWidget {
  const UserMyPage({super.key});

  @override
  _UserMyPageState createState() => _UserMyPageState();
}

class _UserMyPageState extends ConsumerState<UserMyPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this); // 두 개의 탭 설정 (피드, 게시판)
  }

  @override
  void dispose() {
    _tabController.dispose(); // TabController 해제
    super.dispose();
  }

  // 유저의 프로필 이미지를 가져오는 URL 생성
  String getProfileImageUrl(String userId) {
    final ftpBaseUrl =
        dotenv.env['FTP_URL'] ?? 'http://default.url'; // FTP 서버 URL (기본값 제공)
    final imageUrl = '$ftpBaseUrl/coachly/profile/user_$userId.jpg';
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    // 사용자 정보 가져오기
    final user = ref.watch(authProvider); // authProvider에서 user 정보를 가져옴

    if (user == null) {
      // user가 null일 경우 UI 처리
      return Scaffold(
        appBar: AppBar(title: const Text("마이페이지")),
        body: const Center(child: Text('로그인 정보가 없습니다.')),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ProfileImage(
              userId: user.userId,
              userNumber: user.userNumber,
              userName: user.userName,
            ), // ProfileImage 위젯
            const SizedBox(height: 16.0),
            FollowAndProfileButtons(), // FollowAndProfileButtons 위젯
            const SizedBox(height: 16.0),

            // 피드/게시판 탭 버튼
            TabSection(tabController: _tabController), // TabSection 위젯
            const SizedBox(height: 10.0),

            // TabBarView로 피드와 게시판 내용 표시
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  UserFeed(), // 피드 페이지 내용 (UserFeed 페이지로 변경)
                  const UserComunity(), // 게시판 페이지 내용
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FeedUpload(),
            ),
          );
          print('추가하기 버튼 눌림');
          // 추가 버튼을 눌렀을 때의 동작을 구현할 수 있습니다.
        },
        backgroundColor: const Color.fromARGB(255, 255, 111, 97), // + 아이콘
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0), // 원형 모양 설정
        ), // 버튼 색상
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
