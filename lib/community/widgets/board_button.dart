import 'package:flutter/material.dart';
import 'package:flutter_application_test/community/Anonymous/anonymous_board.dart';
import 'package:flutter_application_test/community/Beginner/beginner_fitness.dart';
import 'package:flutter_application_test/community/Diet/diet_plan.dart';
import 'package:flutter_application_test/community/Mission/fitness_challenge.dart';
import 'package:flutter_application_test/community/Free/free_community.dart';
import 'package:flutter_application_test/community/Running/running_board.dart';
import 'package:flutter_application_test/community/WorkoutComplete/workout_complete.dart';

class BoardButton extends StatelessWidget {
  final int index;

  const BoardButton({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final boardList = ['자유', '익명', '오운완', '러닝', '헬린이', '식단', '첼린지', '공지사항'];
    final boardIcons = [
      Icons.chat,
      Icons.person_outline,
      Icons.fitness_center,
      Icons.run_circle,
      Icons.health_and_safety,
      Icons.food_bank,
      Icons.golf_course_sharp,
      Icons.note_alt_rounded
    ];

    return GestureDetector(
      onTap: () {
        final route = _getRoute(boardList[index]);
        if (route != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => route),
          );
        }
      },
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              boardIcons[index],
              size: 30,
              color: const Color.fromARGB(255, 255, 111, 97),
            ),
            const SizedBox(height: 8),
            Text(
              boardList[index],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 게시판에 해당하는 라우트 반환
  Widget? _getRoute(String boardName) {
    switch (boardName) {
      case '자유':
        return const FreeCommunity();
      case '익명':
        return const AnonymousBoard();
      case '오운완':
        return const WorkoutComplete();
      case '러닝':
        return const RunningBoard();
      case '헬린이':
        return const BeginnerFitness();
      case '식단':
        return const DietPlan();
      case '첼린지':
        return const FitnessChallenge();
      default:
        return null;
    }
  }
}
