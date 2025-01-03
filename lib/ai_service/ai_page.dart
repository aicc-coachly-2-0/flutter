import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/home.dart';
import 'package:flutter_application_test/home/payment/payment_agree.dart';
import 'package:flutter_application_test/state_controller/loginProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // 사이드바 추가

class AIPage extends ConsumerWidget {
  const AIPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('AI 서비스', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Homepage()),
              );
            },
            child: const Text(
              "다음에 이용하기",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Container(
        color: Color(0xFFFFF3F3),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 120),
            Text(
              'COACHLY',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'AI 서비스 구독하고\n지금 나에게 맞는 식단과 운동 추천 받기',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(height: 20),
            Text(
              '₩9,900 / month',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentAgree(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text('AI 서비스 구독',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            SizedBox(height: 10),
            Text(
              '구독 시 7일 무료 체험 제공',
              style: TextStyle(fontSize: 14, color: Colors.black45),
            ),
            SizedBox(height: 30),
            Expanded(
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, // Distribute cards evenly
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Align cards to the center
                children: [
                  Expanded(
                    child: FeatureCard(
                      icon: Icons.restaurant,
                      title: 'AI를 통한 식단 관리 받기',
                      description: '당신의 건강을 위한 스마트한 선택, AI 식단 관리로 시작하세요!',
                    ),
                  ),
                  SizedBox(width: 9), // Add spacing between the two cards
                  Expanded(
                    child: FeatureCard(
                      icon: Icons.fitness_center,
                      title: 'AI를 통한 운동 루틴 추천받기',
                      description: '효율적인 운동, AI의 똑똑한 루틴으로 시작하세요!',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  FeatureCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.description});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.pink[100],
          child: Icon(icon, size: 40, color: Colors.pink),
        ),
        SizedBox(height: 10),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }
}
