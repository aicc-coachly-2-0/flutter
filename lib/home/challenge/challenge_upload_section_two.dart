import 'package:flutter/material.dart';
import 'package:flutter_application_test/state_controller/challenge_controoler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChallengeUploadPageTwo extends ConsumerWidget {
  const ChallengeUploadPageTwo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challengeState = ref.watch(challengeUploadProvider);
    final challengeNotifier = ref.read(challengeUploadProvider.notifier);

    return SingleChildScrollView(
      // SingleChildScrollView로 감싸서 스크롤 문제 해결
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // 미션 종류 선택
          const Text(
            '미션 종류',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            children:
                _buildMissionTypeButtons(challengeState, challengeNotifier),
          ),
          const SizedBox(height: 8),

          // 미션 종류별 선택 항목 표시
          if (challengeState.selectedMissionType.isNotEmpty)
            _MissionTasks(challengeState.selectedMissionType),
          const SizedBox(height: 8),

          // 미션 수행 기간
          const Text(
            '미션 수행 기간',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            children: _buildDurationButtons(challengeState, challengeNotifier),
          ),
          const SizedBox(height: 20),

          // 인증 빈도 선택
          if (challengeState.selectedDuration == '일주일' ||
              challengeState.selectedDuration == '한달' ||
              challengeState.selectedDuration == '하루' ||
              challengeState.selectedDuration == '3일')
            _FrequencySelection(
              selectedDuration: challengeState.selectedDuration,
              selectedFrequency: challengeState.selectedFrequency,
              onFrequencyChanged: (frequency) {
                challengeNotifier.setFrequency(frequency);
              },
            ),
          const SizedBox(height: 20),

          // 주간 인증 횟수 설정
          if (challengeState.selectedDuration == '일주일' ||
              challengeState.selectedDuration == '한달')
            _WeeklyCountSelection(
              currentCount: challengeState.weeklyCount, // 예시로 현재 선택된 인증 횟수
              onCountChanged: (int count) {
                challengeNotifier.setWeeklyCount(count); // 주간 인증 횟수 상태 업데이트
              },
            ),
        ],
      ),
    );
  }

  // 미션 종류 버튼을 리스트로 묶기
  List<Widget> _buildMissionTypeButtons(
    ChallengeUploadState challengeState,
    ChallengeUploadNotifier challengeNotifier,
  ) {
    const missionTypes = ['러닝', '걸음수', '운동', '식단'];

    return missionTypes.map((type) {
      return _MissionTypeButton(
        label: type,
        isSelected: challengeState.selectedMissionType == type,
        onPressed: () {
          challengeNotifier.setMissionType(type);
        },
      );
    }).toList();
  }

  // 미션 수행 기간 버튼을 리스트로 묶기
  List<Widget> _buildDurationButtons(
    ChallengeUploadState challengeState,
    ChallengeUploadNotifier challengeNotifier,
  ) {
    const durations = ['하루', '3일', '일주일', '한달'];

    return durations.map((duration) {
      return _DurationButton(
        label: duration,
        isSelected: challengeState.selectedDuration == duration,
        onPressed: () {
          challengeNotifier.setDuration(duration);
        },
      );
    }).toList();
  }
}

// 미션 종류 선택 버튼
class _MissionTypeButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const _MissionTypeButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFFFF6F61); // 주어진 컬러

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? borderColor : Colors.white,
        side: BorderSide(color: borderColor), // 테두리 색
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

// 미션 종류별 항목 표시
class _MissionTasks extends StatelessWidget {
  final String missionType;

  const _MissionTasks(this.missionType);

  @override
  Widget build(BuildContext context) {
    final taskList = _getTaskList(missionType);

    return Column(
      children: taskList.map((task) {
        return _TaskCheckboxList(task: task);
      }).toList(),
    );
  }

  // 미션 종류에 따른 할 일 리스트
  List<String> _getTaskList(String missionType) {
    switch (missionType) {
      case '러닝':
        return ['3km 뛰기', '5km 뛰기', '10km 뛰기'];
      case '걸음수':
        return ['3천보 걷기', '5천보 걷기', '1만보 걷기'];
      case '운동':
        return ['하루에 1번 운동하기'];
      case '식단':
        return ['하루 1끼 인증하기', '하루 2끼 인증하기', '하루 3끼 인증하기'];
      default:
        return [];
    }
  }
}

