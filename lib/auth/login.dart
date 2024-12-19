import 'package:flutter/material.dart';
import 'package:flutter_application_test/auth/signupagree.dart';
import 'package:flutter_application_test/home/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            color: Colors.black, // 명확한 텍스트 색상
            fontSize: 16,
            fontFamily: 'GowunBatang',
            fontWeight: FontWeight.w400,
            letterSpacing: -0.40,
          ),
        ),
        centerTitle: true, // 제목 가운데 정렬
        backgroundColor: Color.fromARGB(255, 255, 111, 97), // 투명도 제거
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: widthRatio * 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LOGIN 텍스트
            SizedBox(height: heightRatio * 60), // 화면 상단 여백
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
            SizedBox(height: heightRatio * 40), // "LOGIN" 텍스트와 입력 필드 사이의 간격

            // 이메일 입력 필드
            Row(
              children: [
                Text(
                  '이메일',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 111, 97),
                    fontSize: 16,
                    fontFamily: 'GowunBatang',
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.40,
                    height: 1.2,
                  ),
                ),
                Spacer(),
                Container(
                  width: widthRatio * 280,
                  height: heightRatio * 52,
                  padding: EdgeInsets.symmetric(horizontal: widthRatio * 10),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '이메일을 입력하세요',
                      hintStyle: TextStyle(
                        color: Color(0xFFCCCCCC),
                        fontSize: 13,
                        fontFamily: 'GowunBatang',
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.33,
                        height: 1.2,
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
                    color: const Color.fromARGB(255, 255, 111, 97),
                    fontSize: 16,
                    fontFamily: 'GowunBatang',
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.40,
                    height: 1.2,
                  ),
                ),
                Spacer(),
                Container(
                  width: widthRatio * 280,
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
                        height: 1.2,
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
                onPressed: () async {
                  String email = _emailController.text.toString();
                  String password = _passwordController.text.toString();

                  try {
                    // 여기에 FirebaseAuth 로그인 로직 추가
                    Navigator.pop(context);
                  } catch (e) {
                    // 예외 처리
                  }
                },
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

            // "아직 계정이 없으신가요?" 텍스트와 회원가입 버튼
            SizedBox(height: heightRatio * 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '아직 계정이 없으신가요?',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'GowunBatang',
                    color: const Color.fromARGB(255, 42, 42, 42),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const SignupAgree(), // 값을 넘기지 않고 이동
                      ),
                    ); // 회원가입 페이지로 이동
                  },
                  child: Text(
                    "회원가입",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'GowunBatang',
                      color: const Color.fromARGB(255, 255, 111, 97),
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xFF45B0C5),
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
