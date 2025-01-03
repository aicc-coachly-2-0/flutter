import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/auth/signup_complete.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_test/state_controller/auth_controller.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  // void getEnv() async {
  //   await dotenv.load();
  //   String? baseUrl = dotenv.get('API_BASE_URL');
  // }

  // 서버로 POST 요청을 보내는 함수
  Future<void> sendSignupData(Map<String, dynamic> signupData) async {
    final url = Uri.parse('${dotenv.env['API_BASE_URL']}/auth/signup');

    // 요청 헤더 설정 (multipart/form-data는 자동으로 boundary를 설정)
    final request = http.MultipartRequest('POST', url);

    // 서버로 전송할 텍스트 데이터 추가
    request.fields['user_id'] = signupData['user_id'];
    request.fields['user_pw'] = signupData['user_pw'];
    request.fields['user_email'] = signupData['user_email'];
    request.fields['user_name'] = signupData['user_name'];
    request.fields['user_phone'] = signupData['user_phone'];
    request.fields['user_date_of_birth'] = signupData['user_date_of_birth'];
    request.fields['user_gender'] = signupData['user_gender'];
    request.fields['nickname'] = signupData['nickname'];

    // 프로필 이미지 파일을 서버에 추가
    final profileImagePath = signupData['profile_picture'];
    if (profileImagePath != null) {
      final file = File(profileImagePath);
      final fileBytes = await file.readAsBytes();

      // 확장자를 확인하여 MediaType 설정
      String fileExtension = profileImagePath.split('.').last.toLowerCase();
      MediaType mediaType;

      switch (fileExtension) {
        case 'jpg':
        case 'jpeg':
          mediaType = MediaType('image', 'jpeg');
          break;
        case 'png':
          mediaType = MediaType('image', 'png');
          break;
        default:
          mediaType =
              MediaType('application', 'octet-stream'); // 기본적으로 바이너리 파일 처리
          break;
      }

      final multipartFile = http.MultipartFile.fromBytes(
        'profilePicture', // 서버에서 받는 파일 필드명
        fileBytes,
        filename: profileImagePath.split('/').last, // 파일 이름
        contentType: mediaType, // 적절한 미디어 타입
      );
      request.files.add(multipartFile);
    }

    try {
      // 요청 보내기
      final response = await request.send();

      // 응답 처리
      if (response.statusCode == 200) {
        print('회원가입 성공');
      } else {
        print('회원가입 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('서버와의 연결에 실패했습니다: $e');
    }
  }

  void onSubmit(BuildContext context, WidgetRef ref) async {
    final profileModel = ref.read(profileProvider); // 프로필 정보 가져오기
    final authModel = ref.read(authControllerProvider); // 인증 정보 가져오기

    // 성별 변환 (한국어 -> 영어)
    String gender = profileModel.gender == '남성' ? 'male' : 'female';

    // authModel과 profileModel을 하나로 묶어서 서버에 전송할 객체 만들기
    final signupData = {
      'user_id': authModel['loginId'],
      'user_pw': authModel['password'],
      'user_email': authModel['email'],
      'user_name': authModel['name'],
      'user_phone': authModel['phoneNumber'],
      'user_date_of_birth':
          profileModel.birthDate?.toIso8601String(), // ISO 8601 문자열로 변환
      'user_gender': gender, // 변환된 성별 값
      'profile_picture': profileModel.profileImagePath, // 파일 경로
      'nickname': profileModel.nickname,
    };

    print('서버로 보내는 데이터: $signupData');

    // 서버로 데이터를 보내는 함수 호출
    await sendSignupData(signupData);

    // 서버와의 연동 후 화면 이동
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignupCompleted(), // 임시로 화면 전환
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileModel = ref.watch(profileProvider);
    final authModel = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필 설정'),
        backgroundColor: const Color.fromARGB(255, 255, 111, 97),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
          children: [
            // JOIN US는 왼쪽 정렬
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'JOIN US',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // 프로필 설정도 왼쪽 정렬
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '프로필 설정',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // 프로필 이미지 선택 부분은 가운데 정렬
            Center(
              child: GestureDetector(
                onTap: () async {
                  await ref.read(profileProvider.notifier).pickProfileImage();
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: profileModel.profileImagePath != null
                      ? FileImage(File(profileModel.profileImagePath!))
                      : null,
                  backgroundColor: Colors.grey[300],
                  child: profileModel.profileImagePath == null
                      ? const Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // 닉네임 입력
            TextFormField(
              initialValue: profileModel.nickname,
              decoration: const InputDecoration(
                labelText: '닉네임',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                ref.read(profileProvider.notifier).setNickname(value);
              },
            ),
            const SizedBox(height: 16.0),

            // 생일 선택 (DatePicker 사용)
            GestureDetector(
              onTap: () async {
                // 날짜 선택하기
                final DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: profileModel.birthDate ?? DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (selectedDate != null &&
                    selectedDate != profileModel.birthDate) {
                  ref.read(profileProvider.notifier).setBirthDate(selectedDate);
                }
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: TextEditingController(
                    text: profileModel.birthDate != null
                        ? profileModel.birthDate!
                            .toLocal()
                            .toString()
                            .split(' ')[0]
                        : '',
                  ),
                  decoration: const InputDecoration(
                    labelText: '생일',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // 성별 선택
            const Text(
              '성별',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GenderButton(
                  label: '남성',
                  isSelected: profileModel.gender == '남성', // 선택된 성별
                  onTap: () {
                    ref.read(profileProvider.notifier).setGender('남성');
                  },
                ),
                const SizedBox(width: 16.0),
                GenderButton(
                  label: '여성',
                  isSelected: profileModel.gender == '여성', // 선택된 성별
                  onTap: () {
                    ref.read(profileProvider.notifier).setGender('여성');
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // 회원가입 버튼
            SizedBox(
              width: double.infinity, // 화면 너비 전체를 차지
              child: ElevatedButton(
                onPressed: () => onSubmit(context, ref),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 111, 97),
                ),
                child: const Text('회원가입'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GenderButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        backgroundColor: isSelected
            ? const Color.fromARGB(255, 255, 111, 97) // 선택된 버튼에 포인트 색상
            : Colors.white, // 기본 텍스트 색상
        side: BorderSide(
          color: isSelected
              ? const Color.fromARGB(255, 255, 111, 97) // 선택된 버튼에 포인트 색상
              : Colors.grey, // 기본 테두리 색상
          width: 1.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // 둥근 모서리
        ),
      ),
      child: Text(label), // 버튼에 표시할 텍스트
    );
  }
}
