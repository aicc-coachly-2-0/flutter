import 'package:flutter/material.dart';
import 'package:flutter_application_test/ai_service/excerise_section.dart';
import 'diet_section.dart'; // 식단 섹션

class AiServiceChoice extends StatelessWidget {
  const AiServiceChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
          children: [
            ExerciseSection(), // 운동 섹션
            const SizedBox(height: 20),
            DietSection(), // 식단 섹션
          ],
        ),
      ),
    );
  }
}
