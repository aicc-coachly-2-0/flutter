import 'package:flutter/material.dart';
import 'package:flutter_application_test/nav/sidebar.dart'; // 사이드바 임포트

class FitnessChallenge extends StatefulWidget {
  const FitnessChallenge({super.key});

  @override
  _FitnessChallenge createState() => _FitnessChallenge();
}

final GlobalKey<ScaffoldState> _scaffoldKey =
    GlobalKey<ScaffoldState>(); // GlobalKey 추가

class _FitnessChallenge extends State<FitnessChallenge> {
  final bool _isLatestSelected = false; // 최신순이 선택된 상태
  final bool _isAllUsersSelected = false; // 전체유저가 선택된 상태
  final bool _isUserExpanded = false; // 전체유저 / 팔로우만 버튼 펼침 상태

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
      'content':
          '게시글 내용 ${index + 1} 내용이 이곳에 들어갑니다. 이 내용은 일부만 보여지고, 클릭하면 전체 내용이 보여집니다.',
      'author': '작성자 $index',
      'date': '2024-12-30',
      'likes': '5', // 좋아요 수
      'comments': '10', // 댓글 수
    },
  );

  int currentPage = 1;
  final int postsPerPage = 10;
  bool isLiked = false; // 좋아요 상태
  String selectedSorting = '최신순'; // 정렬 방식
  String selectedUserFilter = '전체유저'; // 사용자 필터 방식

  // 페이지 변경시 호출
  void _changePage(int page) {
    setState(() {
      currentPage = page;
    });
  }

  // 좋아요 버튼 처리
  void _toggleLike() {
    setState(() {
      isLiked = !isLiked; // 좋아요 상태 변경
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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text('첼린지게시판'),
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
                        title: Row(
                          children: [
                            const Text(
                              '[공지]',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 111, 97),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(notices[index]),
                          ],
                        ),
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

              // 최신순 / 인기순 드롭다운 버튼
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // 최신순 드롭다운 버튼
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Color.fromARGB(255, 255, 111, 97),
                        width: 1,
                      ),
                    ),
                    child: DropdownButton<String>(
                      value: selectedSorting,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedSorting = newValue!;
                        });
                      },
                      items: <String>['최신순', '인기순']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      underline: Container(),
                      icon: const Icon(Icons.arrow_drop_down),
                      style: const TextStyle(color: Colors.black),
                      iconSize: 24,
                      elevation: 16,
                      dropdownColor: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 20),

                  // 전체유저 / 팔로우만 드롭다운 버튼
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Color.fromARGB(255, 255, 111, 97),
                        width: 1,
                      ),
                    ),
                    child: DropdownButton<String>(
                      value: selectedUserFilter,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedUserFilter = newValue!;
                        });
                      },
                      items: <String>['전체유저', '팔로우만']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      underline: Container(),
                      icon: const Icon(Icons.arrow_drop_down),
                      style: const TextStyle(color: Colors.black),
                      iconSize: 24,
                      elevation: 16,
                      dropdownColor: Colors.white,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 최근 게시글 목록
              Column(
                children: pagedPosts.map((post) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.zero, // ListTile의 기본 padding 없애기
                          title: Text(post['title']!),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${post['content']!.substring(0, 50)}...', // 일부만 보여짐
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(post['author']!),
                                      const SizedBox(width: 5),
                                      Text(post['date']!,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: _toggleLike,
                                        icon: Icon(
                                          isLiked
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Text(post['likes']!),
                                      const SizedBox(width: 10),
                                      IconButton(
                                        onPressed: () {
                                          print('댓글 클릭');
                                        },
                                        icon: const Icon(Icons.comment),
                                      ),
                                      Text(post['comments']!),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          onTap: () {
                            // 해당 게시글 상세 페이지로 이동하는 로직
                            print('게시글 ${post['title']} 클릭됨');
                          },
                        ),
                      ),
                      // 구분선 추가
                      const Divider(
                        thickness: 1.5, // 구분선 두께
                        color: Color.fromARGB(255, 235, 235, 235), // 구분선 색상
                      ),
                    ],
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
