import 'package:flutter/material.dart';
import 'package:flutter_application_test/auth/login.dart';

class SignupCompleted extends StatelessWidget {
  const SignupCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입 완료'),
        backgroundColor: const Color.fromARGB(255, 255, 111, 97),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 내용 중앙 정렬
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              size: 80,
              color: Color.fromARGB(255, 255, 111, 97),
            ),
            const SizedBox(height: 20.0),
            const Text(
              '회원가입이 완료되었습니다.',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              '앱 로그인 진행을 위해 로그인 하러 가기 버튼을 눌러주세요.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                // 로그인 페이지로 이동
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Login()), // LoginPage로 이동
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 111, 97),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('로그인 하러 가기'),
            ),
          ],
        ),
      ),
    );
  }
}
