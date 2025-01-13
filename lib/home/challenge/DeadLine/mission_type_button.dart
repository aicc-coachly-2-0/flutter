import 'package:flutter/material.dart';

class MissionTypeButton extends StatelessWidget {
  final String label;
  final String selectedMissionType;
  final VoidCallback onPressed;

  const MissionTypeButton(this.label, this.selectedMissionType, this.onPressed,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedMissionType == label
              ? Color.fromARGB(255, 255, 111, 97) // 선택된 버튼 색상
              : Colors.white, // 선택되지 않은 버튼 배경색
          side: BorderSide(
            color: selectedMissionType == label
                ? Color.fromARGB(255, 255, 111, 97) // 선택된 상태에서의 테두리 색
                : Colors.grey.withOpacity(0.5), // 선택되지 않은 상태에서의 연한 테두리 색
            width: 1,
          ),
          padding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0), // 크기 조정
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // 둥근 모서리
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selectedMissionType == label
                ? Colors.white // 선택된 버튼의 텍스트 색상
                : Colors.black, // 선택되지 않은 버튼의 텍스트 색상
            fontSize: 12, // 작은 크기
          ),
        ),
      ),
    );
  }
}
