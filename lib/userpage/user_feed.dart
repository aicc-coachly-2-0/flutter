import 'package:flutter/material.dart';
import 'package:flutter_application_test/userpage/feed_check.dart'; // FeedCheck import

class UserFeed extends StatelessWidget {
  UserFeed({super.key});

  // 이미지 URL 리스트 (예시)
  final List<String> imageUrls = [
    'assets/image.png',
    'assets/image.png',
    'assets/image.png',
    'assets/image.png',
    'assets/image.png',
    'assets/image.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.all(0.1), // 전체 패딩
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 한 줄에 3개의 사진
            crossAxisSpacing: 2.0, // 가로 간격
            mainAxisSpacing: 2.0, // 세로 간격
          ),
          itemCount: imageUrls.length, // 이미지 개수
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                // 이미지 클릭 시 FeedCheck 페이지로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FeedCheck(), // FeedCheck로 이동
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageUrls[index]),
                    fit: BoxFit.cover, // 이미지를 박스에 맞게 꽉 채움
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
