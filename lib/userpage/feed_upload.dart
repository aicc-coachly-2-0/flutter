import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/state_controller/loginProvider.dart';
import 'package:flutter_application_test/state_controller/user_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_test/userpage/gallery.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FeedUpload extends ConsumerWidget {
  const FeedUpload({super.key});

  // POST 요청을 위한 메소드
  Future<void> _submitFeed(WidgetRef ref, BuildContext context) async {
    final feedState = ref.read(feedUploadProvider); // 상태 관리 읽기
    final user = ref.read(authProvider); // 사용자 정보 읽기 (userNumber 포함)

    if (feedState.imagePath == null || feedState.description.isEmpty) {
      // 이미지나 내용이 없으면 알림
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('이미지와 내용을 모두 입력해주세요')),
      );
      return;
    }

    if (user == null || user.userNumber == null) {
      // user 또는 userNumber가 null인 경우 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('사용자 정보를 찾을 수 없습니다.')),
      );
      return;
    }

    // 서버 URL 설정
    final url = Uri.parse('${dotenv.env['API_BASE_URL']}/feeds');

    // 이미지 파일 전송 및 userNumber, userId, imageType 전달
    final request = http.MultipartRequest('POST', url)
      ..fields['user_number'] = user.userNumber.toString() // 사용자 번호
      ..fields['user_id'] = user.userId.toString() // 사용자 ID
      ..fields['content'] = feedState.description // 내용
      ..fields['imageType'] = 'feed' // imageType을 feed로 설정
      ..files.add(await http.MultipartFile.fromPath(
          'feedPicture', feedState.imagePath!)); // 이미지 파일

    try {
      final response = await request.send();
      if (response.statusCode == 201) {
        // 성공적으로 업로드되었으면 피드를 화면에서 초기화
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('피드가 성공적으로 업로드되었습니다')),
        );
        ref.read(feedUploadProvider.notifier).resetImage();
        ref.read(feedUploadProvider.notifier).resetDescription();
        Navigator.pop(context); // 업로드 후 뒤로 가기
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('업로드 실패. 다시 시도해주세요')),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('서버와의 연결에 문제가 발생했습니다')),
      );
    }
  }

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
            ref.read(feedUploadProvider.notifier).resetImage();
            ref.read(feedUploadProvider.notifier).resetDescription();
            Navigator.pop(context); // 뒤로가기
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 이미지 선택 박스
              Container(
                width: double.infinity,
                height: 300,
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

              // 내용 입력 (텍스트 필드)
              if (feedState.isImageSelected) ...[
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
                    onPressed: () => _submitFeed(ref, context),
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
