import 'package:flutter/material.dart';
import 'package:flutter_application_test/state_controller/challenge_controoler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ChallengUploadPageThree extends ConsumerWidget {
  const ChallengUploadPageThree({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challengeState = ref.watch(challengeUploadProvider);
    final challengeNotifier = ref.read(challengeUploadProvider.notifier);

    // 내가 제공한 컬러 값 (예시: 색상값을 그대로 사용)
    final customColor = Color(0xFFFF6F61); // 예시로 selectedColor 사용

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 미션 시작일 섹션
          _buildMissionStartDateSection(
              challengeState, challengeNotifier, context),

          const SizedBox(height: 20),

          // 미션 설명 섹션
          _buildMissionDescriptionSection(challengeState, challengeNotifier),

          const SizedBox(height: 20),

          // 포인트 지급 안내 섹션
          _buildPointsSection(challengeState, customColor),

          const SizedBox(height: 20),

          // 최종 지급포인트 안내 문구
          _buildFinalPointsInfo(),
        ],
      ),
    );
  }

  // 미션 시작일 섹션
  Widget _buildMissionStartDateSection(ChallengeUploadState challengeState,
      ChallengeUploadNotifier challengeNotifier, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '미션 시작일',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: challengeState.missionStartDate ?? DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2100),
            );
            if (selectedDate != null) {
              challengeNotifier.setMissionStartDate(selectedDate);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              challengeState.missionStartDate != null
                  ? DateFormat('yyyy-MM-dd')
                      .format(challengeState.missionStartDate!)
                  : '날짜 선택하기',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  // 미션 설명 섙션
  Widget _buildMissionDescriptionSection(ChallengeUploadState challengeState,
      ChallengeUploadNotifier challengeNotifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '미션 설명',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          onChanged: (text) {
            challengeNotifier.setMissionDescription(text);
          },
          decoration: InputDecoration(
            hintText: '미션에 대한 설명을 입력하세요.',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
          maxLines: 4,
          minLines: 3,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }

  // 포인트 지급 안내 섹션
  Widget _buildPointsSection(
      ChallengeUploadState challengeState, Color customColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '포인트 지급',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝으로 떨어뜨리기
              children: [
                Text('100% 완주 시 받는 포인트'),
                Text(
                  '${challengeState.pointsFor100Percent}P',
                  style: TextStyle(
                    color: customColor, // 제공된 컬러로 색상 변경
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8), // 각 Row 간에 간격 추가
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝으로 떨어뜨리기
              children: [
                Text('80% 완주 시 받는 포인트'),
                Text(
                  '${challengeState.pointsFor80Percent}P',
                  style: TextStyle(
                    color: customColor, // 제공된 컬러로 색상 변경
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8), // 각 Row 간에 간격 추가
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝으로 떨어뜨리기
              children: [
                Text('50% 완주 시 받는 포인트'),
                Text(
                  '${challengeState.pointsFor50Percent}P',
                  style: TextStyle(
                    color: customColor, // 제공된 컬러로 색상 변경
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // 최종 지급포인트 안내 문구
  Widget _buildFinalPointsInfo() {
    return const Text(
      '최종 지급포인트는 미션 설정과 달성률에 따라 달라집니다.',
      style: TextStyle(fontSize: 14, color: Colors.grey),
    );
  }
}
