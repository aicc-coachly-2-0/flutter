import 'package:flutter/material.dart';
import 'package:flutter_application_test/state_controller/ai_answer_cotroller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_test/ai_questions_food/agree.dart'; // 식단 페이지

class DietSection extends StatefulWidget {
  const DietSection({super.key});

  @override
  _DietSectionState createState() => _DietSectionState();
}

class _DietSectionState extends State<DietSection> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        // AiDietAnswersNotifier를 사용하여 상태값을 불러옴
        final aiDietAnswers = ref.watch(aiDietAnswersProvider);
        final aiDietAnswerNotifier = ref.read(aiDietAnswersProvider.notifier);

        // 식단 정보 가져오기
        String mealInfo = '';

        // 버튼에 따라 아침, 점심, 저녁, 간식 중 선택된 부분만 가져옴
        if (selectedIndex == 0) {
          mealInfo = aiDietAnswerNotifier
              .getMealPart('아침')
              .replaceAll("**", "")
              .split('주의')[0]; // "주의" 이후는 제외
        } else if (selectedIndex == 1) {
          mealInfo = aiDietAnswerNotifier
              .getMealPart('점심')
              .replaceAll("**", "")
              .split('주의')[0]; // "주의" 이후는 제외
        } else if (selectedIndex == 2) {
          mealInfo = aiDietAnswerNotifier
              .getMealPart('저녁')
              .replaceAll("**", "")
              .split('주의')[0]; // "주의" 이후는 제외
        } else if (selectedIndex == 3) {
          mealInfo = aiDietAnswerNotifier
              .getMealPart('간식')
              .replaceAll("**", "")
              .split('주의')[0]; // "주의" 이후는 제외
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '식단 추천 내역 확인하기',
              style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 179, 179, 179),
              ),
            ),
            Row(
              children: [
                Text(
                  '내 식단 추천',
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
                        builder: (context) => const DietStartPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const Divider(thickness: 0.4, color: Color.fromARGB(255, 0, 0, 0)),
            const SizedBox(height: 10),

            // 식단이 없으면 문구, 있으면 버튼들 보여주기
            if (aiDietAnswers.isEmpty)
              Text(
                '아직 식단 추천 내역이 없어요',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              )
            else
              Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMealButton('아침', 0),
                      _buildMealButton('점심', 1),
                      _buildMealButton('저녁', 2),
                      _buildMealButton('간식', 3),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (mealInfo.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        mealInfo,
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

  Widget _buildMealButton(String title, int index) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = isSelected ? -1 : index; // 이미 선택된 버튼은 취소
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
        ),
      ),
    );
  }
}
