import 'package:flutter/material.dart';

class UserFeed extends StatelessWidget {
  // const 제거하고 일반적인 생성자로 수정
  UserFeed({super.key});

  // 이미지 URL 리스트 (예시)
  final List<String> imageUrls = [
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/150',
    'https://via.placeholder.com/150',
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
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrls[index]),
                  fit: BoxFit.cover, // 이미지를 박스에 맞게 꽉 채움
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
