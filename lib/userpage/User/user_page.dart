// user_page.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/get_method/community_get.dart';
import 'package:flutter_application_test/home/userinfo/follow_tap.dart';
import 'package:flutter_application_test/userpage/user_feeds.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_test/userpage/Mypage/user_comunity.dart';
import 'package:flutter_application_test/userpage/profile_update.dart';
import 'package:flutter_application_test/userpage/Mypage/user_feed.dart';
import 'user_profile_widget.dart'; // 사용자 프로필 위젯 import
import 'tab_views.dart'; // 탭 관련 위젯 import

class UserPage extends StatefulWidget {
  final Post post;
  const UserPage({super.key, required this.post});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<Map<String, dynamic>> userData;
  late Future<List<Map<String, dynamic>>>
      userFeedData; // List<Map<String, dynamic>> 타입으로 수정

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this); // 두 개의 탭 설정 (피드, 게시판)
    userData = fetchUserData(); // 사용자의 데이터를 비동기로 받아옴
    userFeedData = fetchUsersData(); // 사용자 피드 데이터를 비동기로 받아옴
  }

  @override
  void dispose() {
    _tabController.dispose(); // TabController 해제
    super.dispose();
  }

  // 사용자 데이터를 받아오는 함수
  Future<Map<String, dynamic>> fetchUserData() async {
    final response = await http.get(
      Uri.parse(
          'http://localhost:8080/user/${widget.post.userNumber}'), // URL에 사용자 번호 포함
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']; // 'data'는 서버 응답에서 실제 사용자 정보를 포함하는 키입니다.
    } else {
      throw Exception('사용자 정보를 불러오는 데 실패했습니다.');
    }
  }

  // 사용자 피드 데이터를 받아오는 함수
  Future<List<Map<String, dynamic>>> fetchUsersData() async {
    final response = await http.get(
      Uri.parse('http://localhost:8080/feeds/users/${widget.post.userNumber}'),
    );

    if (response.statusCode == 200) {
      final userFeedData = jsonDecode(response.body);

      // 응답 데이터 출력
      print('Response body: $userFeedData');

      // 'feeds' 키가 없으면 예외를 던짐
      if (userFeedData['feeds'] == null) {
        throw Exception('유효하지 않은 사용자 피드 데이터입니다.');
      }

      // 'feeds'가 배열이라면 그것을 반환
      return List<Map<String, dynamic>>.from(userFeedData['feeds']);
    } else {
      throw Exception('사용자 피드 데이터를 불러오는 데 실패했습니다.');
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text('프로필'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Map<String, dynamic>>(
          future: userData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('오류 발생: ${snapshot.error}'));
            }

            if (!snapshot.hasData) {
              return const Center(child: Text('사용자 데이터를 찾을 수 없습니다.'));
            }

            final user = snapshot.data!;

            return FutureBuilder<List<Map<String, dynamic>>>(
              future: userFeedData, // 타입에 맞게 수정
              builder: (context, feedSnapshot) {
                if (feedSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (feedSnapshot.hasError) {
                  return Center(child: Text('오류 발생: ${feedSnapshot.error}'));
                }

                if (!feedSnapshot.hasData) {
                  return const Center(child: Text('피드 데이터를 찾을 수 없습니다.'));
                }

                final feedData = feedSnapshot.data!;

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      UserProfileWidget(user: user),
                      const SizedBox(height: 16.0),
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 400,
                        child: TabViews(
                          tabController: _tabController,
                          userFeedData: feedData, // 피드 데이터를 넘기기
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
