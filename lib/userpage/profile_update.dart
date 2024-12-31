import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/state_controller/profile_update_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUpdate extends ConsumerWidget {
  const ProfileUpdate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 상태 관리
    final profileState = ref.watch(profileUpdateProvider); // 상태 가져오기
    final profileNotifier =
        ref.read(profileUpdateProvider.notifier); // 상태 변경을 위한 notifier

    // 프로필 사진 선택
    Future<void> pickProfileImage() async {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        profileNotifier.setProfileImage(pickedFile.path); // 이미지 경로 업데이트
      }
    }

    // 닉네임 입력 텍스트 변경
    void updateNickname(String text) {
      profileNotifier.setNickname(text);
      profileNotifier.validateNickname(); // 닉네임 유효성 검사
    }

    // 자기소개 입력 텍스트 변경
    void updateBio(String text) {
      profileNotifier.setBio(text);
    }

    // 완료 버튼 클릭
    void onSubmit() {
      if (profileState.isNicknameValid && profileState.bio.isNotEmpty) {
        // 프로필 업데이트 로직을 처리할 수 있습니다.
        print('프로필 업데이트 완료');
      } else {
        // 입력 오류 시 메시지 표시
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('모든 정보를 입력해 주세요.')),
        );
      }
    }

    // 상태 리셋
    void resetForm() {
      profileNotifier.resetState();
    }

    return Scaffold(
      appBar: AppBar(title: const Text("프로필 업데이트")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 프로필 사진
            Center(
              child: GestureDetector(
                onTap: pickProfileImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: profileState.profileImagePath != null
                      ? FileImage(File(profileState.profileImagePath!))
                      : null,
                  child: profileState.profileImagePath == null
                      ? Icon(Icons.camera_alt,
                          size: 30, color: Colors.grey[700])
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 닉네임 입력란
            TextField(
              controller: TextEditingController(text: profileState.nickname),
              onChanged: updateNickname,
              decoration: InputDecoration(
                labelText: '닉네임',
                suffixIcon: Icon(
                  profileState.isNicknameValid ? Icons.check : Icons.clear,
                  color:
                      profileState.isNicknameValid ? Colors.green : Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 자기소개 입력란
            TextField(
              controller: TextEditingController(text: profileState.bio),
              onChanged: updateBio,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: '자기소개',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // 완료 버튼
            Center(
              child: ElevatedButton(
                onPressed: onSubmit,
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      Size(MediaQuery.of(context).size.width * 0.9, 50),
                  backgroundColor: const Color(0xFFFF6F61), // 강조 색상
                ),
                child: const Text(
                  "완료",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 리셋 버튼
          ],
        ),
      ),
    );
  }
}
