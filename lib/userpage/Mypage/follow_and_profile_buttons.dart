import 'package:flutter/material.dart';
import 'package:flutter_application_test/userpage/profile_update.dart';
import 'package:flutter_application_test/home/userinfo/follow_tap.dart';

// 팔로우 및 프로필 수정 버튼
class FollowAndProfileButtons extends StatelessWidget {
  const FollowAndProfileButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 팔로우 및 팔로워 수를 버튼으로 묶기
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              backgroundColor: Colors.white, // 텍스트 색상
              side: const BorderSide(
                color: Color.fromARGB(255, 255, 176, 123), // 버튼 테두리 색상
                width: 1.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0), // 둥근 모서리
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const FollowTap(), // 임시로 FocusOnExercisePage로 이동
                ),
              );
              // 팔로우 관련 버튼 클릭 시 동작을 여기에 추가
              print("팔로우 클릭");
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 팔로우 텍스트
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                            color: const Color.fromARGB(255, 255, 176, 123),
                            width: 1.0), // 팔로우와 팔로워 구분선
                      ),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('팔로우 100',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                // 팔로워 텍스트
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('팔로워 258',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16.0), // 프로필 수정 버튼과의 간격
        // 프로필 수정 버튼
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const ProfileUpdate(), // 임시로 FocusOnExercisePage로 이동
              ),
            );
            print('프로필 수정');
            // 프로필 수정 로직 추가
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 255, 111, 97), // 버튼 색상
          ),
          child: const Text(
            '프로필 수정',
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
      ],
    );
  }
}
