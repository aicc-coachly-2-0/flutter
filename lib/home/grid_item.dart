import 'package:flutter/material.dart';
import 'package:flutter_application_test/community/Anonymous/anonymous_board.dart';
import 'package:flutter_application_test/community/Beginner/beginner_fitness.dart';
import 'package:flutter_application_test/community/Diet/diet_plan.dart';
import 'package:flutter_application_test/community/Mission/fitness_challenge.dart';
import 'package:flutter_application_test/community/Free/free_community.dart';
import 'package:flutter_application_test/community/Running/running_board.dart';
import 'package:flutter_application_test/community/WorkoutComplete/workout_complete.dart';

class GridItem extends StatelessWidget {
  final List<String> boardList;
  final List<IconData> boardIcons;

  const GridItem({
    super.key,
    required this.boardList,
    required this.boardIcons,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int index = 0; index < boardList.length; index++)
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {
                    String boardName = boardList[index];
                    switch (boardName) {
                      case '자유':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FreeCommunity()),
                        );
                        break;
                      case '익명':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnonymousBoard()),
                        );
                        break;
                      case '오운완':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WorkoutComplete()),
                        );
                        break;
                      case '러닝':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RunningBoard()),
                        );
                        break;
                      case '헬린이':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BeginnerFitness()),
                        );
                        break;
                      case '식단':
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DietPlan()),
                        );
                        break;
                      case '첼린지':
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FitnessChallenge()),
                        );
                        break;
                      default:
                        break;
                    }
                  },
                  child: _buildItemContent(index),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemContent(int index) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              boardIcons[index],
              size: 40,
              color: Color.fromARGB(255, 255, 111, 97),
            ),
            const SizedBox(height: 10),
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
}
