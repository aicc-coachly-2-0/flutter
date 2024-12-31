import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/challenge/challenge_upload_section_three.dart';
import 'package:flutter_application_test/home/challenge/challenge_upload_section_one.dart'; // ChallengeUploadPageOne 임포트
import 'package:flutter_application_test/home/challenge/challenge_upload_section_two.dart'; // ChallengeUploadPageTwo 임포트
import 'package:flutter_application_test/state_controller/challenge_controoler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpod 임포트

class ChallengeUpload extends ConsumerWidget {
  const ChallengeUpload({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challengeState = ref.watch(challengeUploadProvider); // 상태값을 가져옵니다.
    final challengeNotifier =
        ref.read(challengeUploadProvider.notifier); // 상태 관리자

    // 미션 생성하기 버튼을 눌렀을 때의 처리
    void onCreateMission() {
      // 여기서 미션 생성 로직을 넣습니다.
      // 예시로 상태값들을 로그로 출력해보겠습니다.
      print('미션 제목: ${challengeState.missionTitle}');
      print('미션 사진: ${challengeState.imagePath}');
      print('미션 수행 기간: ${challengeState.selectedDuration}');
      print('인증 빈도: ${challengeState.selectedFrequency}');
      print('주간 인증 횟수: ${challengeState.weeklyCount}');
      print('미션 설명: ${challengeState.missionDescription}');
      print('100% 완주 시 포인트: ${challengeState.pointsFor100Percent}P');
      print('80% 완주 시 포인트: ${challengeState.pointsFor80Percent}P');
      print('50% 완주 시 포인트: ${challengeState.pointsFor50Percent}P');
      // 이 데이터를 서버로 전송하는 등의 로직을 추가할 수 있습니다.
    }

    // 뒤로가기 버튼을 눌렀을 때 상태 초기화 처리
    void onBack() {
      challengeNotifier.reset(); // 상태 초기화
      Navigator.pop(context); // 페이지 뒤로가기
    }

    return Scaffold(
      backgroundColor: Colors.white, // 배경색 설정
      appBar: AppBar(
        title: const Text('미션 생성'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack, // 뒤로가기 버튼
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // SingleChildScrollView로 감싸서 화면 넘침을 해결
          child: Column(
            children: [
              ChallengeUploadPageOne(), // 첫 번째 섹션 (미션 제목)
              const SizedBox(height: 10),
              ChallengeUploadPageTwo(), // 두 번째 섹션 (대표 사진 업로드)
              const SizedBox(height: 10),
              ChallengUploadPageThree(), // 세 번째 섹션 (미션 시작일, 설명, 포인트 등)
              const SizedBox(height: 20),
              // 미션 생성하기 버튼
              FractionallySizedBox(
                alignment: Alignment.center, // 버튼을 가운데 정렬
                widthFactor: 0.9, // 버튼의 가로 폭을 90%로 설정
                child: ElevatedButton(
                  onPressed: onCreateMission, // 미션 생성 버튼 클릭 시
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF6F61), // 버튼 색상
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20), // 버튼 패딩
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // 둥근 모서리
                    ),
                  ),
                  child: const Text(
                    '미션 생성하기',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
