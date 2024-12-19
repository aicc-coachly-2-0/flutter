import 'package:flutter/material.dart';
import 'package:flutter_application_test/auth/login.dart';
import 'package:flutter_application_test/home/calendar.dart/my_calendar.dart';
import 'package:flutter_application_test/home/payment/payment_widget.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7, // 화면 너비의 70%를 차지
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), // 사이드바 배경색
      child: Column(
        children: <Widget>[
          // 사이드바 상단에 프로필 이미지, 이름 추가
          DrawerHeader(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/image.png'),
                ),
                const SizedBox(width: 10),
                const Text(
                  '홍길동', // 사용자 이름
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // 사이드바 메뉴 항목들
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('내 정보'),
                  onTap: () {
                    // 내 정보 클릭 시 동작
                    print('내 정보 클릭');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.calendar_month_outlined),
                  title: const Text('운동 캘린더 작성'),
                  onTap: () {
                    // 내 정보 클릭 시 동작
                    print('내 운동 달력 클릭');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalendarUpdate(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.payment),
                  title: const Text('내 결제 정보'),
                  onTap: () {
                    // 내 결제 정보 클릭 시 동작
                    print('내 결제 정보 클릭');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PaymentWidget(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.help),
                  title: const Text('1대1 문의하기'),
                  onTap: () {
                    // 1대1 문의하기 클릭 시 동작
                    print('1대1 문의하기 클릭');
                  },
                ),
                // 추가 항목들
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('설정'),
                  onTap: () {
                    // 설정 클릭 시 동작
                    print('설정 클릭');
                  },
                ),
              ],
            ),
          ),
          // "로그아웃" 버튼 추가
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListTile(
              leading: const Icon(Icons.exit_to_app), // 로그아웃 아이콘
              title: const Text('로그아웃'),
              onTap: () {
                // 로그아웃 클릭 시 동작
                print('로그아웃 클릭');
                // 여기에 로그아웃 처리 로직 추가 (예: 로그인 화면으로 이동)
                // Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ),
          // "로그인하기" 버튼 추가
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListTile(
              leading: const Icon(Icons.login), // 로그인 아이콘
              title: const Text('로그인하기'),
              onTap: () {
                // 로그인하기 클릭 시 동작
                print('로그인하기 클릭');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Login()), // 로그인 화면으로 이동
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
