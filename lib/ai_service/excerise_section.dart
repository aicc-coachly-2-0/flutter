import 'package:flutter/material.dart';
import 'package:flutter_application_test/ai_questions_pt/agree.dart';
import 'package:flutter_application_test/state_controller/ai_answer_cotroller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_test/ai_questions_food/agree.dart'; // 운동 페이지

class ExerciseSection extends StatefulWidget {
  const ExerciseSection({super.key});

  @override
  _ExerciseSectionState createState() => _ExerciseSectionState();
}

class _ExerciseSectionState extends State<ExerciseSection> {
  int selectedIndex = -1; // 선택된 요일 인덱스

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        // AiExerciseAnswersNotifier를 사용하여 상태값을 불러옴
        final aiExerciseAnswers = ref.watch(aiExerciseAnswersProvider);
        final aiExerciseAnswerNotifier =
            ref.read(aiExerciseAnswersProvider.notifier);

        // 운동 루틴 정보 가져오기
        String exerciseInfo = '';

        // 버튼에 따라 월요일, 화요일, 수요일 등 선택된 요일만 가져옴
        if (selectedIndex == 0) {
          exerciseInfo = aiExerciseAnswerNotifier
              .getExercisePart('월요일')
              .replaceAll("**", "")
              .split('주의')[0]; // "주의" 이후는 제외
        } else if (selectedIndex == 1) {
          exerciseInfo = aiExerciseAnswerNotifier
              .getExercisePart('화요일')
              .replaceAll("**", "")
              .split('주의')[0]; // "주의" 이후는 제외
        } else if (selectedIndex == 2) {
          exerciseInfo = aiExerciseAnswerNotifier
              .getExercisePart('수요일')
              .replaceAll("**", "")
              .split('주의')[0]; // "주의" 이후는 제외
        } else if (selectedIndex == 3) {
          exerciseInfo = aiExerciseAnswerNotifier
              .getExercisePart('목요일')
              .replaceAll("**", "")
              .split('주의')[0]; // "주의" 이후는 제외
        } else if (selectedIndex == 4) {
          exerciseInfo = aiExerciseAnswerNotifier
              .getExercisePart('금요일')
              .replaceAll("**", "")
              .split('주의')[0]; // "주의" 이후는 제외
        } else if (selectedIndex == 5) {
          exerciseInfo = aiExerciseAnswerNotifier
              .getExercisePart('토요일')
              .replaceAll("**", "")
              .split('주의')[0]; // "주의" 이후는 제외
        } else if (selectedIndex == 6) {
          exerciseInfo = aiExerciseAnswerNotifier
              .getExercisePart('일요일')
              .replaceAll("**", "")
              .split('주의')[0]; // "주의" 이후는 제외
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '운동 루틴 내역 확인하기',
              style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 179, 179, 179),
              ),
            ),
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
            const SizedBox(height: 10),

            // 운동 루틴이 없으면 문구, 있으면 버튼들 보여주기
            if (aiExerciseAnswers.isEmpty)
              Text(
                '아직 운동 루틴 내역이 없어요',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              )
            else
              Column(
                children: [
                  const SizedBox(height: 20),
                  // 요일 버튼들을 한 줄에 배치
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDayButton('월요일', 0),
                      _buildDayButton('화요일', 1),
                      _buildDayButton('수요일', 2),
                      _buildDayButton('목요일', 3),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDayButton('금요일', 4),
                      _buildDayButton('토요일', 5),
                      _buildDayButton('일요일', 6),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (exerciseInfo.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        exerciseInfo,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  const SizedBox(height: 10),
                ],
              ),
            const Divider(thickness: 0.4, color: Color.fromARGB(255, 0, 0, 0)),
          ],
        );
      },
    );
  }

  // 요일별 운동 루틴 버튼
  Widget _buildDayButton(String title, int index) {
    bool isSelected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = isSelected ? -1 : index; // 이미 선택된 버튼은 취소
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? Color.fromARGB(255, 255, 111, 97) // 클릭된 버튼 색상
                : Colors.white, // 기본 배경 색상
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Color.fromARGB(255, 255, 111, 97), // 버튼 테두리 색상
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black, // 클릭된 버튼 텍스트 색상
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
