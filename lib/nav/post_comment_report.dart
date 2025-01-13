import 'package:flutter/material.dart';
import 'package:flutter_application_test/state_controller/loginProvider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostCommentReportButton extends ConsumerWidget {
  final Map<String, dynamic> comment; // 댓글 정보를 받아옴

  const PostCommentReportButton({
    super.key,
    required this.comment, // 댓글 정보
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // authProvider를 통해 로그인된 유저 정보를 가져옴
    final user = ref.read(authProvider); // 로그인된 사용자 정보를 가져옴

    if (user == null) {
      // 로그인되지 않은 경우
      return Center(child: Text("로그인 정보가 없습니다."));
    }

    final userNumber = user.userNumber; // userNumber 추출

    return Material(
      color: Colors.transparent, // 모달 배경을 투명하게 설정
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10), // 상하 패딩
        decoration: BoxDecoration(
          color: Colors.transparent, // 버튼들만 보이도록
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // 버튼 크기에 맞게 자동 크기 조정
          children: [
            // 댓글 신고하기 버튼
            ElevatedButton(
              onPressed: () async {
                // 신고 데이터를 준비
                final reportData = {
                  'user_number': userNumber, // 신고하는 유저의 번호
                  'target_id': comment['postCommentNumber'], // 신고 대상 댓글의 ID
                  'report_reason': comment['content'], // 신고 사유: 댓글 내용
                };

                try {
                  // 엔드포인트에서 domain을 URL 파라미터로 포함하고, body에도 domain을 포함
                  const domain =
                      'post_comment'; // 'comment'가 domain으로 고정되어 있다고 가정
                  final response = await http.post(
                    Uri.parse(
                        '${dotenv.env['API_BASE_URL']}/reports/$domain'), // domain을 URL에 파라미터로 추가
                    headers: {
                      'Content-Type': 'application/json',
                    },
                    body: json.encode({
                      ...reportData,
                      'domain': domain, // 바디에 domain도 추가
                    }),
                  );

                  if (response.statusCode == 201) {
                    // 신고가 성공적으로 처리되면
                    print('댓글 신고가 성공적으로 처리되었습니다.');
                    Navigator.pop(context); // 신고 후 바텀 시트 닫기
                  } else {
                    print('댓글 신고 처리에 실패했습니다.');
                  }
                } catch (e) {
                  print('댓글 신고 요청 중 오류가 발생했습니다: $e');
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.red, // 글자 색을 빨간색으로 설정
                backgroundColor: Colors.white, // 배경 투명
                side: BorderSide.none, // 테두리 제거
                minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 50),
                elevation: 0, // 그림자 제거
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10), // 위쪽 왼쪽 모서리 둥글게
                    topRight: Radius.circular(10), // 위쪽 오른쪽 모서리 둥글게
                    bottomLeft: Radius.zero, // 아래 왼쪽 모서리 각지게
                    bottomRight: Radius.zero, // 아래 오른쪽 모서리 각지게
                  ),
                ),
              ),
              child: Text('댓글 신고하기'),
            ),
            // 구분선 (Divider)
            Divider(
                color: Colors.black,
                height: 0.2,
                thickness: 0.2,
                indent: 20,
                endIndent: 20),

            // 유저 신고하기 버튼
            ElevatedButton(
              onPressed: () {
                print('유저 신고하기');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.red, // 글자 색을 빨간색으로 설정
                backgroundColor: Colors.white, // 배경 투명
                side: BorderSide.none, // 테두리 제거
                minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 50),
                elevation: 0, // 그림자 제거
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // 각진 버튼
                ),
              ),
              child: Text('유저 신고하기'),
            ),
            // 구분선 (Divider)
            Divider(
                color: Colors.black,
                height: 0.2,
                thickness: 0.2,
                indent: 20,
                endIndent: 20),

            // 유저 차단하기 버튼
            ElevatedButton(
              onPressed: () {
                print('유저 차단하기');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.red, // 글자 색을 빨간색으로 설정
                backgroundColor: Colors.white, // 배경 투명
                side: BorderSide.none, // 테두리 제거
                minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 50),
                elevation: 0, // 그림자 제거
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10), // 아래 왼쪽 모서리 둥글게
                    bottomRight: Radius.circular(10), // 아래 오른쪽 모서리 둥글게
                    topLeft: Radius.zero, // 위쪽 왼쪽 모서리 각지게
                    topRight: Radius.zero, // 위쪽 오른쪽 모서리 각지게
                  ),
                ),
              ),
              child: Text('유저 차단하기'),
            ),
            SizedBox(height: 15), // 투명한 간격

            // 취소 버튼
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // 모달 닫기
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.red, // 글자 색을 빨간색으로 설정
                backgroundColor: Colors.white, // 배경 투명
                side: BorderSide.none, // 테두리 제거
                minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 50),
                elevation: 0, // 그림자 제거
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // 모서리 둥글게 처리
                ),
              ),
              child: Text('취소'),
            ),
            SizedBox(height: 15), // 투명한 간격
          ],
        ),
      ),
    );
  }
}
