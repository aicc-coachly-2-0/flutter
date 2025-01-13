import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_test/state_controller/loginProvider.dart'; // authProvider 가져오기

class BottomSheetImagePicker extends ConsumerStatefulWidget {
  final int roomNumber; // roomNumber를 int로 받음

  const BottomSheetImagePicker({required this.roomNumber, super.key});

  @override
  _BottomSheetImagePickerState createState() => _BottomSheetImagePickerState();
}

class _BottomSheetImagePickerState
    extends ConsumerState<BottomSheetImagePicker> {
  final ImagePicker _picker = ImagePicker();
  bool isUploading = false;
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    // ref.read를 사용하여 authProvider에서 user 정보 가져오기
    final user = ref.read(authProvider); // 여기서 user를 authProvider에서 읽어옵니다.

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '인증 이미지를 업로드하세요',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: () async {
              final pickedFile =
                  await _picker.pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                setState(() {
                  _imageFile = File(pickedFile.path);
                });
              }
            },
            child: _imageFile == null
                ? Container(
                    height: 300,
                    color: Colors.grey[300],
                    child: Center(
                        child: Icon(Icons.add_a_photo,
                            size: 50, color: Colors.white)),
                  )
                : Image.file(
                    _imageFile!,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
          ),
          SizedBox(height: 16),
          isUploading
              ? CircularProgressIndicator() // 업로드 중이면 로딩 표시
              : ElevatedButton(
                  onPressed: () async {
                    if (_imageFile == null) {
                      // 이미지가 선택되지 않았다면 경고 메시지
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("먼저 이미지를 선택하세요.")),
                      );
                      return;
                    }

                    setState(() {
                      isUploading = true;
                    });

                    final success = await _uploadImage(user); // user를 넘겨줌
                    setState(() {
                      isUploading = false;
                    });

                    if (success) {
                      Navigator.pop(context); // 업로드 성공하면 BottomSheet 닫기
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("업로드 실패. 다시 시도해 주세요.")),
                      );
                    }
                  },
                  child: Text('업로드'),
                ),
        ],
      ),
    );
  }

  Future<bool> _uploadImage(User? user) async {
    if (user == null) {
      return false;
    }

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://localhost:8080/missions/rooms/${widget.roomNumber}/validate/${user.userNumber}'),
      );

      // 헤더에 userToken 추가
      request.headers.addAll({
        'Authorization': 'Bearer ${user.token}', // 로그인한 사용자의 token을 사용
      });

      // Multipart 파일 추가 (선택된 이미지)
      request.files.add(await http.MultipartFile.fromPath(
        'missionConfirm', // 서버에서 받는 파일 파라미터 이름
        _imageFile!.path, // 선택한 이미지 파일 경로
      ));

      // 서버로 보내는 텍스트 파라미터 (Map 형식)
      final missionData = {
        'room_number': widget.roomNumber.toString(),
        'user_id': user.userId.toString(), // 사용자 ID
        'user_number': user.userNumber.toString(), // 사용자 번호
        'imageType': 'mission_confirm', // 이미지 타입 고정값
      };
      print(missionData);

      // Map의 텍스트 파라미터들을 request.fields에 추가
      missionData.forEach((key, value) {
        request.fields[key] = value;
      });

      // 서버에 요청 보내기
      final response = await request.send();

      if (response.statusCode == 201) {
        // 성공적으로 요청을 처리한 경우
        print('업로드 성공');
        return true;
      } else {
        // 실패한 경우
        print('업로드 실패: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // 예외 처리
      print('예외 발생: $e');
      return false;
    }
  }
}
