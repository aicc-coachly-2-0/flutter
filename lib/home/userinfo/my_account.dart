import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/userinfo/cancel_user.dart';
import 'package:flutter_application_test/home/userinfo/info_update.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('계정관리'), // 상단 앱바의 계정관리 텍스트
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0), // 바디의 패딩
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 텍스트 왼쪽 정렬
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0), // 왼쪽 패딩 추가
              child: const Text(
                'My Account', // My Account 텍스트
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 111, 97)),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10.0), // 왼쪽 패딩 추가
              child: const Text(
                '계정관리', // 계정관리 텍스트
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(), // 밑줄
            const SizedBox(height: 10),
            // 내 정보 수정하기 텍스트 버튼
            TextButton(
              onPressed: () {
                print('내 정보 수정하기 클릭');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyInfoUpdate(),
                  ),
                );
                // 내 정보 수정 로직 추가
              },
              child: const Text(
                '내 정보 수정',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black, // 텍스트 색상
                ),
              ),
            ),
            // 계정 탈퇴 텍스트 버튼
            TextButton(
              onPressed: () {
                print('계정 탈퇴 클릭');
                _showCancelBottomSheet(context);

                // 계정 탈퇴 로직 추가
              },
              child: const Text(
                '계정 탈퇴',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black, // 계정 탈퇴 텍스트 색상
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 계정 탈퇴 BottomSheet를 띄우는 함수
void _showCancelBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // 하단 탭의 크기 조절을 위해 true 설정
    builder: (BuildContext context) {
      return const CancelUser(); // 하단 탭으로 CancelUser 페이지를 띄웁니다.
    },
  );
}
