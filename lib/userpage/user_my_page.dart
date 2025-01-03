import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/userinfo/follow_tap.dart';
import 'package:flutter_application_test/userpage/feed_upload.dart';
import 'package:flutter_application_test/userpage/my_comunity.dart';
import 'package:flutter_application_test/userpage/profile_update.dart';
import 'package:flutter_application_test/userpage/user_feed.dart';

// 유저 마이페이지
class UserMyPage extends StatefulWidget {
  const UserMyPage({super.key});

  @override
  _UserMyPageState createState() => _UserMyPageState();
}

class _UserMyPageState extends State<UserMyPage>
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 사용자 프로필 섹션
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 프로필 사진
                CircleAvatar(
                  radius: 40.0, // 반지름 설정으로 크기 조절
                  backgroundImage:
                      AssetImage('assets/image.png'), // 프로필 이미지 URL
                ),
                const SizedBox(width: 16.0), // 프로필 사진과 텍스트 사이 간격
                // 사용자 이름과 자기소개
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '사용자 이름',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text('자기소개 내용이 여기에 들어갑니다.', style: TextStyle(fontSize: 16)),
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
                      backgroundColor: Colors.white, // 텍스트 색상
                      side: BorderSide(
                        color: const Color.fromARGB(
                            255, 255, 176, 123), // 버튼 테두리 색상
                        width: 1.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0), // 둥근 모서리
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FollowTap(), // 임시로 FocusOnExercisePage로 이동
                        ),
                      );
                      // 팔로우 관련 버튼 클릭 시 동작을 여기에 추가
                      print("팔로우 클릭");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 팔로우 텍스트
                        Expanded(
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                    color: const Color.fromARGB(
                                        255, 255, 176, 123),
                                    width: 1.0), // 팔로우와 팔로워 구분선
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('팔로우 100',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                        // 팔로워 텍스트
                        Expanded(
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('팔로워 258',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 16.0), // 프로필 수정 버튼과의 간격
                // 프로필 수정 버튼
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProfileUpdate(), // 임시로 FocusOnExercisePage로 이동
                      ),
                    );
                    print('프로필 수정');
                    // 프로필 수정 로직 추가
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromARGB(255, 255, 111, 97), // 버튼 색상
                  ),
                  child: const Text(
                    '프로필 수정',
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // 피드/게시판 탭 버튼
            TabBar(
              controller: _tabController,
              indicatorColor:
                  const Color.fromARGB(255, 255, 111, 97), // 선택된 탭의 밑줄 색상
              indicatorWeight: 3.0, // 밑줄 두께
              labelColor: Colors.black, // 선택된 탭 텍스트 색상
              unselectedLabelColor: Colors.grey, // 선택되지 않은 탭 텍스트 색상
              tabs: [
                // 피드 탭 아이콘
                Tab(
                  icon: Icon(
                    Icons.mms, // 피드 아이콘
                    size: 28,
                  ),
                ),
                // 게시판 탭 아이콘
                Tab(
                  icon: Icon(
                    Icons.comment_outlined, // 게시판 아이콘
                    size: 28,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),

            // TabBarView로 피드와 게시판 내용 표시
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  UserFeed(), // 피드 페이지 내용 (UserFeed 페이지로 변경)
                  MyComunity(), // 게시판 페이지 내용
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
              builder: (context) => FeedUpload(),
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
