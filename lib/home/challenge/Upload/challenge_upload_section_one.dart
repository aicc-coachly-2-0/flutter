// challenge_upload_page_one.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/state_controller/challenge_controoler.dart';
import 'package:image_picker/image_picker.dart'; // 이미지 업로드를 위해 필요
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChallengeUploadPageOne extends ConsumerStatefulWidget {
  const ChallengeUploadPageOne({super.key});

  @override
  _ChallengeUploadPageOneState createState() => _ChallengeUploadPageOneState();
}

class _ChallengeUploadPageOneState
    extends ConsumerState<ChallengeUploadPageOne> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController participantsController = TextEditingController();

  // 이미지 선택 함수
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      ref
          .read(challengeUploadProvider.notifier)
          .setImage(pickedFile.path); // 상태 업데이트
    }
  }

  @override
  Widget build(BuildContext context) {
    final challengeState = ref.watch(challengeUploadProvider);

    // 미션 제목, 참가 인원 상태 업데이트
    titleController.text = challengeState.missionTitle;
    participantsController.text = challengeState.participants.toString();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        // ListView 대신 Column으로 감싸서 문제를 해결
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 첫 번째 섹션 - 미션 제목
          ChallengeUploadSectionOne(
            controller: titleController,
            onChanged: (title) {
              ref.read(challengeUploadProvider.notifier).setMissionTitle(title);
            },
          ),
          const SizedBox(height: 20),
          // 두 번째 섹션 - 대표 사진 업로드
          ChallengeUploadSectionTwo(
            imageFile: challengeState.imagePath,
            onPickImage: pickImage,
          ),
          const SizedBox(height: 20),
          // 세 번째 섹션 - 참가 인원 설정
          ChallengeUploadSectionThree(
            controller: participantsController,
            onChanged: (value) {
              ref
                  .read(challengeUploadProvider.notifier)
                  .setParticipants(int.parse(value));
            },
          ),
        ],
      ),
    );
  }
}

// 첫 번째 섹션 - 미션 제목
class ChallengeUploadSectionOne extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const ChallengeUploadSectionOne({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '미션 제목',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          onChanged: onChanged, // 상태 업데이트
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: '미션 제목을 입력하세요.',
          ),
        ),
      ],
    );
  }
}

// 두 번째 섹션 - 대표 사진 업로드
class ChallengeUploadSectionTwo extends StatelessWidget {
  final String? imageFile;
  final VoidCallback onPickImage;

  const ChallengeUploadSectionTwo({
    super.key,
    required this.imageFile,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '대표 사진',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onPickImage,
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            child: imageFile == null
                ? const Center(
                    child: Icon(Icons.add, size: 40, color: Colors.grey),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(imageFile!),
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '사진을 업로드해주세요.',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }
}

// 세 번째 섹션 - 참가 인원 설정
class ChallengeUploadSectionThree extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const ChallengeUploadSectionThree({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '참가 인원 설정',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          onChanged: onChanged, // 상태 업데이트
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: '참가 인원 수를 입력하세요.',
          ),
        ),
      ],
    );
  }
}
