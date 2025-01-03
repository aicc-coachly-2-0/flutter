import 'package:flutter/material.dart';
import 'package:flutter_application_test/ai_service/subscription.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_test/auth/login.dart';
import 'package:flutter_application_test/home/calendar/my_calendar.dart';
import 'package:flutter_application_test/home/question/frequencyquestion.dart';
import 'package:flutter_application_test/home/question/question.dart';
import 'package:flutter_application_test/home/userinfo/my_account.dart';
import 'package:flutter_application_test/state_controller/loginProvider.dart';

class SideBar extends ConsumerWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 로그인된 유저 정보 가져오기
    final user = ref.watch(authProvider);

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7, // 화면 너비의 70%를 차지
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), // 사이드바 배경색
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // 둥근 모서리 제거 (각진 모서리)
      ),
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
                Text(
                  user != null ? user.userEmail : '홍길동', // 로그인된 유저의 이메일 표시
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.bold),
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
                  leading: const Icon(Icons.settings_outlined),
                  title: const Text('계정 관리'),
                  onTap: () {
                    print('계정 관리 클릭');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyAccount(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.calendar_month_outlined),
                  title: const Text('운동 캘린더 작성'),
                  onTap: () {
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
                  leading: const Icon(Icons.credit_score_rounded),
                  title: const Text('구독 정보 관리'),
                  onTap: () {
                    print('구독 정보 관리 클릭');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Subscription(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.payment),
                  title: const Text('챌린지 관리'),
                  onTap: () {
                    print('챌린지 관리 클릭');
                  },
                ),
                // 추가 항목들
                ListTile(
                  leading: const Icon(Icons.question_mark),
                  title: const Text('자주 묻는 질문'),
                  onTap: () {
                    print('자주 묻는 질문 클릭');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Frequencyquestion(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.headset_mic_outlined),
                  title: const Text('문의하기'),
                  onTap: () {
                    print('문의하기 클릭');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Question(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // "로그아웃" 버튼 (로그인 상태에 따라 활성화)
          user != null
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListTile(
                    leading: const Icon(Icons.exit_to_app), // 로그아웃 아이콘
                    title: const Text('로그아웃'),
                    onTap: () {
                      print('로그아웃 클릭');
                      // 로그아웃 시 유저 상태 리셋
                      ref.read(authProvider.notifier).state = null;

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    },
                  ),
                )
              : const SizedBox.shrink(), // 로그인되지 않은 상태에서는 아무것도 표시하지 않음
          // "로그인하기" 버튼 (로그인되지 않은 상태에서만 활성화)
          user == null
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListTile(
                    leading: const Icon(Icons.login), // 로그인 아이콘
                    title: const Text('로그인하기'),
                    onTap: () {
                      print('로그인하기 클릭');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                    },
                  ),
                )
              : const SizedBox.shrink(), // 로그인 상태에서는 로그인 버튼을 숨김
        ],
      ),
    );
  }
}
