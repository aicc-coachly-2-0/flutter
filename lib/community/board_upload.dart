import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/community/widgets/board_upload_form.dart';
import 'package:flutter_application_test/state_controller/comunity_controller.dart';
import 'package:flutter_application_test/state_controller/loginProvider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class BoardUpload extends ConsumerWidget {
  const BoardUpload({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(boardUploadProvider); // 상태 읽기
    final boardUploadNotifier = ref.read(boardUploadProvider.notifier); // 상태 수정
    final user = ref.watch(authProvider); // authProvider에서 유저 정보 가져오기

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
      ),
      body: BoardUploadForm(
        // 업로드 함수 콜백 전달
        onUpload: _uploadPost,
      ),
    );
  }

  // 게시물 업로드
  Future<void> _uploadPost(WidgetRef ref, BuildContext context,
      BoardUploadState state, User? user) async {
    if (state.selectedBoard.isEmpty ||
        state.title.isEmpty ||
        state.content.isEmpty ||
        state.imagePath == null ||
        user == null) {
      // 필수 값들이 비어 있으면 업로드 불가
      _showErrorDialog(context, "모든 필드를 채워주세요.");
      return;
    }

    // 커뮤니티 번호 매핑
    final Map<String, int> boardMapping = {
      '자유': 1,
      '익명': 2,
      '오운완': 3,
      '러닝': 4,
      '헬린이': 5,
      '식단': 6,
      '첼린지': 7,
    };

    final communityNumber = boardMapping[state.selectedBoard];

    // 유저 번호 추출
    final userNumber = user.userNumber;
    final userId = user.userId;

    // 요청 URL
    final url = Uri.parse('${dotenv.env['API_BASE_URL']}/posts');

    // 이미지 파일 읽기
    final imageFile = File(state.imagePath!);

    // MultipartRequest로 전송 준비
    var request = http.MultipartRequest('POST', url)
      ..fields['user_number'] = userNumber.toString()
      ..fields['user_id'] = userId.toString()
      ..fields['community_number'] = communityNumber.toString()
      ..fields['title'] = state.title
      ..fields['content'] = state.content
      ..fields['imageType'] = 'post' // imageType을 feed로 설정
      ..files.add(await http.MultipartFile.fromPath(
          'postPicture', imageFile.path)); // 이미지 파일 첨부

    try {
      final response = await request.send();

      if (response.statusCode == 201) {
        // 업로드 성공
        _showSuccessDialog(context);
        // 업로드 후 상태 초기화
        ref.read(boardUploadProvider.notifier).resetAll();
      } else {
        // 실패한 경우
        _showErrorDialog(context, '게시물 업로드에 실패했습니다.');
      }
    } catch (e) {
      _showErrorDialog(context, '서버와의 연결에 문제가 있습니다.');
    }
  }

  // 성공 다이얼로그
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('업로드 완료'),
        content: const Text('게시물이 성공적으로 업로드되었습니다.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // 다이얼로그 닫기
              Navigator.of(context).pop(); // 게시판 화면으로 돌아가기
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  // 에러 다이얼로그
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('업로드 실패'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // 다이얼로그 닫기
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}
