import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/challenge/Upload/challenge_upload_section_three.dart';
import 'package:flutter_application_test/home/challenge/Upload/challenge_upload_section_one.dart';
import 'package:flutter_application_test/home/challenge/Upload/challenge_upload_section_two.dart';
import 'package:flutter_application_test/state_controller/challenge_controoler.dart';
import 'package:flutter_application_test/state_controller/loginProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http; // http 패키지 임포트
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart'; // dotenv 임포트

class ChallengeUpload extends ConsumerWidget {
  const ChallengeUpload({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challengeState = ref.watch(challengeUploadProvider); // 상태값을 가져옵니다.
    final challengeNotifier =
        ref.read(challengeUploadProvider.notifier); // 상태 관리자

    final user = ref.read(authProvider); // 로그인된 유저 정보
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('미션 생성')),
        body: const Center(child: Text('로그인 후 미션을 생성할 수 있습니다.')),
      );
    }

    Future<void> onCreateMission() async {
      try {
        final apiUrl = '${dotenv.env['API_BASE_URL']}/missions';

        // 시작일을 yyyy-MM-dd 형식으로 변환
        String formattedStartDate = '';
        if (challengeState.missionStartDate != null) {
          formattedStartDate =
              DateFormat('yyyy-MM-dd').format(challengeState.missionStartDate!);
        }

        // mission_level이 배열이라면 첫 번째 값만 사용
        String missionLevel = '';
        if (challengeState.selectedTasks.isNotEmpty) {
          missionLevel = challengeState.selectedTasks[0]; // 배열의 첫 번째 값을 사용
        }

        final missionData = {
          'title': challengeState.missionTitle,
          'mission_title':
              challengeState.selectedMissionType, // 숫자로 치환된 mission_title
          'duration': challengeState.selectedDuration,
          'content': challengeState.missionDescription,
          'selected_mission': missionLevel, // 배열이 아닌 단일 값으로 전달
          'weekly_cert_count': challengeState.weeklyCount,
          'cert_freq': challengeState.selectedFrequency,
          'started_at': formattedStartDate, // 시작일을 변환한 값으로 설정
          'user_id': user.userId.toString(), // int -> String 변환
          'user_number': user.userNumber.toString(), // int -> String 변환
          'imageType': 'mission',
        };
        print(missionData);

        // HTTP 요청 생성
        final request = http.Request('POST', Uri.parse(apiUrl))
          ..headers.addAll({
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${user.token}', // Authorization 헤더 추가
          })
          ..body =
              json.encode(missionData); // missionData를 JSON 형식으로 인코딩하여 body에 담기

        // 이미지가 있을 경우 처리 (MultipartRequest로 변경)
        if (challengeState.imagePath != null) {
          final requestMultipart = http.MultipartRequest(
              'POST', Uri.parse(apiUrl))
            ..headers.addAll({
              'Content-Type': 'multipart/form-data',
              'Authorization': 'Bearer ${user.token}', // Authorization 헤더 추가
            })
            ..fields.addAll(missionData
                .map((key, value) => MapEntry(key, value.toString())));

          // 이미지 파일을 추가
          final file = await http.MultipartFile.fromPath(
            'missionPicture', // 서버에서 받는 파일 이름에 맞게 수정
            challengeState.imagePath!,
            contentType: MediaType('image', 'jpeg'), // 파일 타입 지정
          );
          requestMultipart.files.add(file);

          // 서버로 multipart 요청 전송
          final response = await requestMultipart.send();

          if (response.statusCode == 201) {
            print('미션이 성공적으로 생성되었습니다!');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('미션이 성공적으로 생성되었습니다!')),
            );
            Navigator.pop(context); // 미션 생성 후 뒤로가기
          } else {
            print('미션 생성 실패: ${response.statusCode}');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('미션 생성 실패: ${response.statusCode}')),
            );
          }
        } else {
          // 이미지가 없는 경우 일반 POST 요청으로 보내기
          final response = await request.send();

          if (response.statusCode == 201) {
            print('미션이 성공적으로 생성되었습니다!');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('미션이 성공적으로 생성되었습니다!')),
            );
            Navigator.pop(context); // 미션 생성 후 뒤로가기
          } else {
            print('미션 생성 실패: ${response.statusCode}');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('미션 생성 실패: ${response.statusCode}')),
            );
          }
        }
      } catch (e) {
        print('미션 생성 중 오류 발생: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('미션 생성 중 오류가 발생했습니다.')),
        );
      }
    }

    // 뒤로가기 버튼을 눌렀을 때 상태 초기화 처리
    void onBack() {
      challengeNotifier.reset(); // 상태 초기화
      Navigator.pop(context); // 페이지 뒤로가기
    }

    return Scaffold(
      backgroundColor: Colors.white, // 배경색 설정
      appBar: AppBar(
        backgroundColor: Colors.white, // 배경색 설정
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
                    backgroundColor: const Color(0xFFFF6F61), // 버튼 색상
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
