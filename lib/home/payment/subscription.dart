import 'package:flutter/material.dart';
import 'package:flutter_application_test/ai_service/ai_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_test/home/payment/subscriptionList.dart';
import 'package:flutter_application_test/state_controller/loginProvider.dart';

class Subscription extends ConsumerWidget {
  const Subscription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 로그인된 사용자 정보 가져오기
    final user = ref.watch(authProvider);

    // 로그인된 사용자가 없으면 경고 메시지 표시
    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('구독 정보 관리'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('로그인한 사용자가 없습니다.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('구독 정보 관리'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '내 구독 관리',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('내 결제 정보'),
              onTap: () {
                // userNumber를 넘기기
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubscriptionList(
                      userNumber: user.userNumber, // userNumber를 넘김
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text(
                'AI 서비스 구독하기',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              subtitle: const Text(
                '코치리의 AI 서비스로 균형 잡힌 식단과 나에게 맞는 운동 루틴을 추천받고 더욱 건강한 헬스 생활을 즐겨보세요.',
                style: TextStyle(fontSize: 14),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // AI 서비스 페이지로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AIPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
