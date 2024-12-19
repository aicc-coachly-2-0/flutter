import 'package:flutter/material.dart';
import 'package:flutter_application_test/nav/bottom.dart';
import 'package:flutter_application_test/nav/sidebar.dart'; // BottomBar 임포트

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      body: const Bottom(), // Bottom 네비게이션 바 컴포넌트
    );
  }
}
