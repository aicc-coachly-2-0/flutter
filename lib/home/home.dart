import 'package:flutter/material.dart';
import 'package:flutter_application_test/auth/login.dart';
import 'package:flutter_application_test/nav/bottom.dart';
import 'package:flutter_application_test/nav/sidebar.dart';
import 'package:flutter_application_test/state_controller/loginProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // BottomBar 임포트

class Homepage extends ConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);

    // 로그인 상태가 없다면 로그인 화면으로 리다이렉션
    if (user == null) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()), // 로그인 페이지로 이동
        );
      });
    }

    return Scaffold(
      drawer: const SideBar(),
      body: const Bottom(), // Bottom 네비게이션 바 컴포넌트
    );
  }
}
