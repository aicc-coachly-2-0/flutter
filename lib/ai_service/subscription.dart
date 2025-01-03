import 'package:flutter/material.dart';
import 'package:flutter_application_test/ai_service/ai_page.dart';
import 'package:flutter_application_test/state_controller/loginProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Subscription extends ConsumerWidget {
  const Subscription({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 샘플 데이터
    final List<Map<String, dynamic>> activeSubscriptions = [
      {
        'title': 'AI 서비스 구독',
        'details': '₩1,000 / month\n결제일: 2024-12-21',
      },
    ];

    final List<Map<String, dynamic>> subscriptionHistory = [
      {
        'title': 'AI 서비스 과거 구독',
        'details': '₩1,000 / month\n종료일: 2024-11-21',
      },
    ];
    final user = ref.watch(authProvider);

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
              leading: const Icon(Icons.payment), // 아이콘 추가
              title: const Text('내 결제 정보'), // 텍스트
              onTap: () {
                // SubscriptionList로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubscriptionList(
                      activeSubscriptions: activeSubscriptions,
                      subscriptionHistory: subscriptionHistory,
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
                // 유저가 null이 아닐 경우 userName을 출력하도록 처리
                if (user != null) {
                  // print(user); // userName에 접근
                } else {
                  print("로그인되지 않았습니다.");
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AIPage(), // AI 서비스 구독 페이지로 이동
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

class SubscriptionList extends StatelessWidget {
  final List<Map<String, dynamic>> activeSubscriptions;
  final List<Map<String, dynamic>> subscriptionHistory;

  const SubscriptionList({
    super.key,
    required this.activeSubscriptions,
    required this.subscriptionHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('구독 목록'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('구독중'),
            const SizedBox(height: 8),
            _buildSubscriptionSection(activeSubscriptions, true),
            _buildSectionTitle('히스토리'),
            const SizedBox(height: 8),
            _buildSubscriptionSection(subscriptionHistory, false),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildSubscriptionSection(
      List<Map<String, dynamic>> subscriptions, bool canCancel) {
    if (subscriptions.isEmpty) {
      return const Center(
        child: Text(
          '목록이 비어 있습니다.',
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true, // 리스트 크기를 필요한 만큼만 사용
      physics: const NeverScrollableScrollPhysics(), // 리스트 자체 스크롤 비활성화
      itemCount: subscriptions.length,
      itemBuilder: (context, index) {
        final subscription = subscriptions[index];
        return ListTile(
          title: Text(
            subscription['title'] ?? '알 수 없는 서비스',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            subscription['details'] ?? '정보 없음',
            style: const TextStyle(fontSize: 14),
          ),
          trailing: canCancel
              ? TextButton(
                  onPressed: () {
                    // 구독 취소 로직
                    print('${subscription['title']} 구독 취소 클릭');
                  },
                  child: const Text(
                    '구독 취소',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              : null,
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const Subscription(),
  ));
}
