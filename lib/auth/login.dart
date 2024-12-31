import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/state_controller/loginProvider.dart';
import 'package:flutter_application_test/home/home.dart';
import 'package:flutter_application_test/auth/signupagree.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // ConsumerWidget 사용

// 로그인 화면 (ConsumerWidget 사용)
class Login extends ConsumerWidget {
  Login({super.key});

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // 로그인 요청을 처리하는 함수
  Future<void> onSubmit(BuildContext context, WidgetRef ref) async {
    String id = _idController.text;
    String password = _passwordController.text;

    try {
      // 로그인 함수 호출
      await loginUser(ref, id, password);

      // 로그인 후 처리 (예: 화면 전환)
      final user = ref.read(authProvider);
      if (user != null) {
        // 로그인 성공 후 홈페이지로 이동
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const Homepage()), // Homepage로 이동
        );
      } else {
        // 로그인 실패 처리
        _showErrorDialog(context, '로그인 실패');
      }
    } catch (error) {
      _showErrorDialog(context, '로그인 중 오류가 발생했습니다');
    }
  }

  // 오류 메시지를 보여주는 함수
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('오류'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widthRatio = MediaQuery.of(context).size.width / 375;
    final heightRatio = MediaQuery.of(context).size.height / 812;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.home,
            color: Colors.black, // 텍스트와 색상을 통일
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Homepage()),
            ); // 뒤로가기
          },
        ),
        title: Text(
          "로그인",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'GowunBatang',
            fontWeight: FontWeight.w400,
            letterSpacing: -0.40,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 255, 111, 97),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: widthRatio * 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: heightRatio * 60),
            Center(
              child: Text(
                'LOGIN',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 111, 97),
                  fontSize: 30,
                  fontFamily: 'GowunBatang',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: heightRatio * 40),

            // 아이디 입력 필드
            Row(
              children: [
                Text(
                  'ID',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 111, 97),
                    fontSize: 16,
                    fontFamily: 'GowunBatang',
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.40,
                    height: 1.2,
                  ),
                ),
                Spacer(),
                Container(
                  width: widthRatio * 300,
                  height: heightRatio * 52,
                  padding: EdgeInsets.symmetric(horizontal: widthRatio * 10),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: TextFormField(
                    controller: _idController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '아이디를 입력하세요',
                      hintStyle: TextStyle(
                        color: Color(0xFFCCCCCC),
                        fontSize: 13,
                        fontFamily: 'GowunBatang',
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.33,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: heightRatio * 22),

            // 비밀번호 입력 필드
            Row(
              children: [
                Text(
                  'P/W',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 111, 97),
                    fontSize: 16,
                    fontFamily: 'GowunBatang',
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.40,
                    height: 1.2,
                  ),
                ),
                Spacer(),
                Container(
                  width: widthRatio * 300,
                  height: heightRatio * 52,
                  padding: EdgeInsets.symmetric(horizontal: widthRatio * 10),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '비밀번호를 입력하세요',
                      hintStyle: TextStyle(
                        color: Color(0xFFCCCCCC),
                        fontSize: 13,
                        fontFamily: 'GowunBatang',
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.33,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: heightRatio * 30),

            // 로그인 버튼
            Container(
              width: double.infinity,
              height: heightRatio * 52,
              margin: EdgeInsets.only(top: heightRatio * 22),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 111, 97),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () => onSubmit(context, ref),
                child: const Text(
                  '로그인',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'GowunBatang',
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.40,
                  ),
                ),
              ),
            ),

            // 회원가입 페이지로 이동하는 버튼
            SizedBox(height: heightRatio * 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '아직 계정이 없으신가요?',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'GowunBatang',
                    color: Color.fromARGB(255, 42, 42, 42),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupAgree(),
                      ),
                    ); // 회원가입 페이지로 이동
                  },
                  child: Text(
                    "회원가입",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'GowunBatang',
                      color: Color.fromARGB(255, 255, 111, 97),
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                      letterSpacing: -0.40,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