// 미션 항목 체크박스 리스트
class _TaskCheckboxList extends ConsumerWidget {
  final String task;

  const _TaskCheckboxList({required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challengeState = ref.watch(challengeUploadProvider);

    return CheckboxListTile(
      title: Text(task),
      value: challengeState.selectedTasks.contains(task),
      onChanged: (bool? value) {
        if (value != null) {
          ref.read(challengeUploadProvider.notifier).toggleTask(task);
        }
      },
    );
  }
}

// 미션 수행 기간 버튼
class _DurationButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const _DurationButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Color(0xFFFF6F61) : Colors.white,
        side: BorderSide(color: Color(0xFFFF6F61)), // 테두리 색
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)), // 버튼 둥글게
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

// 인증 빈도 선택
class _FrequencySelection extends StatelessWidget {
  final String selectedDuration; // 미션 수행 기간
  final String selectedFrequency;
  final ValueChanged<String> onFrequencyChanged;

  const _FrequencySelection({
    required this.selectedDuration,
    required this.selectedFrequency,
    required this.onFrequencyChanged,
  });

  @override
  Widget build(BuildContext context) {
    const frequencies = ['매일', '평일 매일', '주말 매일'];

    // 하루 또는 3일을 선택했을 때는 "매일"만 선택 가능
    final isFixedToDaily = selectedDuration == '하루' || selectedDuration == '3일';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '인증 빈도',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Row(
          children: frequencies.map((frequency) {
            return _FrequencyButton(
              label: frequency,
              isSelected: isFixedToDaily
                  ? frequency == '매일' // "매일"만 선택되게 고정
                  : selectedFrequency == frequency, // 다른 기간 선택 시 자유롭게 선택 가능
              onPressed: isFixedToDaily && frequency != '매일'
                  ? null // "매일"만 고정, 나머지 버튼은 비활성화
                  : () {
                      onFrequencyChanged(frequency);
                    },
            );
          }).toList(),
        ),
      ],
    );
  }
}

// 인증 빈도 버튼
class _FrequencyButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onPressed;

  const _FrequencyButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, // 선택 불가일 경우 onPressed는 null로 설정
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Color(0xFFFF6F61) : Colors.white,
        side: BorderSide(color: Color(0xFFFF6F61)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

// 주간 인증 횟수 선택 (숫자 박스 형식으로 변경)
class _WeeklyCountSelection extends StatefulWidget {
  final ValueChanged<int> onCountChanged;
  final int currentCount;

  const _WeeklyCountSelection({
    required this.onCountChanged,
    required this.currentCount,
  });

  @override
  _WeeklyCountSelectionState createState() => _WeeklyCountSelectionState();
}

class _WeeklyCountSelectionState extends State<_WeeklyCountSelection> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentCount.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '주간 인증 횟수',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        const Text(
          '주에 몇 회 인증할지 입력합니다. 최대 1회~7회 선택 가능합니다.',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            SizedBox(
              width: 80,
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  int newCount = int.tryParse(value) ?? widget.currentCount;
                  widget.onCountChanged(newCount);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xFFFF6F61)),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                int newCount =
                    widget.currentCount < 7 ? widget.currentCount + 1 : 7;
                _controller.text = newCount.toString();
                widget.onCountChanged(newCount);
              },
              icon: Icon(Icons.arrow_drop_up),
            ),
            IconButton(
              onPressed: () {
                int newCount =
                    widget.currentCount > 1 ? widget.currentCount - 1 : 1;
                _controller.text = newCount.toString();
                widget.onCountChanged(newCount);
              },
              icon: Icon(Icons.arrow_drop_down),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

// // 주간 인증 횟수 버튼
// class _WeeklyCountButton extends StatelessWidget {
//   final int count;
//   final bool isSelected;
//   final VoidCallback onPressed;

//   const _WeeklyCountButton({
//     required this.count,
//     required this.isSelected,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: isSelected ? Color(0xFFFF6F61) : Colors.white,
//         side: BorderSide(color: Color(0xFFFF6F61)), // 테두리 색
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//       child: Text(
//         '$count',
//         style: TextStyle(
//           color: isSelected ? Colors.white : Colors.black,
//         ),
//       ),
//     );
//   }
// }
