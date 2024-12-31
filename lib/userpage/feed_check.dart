import 'package:flutter/material.dart';
import 'package:flutter_application_test/nav/feed_comment.dart';
import 'package:flutter_application_test/nav/report_feed_button.dart';

class FeedCheck extends StatelessWidget {
  const FeedCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OOO의 피드'), // 타이틀은 OOO의 피드
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
        // 여기서 전체를 스크롤 가능하게 만듭니다.
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 사용자 정보
            Row(
              children: [
                // 프로필 사진
                CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      AssetImage('assets/image.png'), // 프로필 사진 (예시 URL)
                ),
                SizedBox(width: 10),
                // 사용자 이름과 날짜
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '사용자 이름', // 사용자 이름
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      '2024년 12월 20일', // 게시물 작성 날짜
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

            // 사진 (가로폭을 전부 차지하는 정사각형)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/image.png', // 이미지 (예시 URL)
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
                        return FeedComment(); // FeedComment 위젯을 호출하여 하단에 표시
                      },
                    );
                  },
                ),
              ],
            ),
            // 제목과 내용
            Text(
              '피드 제목',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              '여기에 피드 내용이 들어갑니다. 이 부분에 사용자가 작성한 내용을 출력합니다.',
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
