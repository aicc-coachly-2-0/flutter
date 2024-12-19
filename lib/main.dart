import 'package:flutter/material.dart';
import 'package:flutter_application_test/ai_questions_pt/agree.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_test/auth/login.dart';
import 'package:flutter_application_test/home/home.dart';
import 'package:flutter_application_test/nav/bottom.dart'; // Bottom 컴포넌트 임포트

void main() {
  runApp(const ProviderScope(
      child: MyApp())); // ProviderScope로 감싸줘야 상태 관리가 제대로 동작합니다.
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 0, 0, 0), // 기본 테마 색상
        secondaryHeaderColor: Colors.white,
      ),
      home: const Bottom(), // Bottom 컴포넌트를 홈 화면으로 설정
      initialRoute: '/home', // 첫 페이지는 home 설정
      routes: {
        '/login': (context) => const Login(), // 로그인 페이지로 이동
        '/home': (context) => const Homepage(), // 홈 페이지로 이동
        '/aiquestion': (context) =>
            const ExerciseStartPage(), // AI 질문 시작 페이지로 이동
      },
    );
  }
}
