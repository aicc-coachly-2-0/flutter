import 'package:flutter/material.dart';
import 'package:flutter_application_test/ai_questions_pt/agree.dart'; // 운동 페이지

class ExerciseSection extends StatelessWidget {
  const ExerciseSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 운동 루틴 내역 확인하기
        Text(
          '운동 루틴 내역 확인하기',
          style: TextStyle(
            fontSize: 15,
            color: Color.fromARGB(255, 179, 179, 179),
          ),
        ),
        // 내 운동 루틴 버튼
        Row(
          children: [
            Text(
              '내 운동 루틴',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.arrow_forward,
                  color: Color.fromARGB(255, 0, 0, 0)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExerciseStartPage(),
                  ),
                );
              },
            ),
          ],
        ),
        const Divider(thickness: 0.4, color: Color.fromARGB(255, 0, 0, 0)),

        // 아직 운동 루틴 내역이 없어요 문구
        const SizedBox(height: 10),
        Text(
          '아직 운동 루틴 내역이 없어요',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        const Divider(thickness: 0.4, color: Color.fromARGB(255, 0, 0, 0)),
      ],
    );
  }
}
