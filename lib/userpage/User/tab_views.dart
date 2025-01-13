import 'package:flutter/material.dart';
import 'package:flutter_application_test/userpage/User/users_feeds.dart';
import 'package:flutter_application_test/userpage/Mypage/user_comunity.dart';

class TabViews extends StatelessWidget {
  final TabController tabController;
  final List<Map<String, dynamic>>
      userFeedData; // 타입을 List<Map<String, dynamic>>으로 수정

  const TabViews(
      {super.key, required this.tabController, required this.userFeedData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 피드/게시판 탭 버튼
        TabBar(
          controller: tabController,
          indicatorColor: const Color.fromARGB(255, 255, 111, 97),
          indicatorWeight: 3.0,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(icon: Icon(Icons.mms, size: 28)),
            Tab(icon: Icon(Icons.comment_outlined, size: 28)),
          ],
        ),
        const SizedBox(height: 10.0),

        // TabBarView로 피드와 게시판 내용 표시
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              UsersFeeds(userFeedData: userFeedData), // userFeedData 전달
              UserComunity(), // 필요한 경우 UserComunity에도 데이터를 전달할 수 있습니다.
            ],
          ),
        ),
      ],
    );
  }
}
