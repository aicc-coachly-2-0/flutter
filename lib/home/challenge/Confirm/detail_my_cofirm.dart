import 'package:flutter/material.dart';

class DetailMyConfirm extends StatelessWidget {
  final String userImageUrl;
  final String userName;
  final String validationImageUrl;

  const DetailMyConfirm({
    super.key,
    required this.userImageUrl,
    required this.userName,
    required this.validationImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('인증샷 상세보기'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // 뒤로 가기
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 유저 이미지 (동그란 프로필 이미지)
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(userImageUrl),
            ),
            SizedBox(height: 16),
            // 유저 이름
            Text(
              userName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            // 인증 이미지
            Image.network(
              validationImageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
