import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/challenge/Apply/apply_bottom_bar.dart';
import 'package:flutter_application_test/home/challenge/all_mission_get.dart';

class ApplyButton extends StatelessWidget {
  final Mission mission;
  const ApplyButton({required this.mission, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // 바텀 시트 열기
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // 스크롤 가능하게 설정
            builder: (BuildContext context) {
              return ApplyBottomBar(mission: mission); // ApplyBottomBar 호출
            },
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
          '참여하기',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
