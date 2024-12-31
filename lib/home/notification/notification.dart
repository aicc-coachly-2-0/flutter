import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // TabController 설정: 2개의 탭을 사용
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose(); // TabController 종료
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255), // 앱바 색상
        title: const Text('알림'), // 알림 페이지 타이틀
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          // TabBar로 피드, 커뮤니티 버튼 만들기
          TabBar(
            controller: _tabController,
            indicatorColor: const Color.fromARGB(255, 255, 111, 97), // 밑줄 색상
            indicatorWeight: 3.0, // 밑줄 두께
            labelColor: Colors.black, // 선택된 탭 텍스트 색상
            unselectedLabelColor: Colors.grey, // 선택되지 않은 탭 텍스트 색상
            tabs: const [
              Tab(text: '피드'), // 피드 탭
              Tab(text: '커뮤니티'), // 커뮤니티 탭
            ],
          ),
          // TabBarView로 탭에 맞는 콘텐츠 표시
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                Center(child: Text('피드 페이지 내용')), // 피드 페이지 내용
                Center(child: Text('커뮤니티 페이지 내용')), // 커뮤니티 페이지 내용
              ],
            ),
          ),
        ],
      ),
    );
  }
}