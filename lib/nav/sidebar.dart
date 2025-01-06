import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/ai_service/subscription.dart';
import 'package:flutter_application_test/ftp_service/ftp_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_test/auth/login.dart';
import 'package:flutter_application_test/home/calendar/my_calendar.dart';
import 'package:flutter_application_test/home/question/frequencyquestion.dart';
import 'package:flutter_application_test/home/question/question.dart';
import 'package:flutter_application_test/home/userinfo/my_account.dart';
import 'package:flutter_application_test/state_controller/loginProvider.dart';

class SideBar extends ConsumerWidget {
  SideBar({super.key});

  // 유저의 프로필 이미지를 가져오는 URL 생성
  String getProfileImageUrl(String userId) {
    const ftpBaseUrl = "http://222.112.27.120"; // FTP 서버 URL (HTTP로 접근 가능한 경우)
    final imageUrl = '$ftpBaseUrl/coachly/profile/user_$userId.jpg';
    return imageUrl;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 로그인된 유저 정보 가져오기
    final user = ref.watch(authProvider);

    // user가 null이 아닐 경우에만 프로필 이미지를 가져옴
    if (user == null) {
      return Center(child: CircularProgressIndicator());
    }

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
                // FutureBuilder로 비동기적으로 이미지를 로드
                ClipOval(
                  child: Image.network(
                    getProfileImageUrl(user.userId), // FTP 서버에서 가져오는 URL을 사용
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover, // 이미지가 원형에 맞게 잘리도록
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage('assets/image.png'), // 로딩 중일 때 기본 이미지
                        );
                      }
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage('assets/image.png'), // 오류 발생 시 기본 이미지
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  user != null ? user.userName : '홍길동', // 로그인된 유저의 이름 표시
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
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
                ListTile(
                  leading: const Icon(Icons.question_mark),
                  title: const Text('자주 묻는 질문'),
                  onTap: () {
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
