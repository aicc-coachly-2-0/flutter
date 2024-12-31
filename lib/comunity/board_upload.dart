import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_test/state_controller/comunity_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class BoardUpload extends ConsumerWidget {
  const BoardUpload({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(boardUploadProvider); // 상태 읽기
    final boardUploadNotifier = ref.read(boardUploadProvider.notifier); // 상태 수정

    return Scaffold(
      appBar: AppBar(
        title: const Text("게시판 업로드"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // 뒤로가기 시 상태 초기화
            boardUploadNotifier.resetAll();
            Navigator.of(context).pop(); // 이전 화면으로 돌아가기
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              print("게시판 업로드 완료");
              print("선택된 게시판: ${state.selectedBoard}");
              print("제목: ${state.title}");
              print("내용: ${state.content}");
              print("첨부된 이미지: ${state.imagePath}");
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("게시판 선택", style: TextStyle(fontSize: 18)),
              DropdownButton<String>(
                value: state.selectedBoard.isEmpty
                    ? null
                    : state.selectedBoard, // 초기값을 null로 설정
                hint: const Text("게시판을 선택하세요"),
                isExpanded: true,
                items: ['자유', '익명', '오운완', '러닝', '헬린이', '식단', '첼린지']
                    .map((board) => DropdownMenuItem(
                          value: board,
                          child: Text(board),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    boardUploadNotifier.setBoard(value);
                  }
                },
              ),
              const SizedBox(height: 20),
              const Text("제목", style: TextStyle(fontSize: 18)),
              TextField(
                onChanged: (value) => boardUploadNotifier.setTitle(value),
                decoration: const InputDecoration(hintText: "제목을 입력하세요"),
              ),
              const SizedBox(height: 20),
              const Text("내용", style: TextStyle(fontSize: 18)),
              TextField(
                maxLines: 5,
                onChanged: (value) => boardUploadNotifier.setContent(value),
                decoration: const InputDecoration(hintText: "내용을 입력하세요"),
              ),
              const SizedBox(height: 20),
              const Text("사진 첨부", style: TextStyle(fontSize: 18)),
              Row(
                children: [
                  state.isImageSelected
                      ? Image.file(
                          File(state.imagePath!),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        )
                      : const Text("이미지가 선택되지 않았습니다."),
                  IconButton(
                    icon: const Icon(Icons.add_a_photo),
                    onPressed: () => _pickImage(context, boardUploadNotifier),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    print("게시판 업로드 완료");
                    print("선택된 게시판: ${state.selectedBoard}");
                    print("제목: ${state.title}");
                    print("내용: ${state.content}");
                    print("첨부된 이미지: ${state.imagePath}");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 111, 97),
                  ),
                  child: const Text(
                    "완료",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 이미지 선택 갤러리 열기
  Future<void> _pickImage(
      BuildContext context, BoardUploadNotifier boardUploadNotifier) async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      boardUploadNotifier.setImage(pickedFile.path); // 선택한 이미지 경로 상태 업데이트
    }
  }
}
