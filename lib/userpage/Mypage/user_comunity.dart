import 'package:flutter/material.dart';
import 'package:flutter_application_test/community/UserPost/user_post.dart';
import 'package:flutter_application_test/get_method/community_get.dart'; // fetchPosts 함수
import 'package:flutter_application_test/state_controller/loginProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserComunity extends ConsumerStatefulWidget {
  const UserComunity({super.key});

  @override
  _UserComunityState createState() => _UserComunityState();
}

class _UserComunityState extends ConsumerState<UserComunity> {
  List<Post> posts = [];
  bool isLoading = true;

  // API에서 게시글을 가져오는 함수
  Future<void> fetchPostsData(int userNumber) async {
    try {
      // 이미 fetchPosts를 외부에서 가져와서 사용하므로 함수명만 수정
      final fetchedPosts = await fetchPosts(userNumber);
      setState(() {
        posts = fetchedPosts;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching posts: $e');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 로그인된 사용자 정보 가져오기 (userNumber)
    final user = ref.watch(authProvider);

    // 로그인되지 않았으면 로그인 화면이나 메시지 표시
    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('게시판'),
        ),
        body: Center(child: Text("로그인되지 않았습니다.")),
      );
    }

    // 사용자 번호 (userNumber) 확인
    int userNumber = user.userNumber;

    // 게시글을 가져오기 전에 이미 로딩이 완료되지 않았다면 fetchPosts 호출
    if (isLoading) {
      fetchPostsData(userNumber);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator()) // 로딩 중에는 로딩 표시
            : ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1.5,
                        ),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        // 게시글 클릭 시 UserPost 페이지로 이동
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UserPost(post: post), // 여기가 포스트 넘기기
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                // 제목에 가로 넘침 방지
                                child: Text(
                                  post.title,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow:
                                      TextOverflow.ellipsis, // 가로 넘어가면 ...으로 표시
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                post.createdAt.split('T')[0], // 날짜 형식
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            post.content,
                            style: TextStyle(fontSize: 16.0),
                            overflow: TextOverflow.ellipsis, // 가로 넘어가면 ...으로 표시
                            maxLines: 2, // 최대 두 줄로 제한
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
