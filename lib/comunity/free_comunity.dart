import 'package:flutter/material.dart';
import 'package:flutter_application_test/nav/sidebar.dart'; // 사이드바 임포트

class FreeCommunity extends StatefulWidget {
  const FreeCommunity({super.key});

  @override
  _FreeCommunityState createState() => _FreeCommunityState();
}

final GlobalKey<ScaffoldState> _scaffoldKey =
    GlobalKey<ScaffoldState>(); // GlobalKey 추가

class _FreeCommunityState extends State<FreeCommunity> {
  // 예시 데이터: 공지사항 및 게시글
  List<String> notices = [
    '공지사항 제목 1',
    '공지사항 제목 2',
    '공지사항 제목 3',
  ];

  List<Map<String, String>> posts = List.generate(
    20,
    (index) => {
      'image': 'https://via.placeholder.com/150',
      'title': '게시글 제목 ${index + 1}',
    },
  );

  int currentPage = 1;
  final int postsPerPage = 10;

  // 페이지 변경시 호출
  void _changePage(int page) {
    setState(() {
      currentPage = page;
    });
  }

  // 게시글 목록 페이지 계산
  List<Map<String, String>> get pagedPosts {
    int startIndex = (currentPage - 1) * postsPerPage;
    int endIndex = startIndex + postsPerPage;
    return posts.sublist(
        startIndex, endIndex < posts.length ? endIndex : posts.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Scaffold의 key 추가
      appBar: AppBar(
        title: const Text('자유게시판'),
        backgroundColor: const Color.fromARGB(255, 255, 111, 97),
        actions: [
          // 오른쪽 상단에 사이드바 열기 버튼
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer(); // 사이드바 열기
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 공지사항 섹션
              const Text(
                "공지사항",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Divider(thickness: 1.5),
              // 공지사항 3개
              Column(
                children: List.generate(3, (index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(notices[index]),
                      ),
                      const Divider(), // 공지사항 구분선
                    ],
                  );
                }),
              ),
              const SizedBox(height: 20),

              // 최근 게시글 섹션
              const Text(
                "최근 게시글",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // 최근 게시글 목록
              Column(
                children: pagedPosts.map((post) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12.0),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(post['image']!),
                        radius: 30,
                      ),
                      title: Text(post['title']!),
                      onTap: () {
                        // 해당 게시글 상세 페이지로 이동하는 로직
                        print('게시글 ${post['title']} 클릭됨');
                      },
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // 페이지네이션
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: currentPage > 1
                        ? () => _changePage(currentPage - 1)
                        : null,
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Text('Page $currentPage'),
                  IconButton(
                    onPressed: currentPage * postsPerPage < posts.length
                        ? () => _changePage(currentPage + 1)
                        : null,
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      endDrawer: const SideBar(), // 사이드바 추가
    );
  }
}
