import 'package:flutter/material.dart';
import 'package:flutter_application_test/auth/profile.dart';
import 'package:flutter_application_test/state_controller/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateAccountScreen extends ConsumerWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 상태를 가져옴
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '계정 생성',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFFFF6F61), // 포인트 컬러로 설정
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: Color.fromARGB(164, 255, 255, 255),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
            children: [
              // 'JOIN US' 텍스트 - 왼쪽 상단에 위치
              Text(
                'JOIN US',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF6F61),
                ),
              ),
              const SizedBox(height: 10), // 간격 추가

              // '정보 입력' 텍스트 - 왼쪽 상단에 위치
              Text(
                '정보 입력',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20), // 간격 추가

              // 로그인 아이디 입력 필드
              TextFormField(
                initialValue: authState['loginId'],
                decoration: InputDecoration(
                  labelText: '로그인 아이디',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) {
                  ref.read(authControllerProvider.notifier).setLoginId(value);
                },
              ),
              const SizedBox(height: 16.0),

              // 비밀번호 입력 필드
              TextFormField(
                initialValue: authState['password'],
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                obscureText: true,
                onChanged: (value) {
                  ref.read(authControllerProvider.notifier).setPassword(value);
                },
              ),
              const SizedBox(height: 16.0),

              // 비밀번호 확인 필드
              TextFormField(
                initialValue: authState['confirmPassword'],
                decoration: InputDecoration(
                  labelText: '비밀번호 확인',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                obscureText: true,
                onChanged: (value) {
                  ref
                      .read(authControllerProvider.notifier)
                      .setConfirmPassword(value);
                },
              ),
              const SizedBox(height: 16.0),

              // 연락처 입력 필드
              TextFormField(
                initialValue: authState['phoneNumber'],
                decoration: InputDecoration(
                  labelText: '연락처',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) {
                  ref
                      .read(authControllerProvider.notifier)
                      .setPhoneNumber(value);
                },
              ),
              const SizedBox(height: 16.0),

              // 이메일 입력 필드
              TextFormField(
                initialValue: authState['email'],
                decoration: InputDecoration(
                  labelText: '이메일',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) {
                  ref.read(authControllerProvider.notifier).setEmail(value);
                },
              ),
              const SizedBox(height: 24.0),

              // 계정 생성 버튼
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50), // 버튼 높이 조정
                  backgroundColor: const Color(0xFFFF6F61), // 포인트 컬러
                ),
                onPressed: () {
                  // 유효성 검증 후 계정 생성
                  if (ref
                      .read(authControllerProvider.notifier)
                      .validateForm()) {
                    // 유효성 검증 성공 시 다음 페이지로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const ProfilePage(), // 값을 넘기지 않고 이동
                      ),
                    );
                  } else {
                    // 유효성 검증 실패 시 알림 표시
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('모든 필드를 올바르게 입력해주세요.')),
                    );
                  }
                },
                child: const Text(
                  '다음',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
