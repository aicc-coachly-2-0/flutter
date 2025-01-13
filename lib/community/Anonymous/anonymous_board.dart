import 'package:flutter/material.dart';
import 'package:flutter_application_test/community/Anonymous/anonymous_post_section.dart';
import 'package:flutter_application_test/community/Beginner/beginner_post_section.dart';
import 'package:flutter_application_test/community/Notice/notice_section.dart';
import 'package:flutter_application_test/community/widgets/pagination_section.dart';
import 'package:flutter_application_test/community/widgets/sorting_section.dart';
import 'package:flutter_application_test/get_method/community_get.dart';
import 'package:flutter_application_test/nav/sidebar.dart';

class AnonymousBoard extends StatefulWidget {
  const AnonymousBoard({super.key});

  @override
  _AnonymousBoardState createState() => _AnonymousBoardState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _AnonymousBoardState extends State<AnonymousBoard> {
  List<Post> posts = [];
  int currentPage = 1;
  final int postsPerPage = 10;

  // 게시글 목록 페이지 계산
  List<Post> get pagedPosts {
    int startIndex = (currentPage - 1) * postsPerPage;
    int endIndex = startIndex + postsPerPage;
    return posts.sublist(
        startIndex, endIndex < posts.length ? endIndex : posts.length);
  }

  // 페이지 변경시 호출
  void _changePage(int page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text('익명게시판'),
        actions: [
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
              NoticeSection(), // 공지사항 섹션
              const SizedBox(height: 20),
              SortingSection(), // 정렬 및 필터 드롭다운 섹션
              const SizedBox(height: 20),
              // 게시글 목록 섹션
              AnonymousPostSection(), // 페이징된 게시글을 전달
              const SizedBox(height: 20),
              // 페이지네이션 섹션
              PaginationSection(
                currentPage: currentPage,
                totalPosts: posts.length,
                postsPerPage: postsPerPage,
                onPageChanged: _changePage,
              ),
            ],
          ),
        ),
      ),
      endDrawer: SideBar(), // 사이드바 불러오기
    );
  }
}
