import 'package:flutter/material.dart';

class ReportButton extends StatelessWidget {
  const ReportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // 모달 배경을 투명하게 설정
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10), // 상하 패딩
        decoration: BoxDecoration(
          color: Colors.transparent, // 버튼들만 보이도록
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // 버튼 크기에 맞게 자동 크기 조정
          children: [
            // 피드 신고하기 버튼
            ElevatedButton(
              onPressed: () {
                print('피드 신고하기');
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
              child: Text('피드 신고하기'),
            ),
            // 구분선 (Divider)
            Divider(
                color: Colors.black,
                height: 1,
                thickness: 1,
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
                height: 1,
                thickness: 1,
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
