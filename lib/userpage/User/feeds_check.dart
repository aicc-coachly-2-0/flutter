import 'package:flutter/material.dart';
import 'package:flutter_application_test/get_method/user_feed_get.dart';
import 'package:flutter_application_test/nav/Comment/feed_comment.dart';
import 'package:flutter_application_test/nav/report_feed_button.dart';
import 'package:flutter_application_test/state_controller/loginProvider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpod을 사용해 로그인된 사용자 정보 가져오기

class FeedsCheck extends ConsumerWidget {
  final Feed feed;

  const FeedsCheck({super.key, required this.feed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('${feed.userName}의 피드'), // 로그인된 사용자의 이름을 타이틀에 표시
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz), // 점점점 버튼
            onPressed: () {
              // 점점점 버튼 눌렀을 때 ReportButton 모달 띄우기
              showModalBottomSheet(
                context: context,
                isScrollControlled: true, // 스크롤 가능하도록 설정
                backgroundColor: Colors.transparent, // 모달 배경을 투명하게 처리
                builder: (BuildContext context) {
                  return ReportButton(); // ReportButton 컴포넌트 호출
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        // 전체 스크롤 가능하게 처리
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 사용자 정보 표시
            Row(
              children: [
                // 프로필 사진
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      '${dotenv.env['FTP_URL']}${feed.userImg}'), // 프로필 사진 (예시 URL)
                ),
                SizedBox(width: 10),
                // 사용자 이름과 날짜
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feed.userName, // 로그인된 사용자의 이름을 표시
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      '${feed.createdAt}', // 게시물 작성 날짜
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
                Spacer(), // 오른쪽으로 밀기
                // 팔로우 버튼
                ElevatedButton(
                  onPressed: () {
                    // 팔로우 버튼 눌렀을 때 동작
                    print('팔로우 버튼 클릭');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    backgroundColor: Color.fromARGB(255, 255, 111, 97),
                  ),
                  child: Text(
                    '팔로우',
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // 피드 이미지 (가로폭을 전부 차지하는 정사각형)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                '${dotenv.env['FTP_URL']}${feed.imgNumber}', // 서버에서 받아온 이미지 URL
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),

            // 좋아요와 댓글 버튼
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.favorite_border), // 빈 하트로 좋아요 버튼
                  onPressed: () {
                    // 좋아요 버튼 눌렀을 때 동작
                    print('좋아요 버튼 클릭');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.comment), // 댓글 아이콘
                  onPressed: () {
                    print('댓글 버튼 클릭');
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true, // 하단 시트 크기 조정
                      backgroundColor: Colors.transparent, // 배경을 투명하게 설정
                      builder: (BuildContext context) {
                        return FeedComment(
                            feed: feed); // FeedComment 위젯을 호출하여 하단에 표시
                      },
                    );
                  },
                ),
              ],
            ),
            // 제목과 내용
            Text(
              feed.content, // 피드의 내용 표시
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
