import 'package:flutter/material.dart';

class TabSection extends StatelessWidget {
  final TabController tabController;

  const TabSection({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      indicatorColor: const Color.fromARGB(255, 255, 111, 97), // 선택된 탭의 밑줄 색상
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
    );
  }
}
