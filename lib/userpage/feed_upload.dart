import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/state_controller/user_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_test/userpage/gallery.dart';

class FeedUpload extends ConsumerWidget {
  const FeedUpload({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedState = ref.watch(feedUploadProvider); // 상태 관리 읽기

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('새 피드 업로드'),
        automaticallyImplyLeading: false, // 기본 뒤로가기 버튼 제거
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // 뒤로가기 버튼 눌렀을 때 상태 초기화
            ref.read(feedUploadProvider.notifier).resetImage(); // 상태 초기화
            ref.read(feedUploadProvider.notifier).resetTitle(); // 상태 초기화
            ref.read(feedUploadProvider.notifier).resetDescription(); // 상태 초기화
            Navigator.pop(context); // 뒤로가기
          },
        ),
      ),
      body: SingleChildScrollView(
        // 화면을 스크롤 가능하도록 감쌈
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 이미지 선택 박스
              Container(
                width: double.infinity,
                height: 300, // 박스 크기 키우기 (정사각형으로 설정)
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: feedState.isImageSelected
                    ? Image.file(
                        File(feedState.imagePath!),
                        fit: BoxFit.cover,
                      )
                    : Center(child: Text("이미지를 선택해주세요")),
              ),
              SizedBox(height: 20),

              // Gallery 컴포넌트 삽입 (앨범 이미지 선택)
              Gallery(onImagePicked: (image) {
                if (image != null) {
                  ref
                      .read(feedUploadProvider.notifier)
                      .setImage(image.path); // 이미지 경로 상태 업데이트
                }
              }),

              SizedBox(height: 20),

              // 제목 입력 (텍스트 필드)
              if (feedState.isImageSelected) ...[
                TextField(
                  onChanged: (value) {
                    ref
                        .read(feedUploadProvider.notifier)
                        .setTitle(value); // 제목 상태 업데이트
                  },
                  decoration: InputDecoration(
                    labelText: '제목을 입력하세요',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                // 내용 입력 (텍스트 필드)
                TextField(
                  onChanged: (value) {
                    ref
                        .read(feedUploadProvider.notifier)
                        .setDescription(value); // 내용 상태 업데이트
                  },
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: '내용을 입력하세요',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                // 확인 버튼
                SizedBox(
                  width: double.infinity, // 화면 전체 너비
                  height: 50, // 버튼 높이
                  child: ElevatedButton(
                    onPressed: () {
                      // 피드 제출 로직 (제목, 내용, 이미지 경로 출력)
                      print('제목: ${feedState.title}');
                      print('내용: ${feedState.description}');
                      print('선택된 이미지 경로: ${feedState.imagePath}');
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                            MediaQuery.of(context).size.width * 0.9,
                            50), // 버튼 너비 90%
                        backgroundColor: Color.fromARGB(255, 255, 111, 97)),
                    child: Text(
                      '확인',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
