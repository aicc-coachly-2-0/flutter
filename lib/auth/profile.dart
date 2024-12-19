import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/auth/signup_complete.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_test/state_controller/auth_controller.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  // 회원가입 버튼 클릭 시 실행할 로직을 onSubmit 함수로 분리
  void onSubmit(BuildContext context, WidgetRef ref) {
    final profileModel = ref.read(profileProvider);
    final authModel = ref.read(authControllerProvider);

    // 상태를 확인
    print('AuthController State: $authModel');
    print('ProfileController State: $profileModel');

    // 여기서 서버와의 연동 및 회원가입 로직을 추가할 수 있습니다.
    // 예시:
    // authService.register(authModel, profileModel);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const SignupCompleted(), // 임시로 FocusOnExercisePage로 이동
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
