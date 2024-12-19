import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_test/ai_questions_pt/exercise_submit.dart'; // 예시로 이동 페이지 임포트
import 'package:flutter_application_test/home/home.dart'; // 홈 페이지 임포트

// 부상 여부를 관리할 Notifier 클래스
class InjuryStatusNotifier extends StateNotifier<Map<String, bool>> {
  InjuryStatusNotifier() : super({});

  // 부상 부위 초기화
  void initializeInjuryStatus(List<String> bodyParts) {
    state = {
      for (var part in bodyParts) part: false, // 초기값을 false로 설정
    };
  }

  // 부상 부위 상태 토글
  void toggleInjuryStatus(String bodyPart) {
    state = {
      ...state,
      bodyPart: !(state[bodyPart] ?? false), // null이 아니면 토글
    };
  }
}

// 부상 상태를 관리하는 Provider
final injuryStatusProvider =
    StateNotifierProvider<InjuryStatusNotifier, Map<String, bool>>(
  (ref) => InjuryStatusNotifier(),
);

class InjuryPage extends ConsumerWidget {
  const InjuryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 부상 상태 가져오기
    final injuryStatus = ref.watch(injuryStatusProvider);

    // 부상 부위 목록
    final List<String> bodyParts = [
      '어깨',
      '팔꿈치',
      '손목',
      '허리',
      '무릎',
      '발목',
      '발',
      '없음',
    ];

    // 부상 상태 초기화
    ref.listen(injuryStatusProvider, (_, state) {
      if (state.isEmpty) {
        ref
            .read(injuryStatusProvider.notifier)
            .initializeInjuryStatus(bodyParts);
      }
    });

    // "다음" 버튼 클릭 시 실행되는 함수 (AI 서버로 데이터 전송)
    void onNext() {
      if (injuryStatus.values.contains(true)) {
        // 부상 부위가 선택되었으면 AI 서버로 데이터 전송
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ExerciseAbilityPage(),
          ),
        );
      } else {
        // 부상 부위가 선택되지 않으면 경고
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("부상 부위를 선택해주세요"),
              content: const Text("부상 부위를 하나 이상 선택한 후 진행해주세요."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 다이얼로그 닫기
                  },
                  child: const Text("확인"),
                ),
              ],
            );
          },
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("부상 여부"),
        backgroundColor: const Color.fromARGB(255, 255, 111, 97),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Homepage(),
                ),
              );
            },
            child: const Text(
              "다음에 이용하기",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "부상을 입은 부위를 선택해주세요. (복수 선택 가능)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Wrap을 사용하여 버튼을 두 개씩 배치
            Wrap(
              spacing: 16, // 가로 간격
              runSpacing: 16, // 세로 간격
              children: bodyParts.map((bodyPart) {
                return SizedBox(
                  height: 60, // 버튼 높이 설정
                  width:
                      (MediaQuery.of(context).size.width - 48) / 2, // 두 개씩 배치
                  child: InkWell(
                    onTap: () {
                      // 부상 부위 상태를 토글
                      ref
                          .read(injuryStatusProvider.notifier)
                          .toggleInjuryStatus(bodyPart);
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        color: injuryStatus[bodyPart] == true
                            ? const Color.fromARGB(
                                255, 255, 111, 97) // 선택된 경우 색상
                            : Colors.white, // 선택되지 않은 경우 하얀색
                        borderRadius: BorderRadius.circular(12), // 둥근 모서리
                        boxShadow: injuryStatus[bodyPart] == true
                            ? [] // 선택된 상태에서는 그림자 없음
                            : [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10, // 흐림 정도
                                  offset: Offset(0, 10), // 그림자 방향
                                ),
                              ],
                      ),
                      child: Center(
                        child: Text(
                          bodyPart,
                          style: TextStyle(
                            color: injuryStatus[bodyPart] == true
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onNext,
        backgroundColor: const Color.fromARGB(255, 255, 111, 97),
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
