import 'package:flutter/material.dart';
import 'package:flutter_application_test/auth/signup.dart';

class SignupAgree extends StatefulWidget {
  const SignupAgree({super.key});

  @override
  _SignupAgreeState createState() => _SignupAgreeState();
}

class _SignupAgreeState extends State<SignupAgree> {
  bool _agreeTerms = false; // 이용약관 동의 체크박스 상태
  bool _agreeAll = false; // 전체 동의 체크박스 상태

  // 이용 약관의 동의 체크박스를 클릭하면, 모든 체크박스 상태를 변경하는 함수
  void _toggleAgreeAll(bool value) {
    setState(() {
      _agreeAll = value;
      _agreeTerms = value;
    });
  }

  // 다음 버튼 클릭 시 동작
  void _goToNext() {
    if (_agreeTerms) {
      // 동의가 완료된 경우 다음 페이지로 이동
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CreateAccountScreen(), // 값을 넘기지 않고 이동
        ),
      ); // 상세회원가입 페이지로 이동
    } else {
      // 동의하지 않은 경우 알림 표시
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("이용약관에 동의해 주세요")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "약관동의하기",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 111, 97), // 포인트 컬러
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 'JOIN US' 텍스트 추가
            Text(
              "JOIN US",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 111, 97),
              ),
            ),
            SizedBox(height: 20),

            // 약관 동의 섹션
            Text(
              "약관 동의",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),

            Row(
              children: [
                Checkbox(
                  value: _agreeTerms,
                  onChanged: (value) {
                    setState(() {
                      _agreeTerms = value!;
                    });
                  },
                ),
                Expanded(
                  child: Text(
                    "이용 약관에 동의합니다",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),

            // 약관 내용 박스 (30% 정도 크기)
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: SingleChildScrollView(
                child: Text(
                  "여기에 이용 약관의 내용이 들어갑니다. 약관의 내용은 길어지기 때문에 여기에서 텍스트 박스를 사용하여 스크롤 가능한 형태로 배치합니다. "
                  "이용자가 약관의 내용을 읽을 수 있도록 충분한 공간을 제공합니다. "
                  "약관의 세부 내용이 길어서 스크롤 할 수 있도록 처리해야 합니다.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            // 전체 동의 체크박스
            Row(
              children: [
                Checkbox(
                  value: _agreeAll,
                  onChanged: (value) {
                    _toggleAgreeAll(value!);
                  },
                ),
                Expanded(
                  child: Text(
                    "전체 동의합니다",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),

            // '다음' 버튼
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _goToNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 111, 97), // 포인트 컬러
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "다음",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
