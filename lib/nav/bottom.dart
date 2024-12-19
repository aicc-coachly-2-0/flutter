import 'package:flutter/material.dart';
import 'package:flutter_application_test/ai_service/ai_service.dart';
import 'package:flutter_application_test/comunity/main_comunity.dart';
import 'package:flutter_application_test/home/main_home.dart';
// import 'package:flutter_application_test/home/video.dart';
import 'package:flutter_application_test/nav/sidebar.dart'; // 사이드바 임포트

class Bottom extends StatefulWidget {
  const Bottom({super.key});

  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int _selectedIndex = 0; // 현재 선택된 탭 인덱스
  final List<String> _titles = [
    'HOME', // Home 화면의 타이틀
    'Challenge', // AI 서비스 화면의 타이틀
    'AI Services', // AI 서비스 화면의 타이틀
    'Comunity', // Video 화면의 타이틀
    'My Page', // My Page 화면의 타이틀
  ];

  final List<Widget> _screens = [
    // 각 탭에 대응되는 화면들
    const MainHome(),
    Center(child: Text('Challenge')),
    const AiServiceChoice(), // AI 서비스 화면
    const MainCommunity(), // VideoTime 화면
    Center(child: Text('More Screen')),
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // GlobalKey 추가

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // 선택된 인덱스를 업데이트
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;

    return Scaffold(
      key: _scaffoldKey, // Scaffold에 key 설정
      endDrawer: const SideBar(), // 오른쪽 사이드바 설정
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 111, 97), // 원하는 색으로 설정
        title: Text(_titles[_selectedIndex]), // 탭에 맞는 타이틀 표시
        automaticallyImplyLeading: false, // 기본 뒤로가기 버튼을 없앰
        actions: [
          // 메뉴 버튼을 오른쪽에 배치
          IconButton(
            icon: const Icon(Icons.menu), // 메뉴 아이콘
            onPressed: () {
              // 메뉴 버튼 클릭 시 사이드바 열기
              _scaffoldKey.currentState?.openEndDrawer(); // 오른쪽 사이드바 열기
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex], // 현재 선택된 화면을 표시
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        height: screenHeight * 0.11, // 바텀 네비게이션의 높이
        child: BottomNavigationBar(
          currentIndex: _selectedIndex, // 현재 선택된 탭 인덱스
          onTap: _onItemTapped, // 탭 클릭 시 실행되는 함수
          selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
          unselectedItemColor: const Color.fromARGB(153, 0, 0, 0),
          type: BottomNavigationBarType.fixed, // 고정된 탭
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 18),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.flag, size: 18),
              label: 'Challenge',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.smart_toy_sharp, size: 18),
              label: 'AI Services',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt, size: 18),
              label: 'Comunity',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_pin_sharp, size: 18),
              label: 'My Page',
            ),
          ],
        ),
      ),
    );
  }
}
