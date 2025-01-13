import 'package:flutter/material.dart';

class MissionTabs extends StatelessWidget {
  final TabController tabController;

  const MissionTabs({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      indicatorColor: Color.fromARGB(255, 255, 111, 97), // 밑줄 색상
      indicatorWeight: 3.0, // 밑줄 두께
      labelColor: Colors.black, // 선택된 탭 텍스트 색상
      unselectedLabelColor: Colors.grey, // 선택되지 않은 탭 텍스트 색상
      tabs: const [
        Tab(text: '내인증'), // 내인증 탭
        Tab(text: '참가자 인증'), // 참가자 인증 탭
      ],
    );
  }
}
