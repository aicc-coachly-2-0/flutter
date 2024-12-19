import 'package:flutter/material.dart';
import 'package:flutter_application_test/ai_questions_food/first_question.dart';
// import 'package:flutter_application_test/ai_questions/next.dart';
import 'package:flutter_application_test/home/home.dart'; // 홈 페이지만 임포트

class DietStartPage extends StatelessWidget {
  const DietStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("식단 관리 시작"),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "AI를 통해서 식단 관리를 생성하시겠습니까?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                print("좋아요! 진행할게요 버튼 클릭");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FirstQuestion(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color.fromARGB(255, 255, 255, 255), // 색상 변경
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text("좋아요! 진행할게요", style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // '괜찮습니다. 다음에 이용할게요' 버튼을 누르면 홈 화면으로 이동
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Homepage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color.fromARGB(255, 255, 255, 255), // 색상 변경
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text("괜찮습니다. 다음에 이용할게요",
                  style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
