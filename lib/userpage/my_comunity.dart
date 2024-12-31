import 'package:flutter/material.dart';

class MyComunity extends StatelessWidget {
  const MyComunity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색을 흰색으로 설정
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // 첫 번째 게시글
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.grey[300]!, width: 1.5)), // 밑줄 추가
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 게시글 제목과 올린 날짜
                  Row(
                    children: [
                      Text(
                        '게시글 제목 1',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '2024-12-30', // 올린 날짜
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0), // 제목과 내용 사이의 여백
                  // 게시글 내용
                  Text(
                    '여기는 게시글 내용이 들어가는 부분입니다. '
                    '여기에는 게시글에 대한 설명이나 내용을 자유롭게 작성할 수 있습니다.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            // 두 번째 게시글
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.grey[300]!, width: 1.5)), // 밑줄 추가
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 게시글 제목과 올린 날짜
                  Row(
                    children: [
                      Text(
                        '게시글 제목 2',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '2024-12-29', // 올린 날짜
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0), // 제목과 내용 사이의 여백
                  // 게시글 내용
                  Text(
                    '이 게시글의 내용은 여기에 나타납니다. '
                    '사용자는 이곳에서 다양한 정보를 확인할 수 있습니다.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            // 세 번째 게시글
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.grey[300]!, width: 1.5)), // 밑줄 추가
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 게시글 제목과 올린 날짜
                  Row(
                    children: [
                      Text(
                        '게시글 제목 3',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '2024-12-28', // 올린 날짜
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0), // 제목과 내용 사이의 여백
                  // 게시글 내용
                  Text(
                    '세 번째 게시글의 내용이 여기에 표시됩니다. '
                    '게시판에서 다양한 주제로 게시글을 작성할 수 있습니다.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
