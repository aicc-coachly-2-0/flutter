import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/home.dart';

class ApplyComplete extends StatelessWidget {
  const ApplyComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('미션 참여 완료'),
        backgroundColor: Color.fromARGB(255, 255, 111, 97), // 앱바 색상
        automaticallyImplyLeading: false, // 뒤로가기 버튼
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 내용 가운데 배치
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 미션 참여 완료 메시지
            Text(
              '미션 참여가 완료되었습니다!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            SizedBox(height: 20), // 간격

            // 미션 이미지와 제목
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 미션 관련 이미지 (예시로 작은 이미지)
                Image.asset(
                  'assets/image.png', // 미션 관련 이미지
                  width: 50,
                  height: 50,
                ),
                SizedBox(width: 8), // 이미지와 텍스트 간격
                // 미션 제목
                Text(
                  '미션 이름', // 미션 이름
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),

            SizedBox(height: 20), // 간격

            // 완료 시 포인트 정보
            Text(
              '100% 완료 시 받는 포인트: 500P',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 111, 97),
              ),
            ),

            SizedBox(height: 40), // 간격

            // 확인하기 버튼
            ElevatedButton(
              onPressed: () {
                // '확인하기' 버튼 클릭 시 홈페이지로 이동
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Homepage()), // Homepage로 이동
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 255, 111, 97), // 버튼 색상
                padding: EdgeInsets.symmetric(horizontal: 120, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                '확인하기',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
