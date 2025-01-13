import 'package:flutter/material.dart';

class MissionProgressBar extends StatelessWidget {
  const MissionProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    // 화면 너비의 90%로 가로바의 너비 설정
    double progressBarWidth = MediaQuery.of(context).size.width * 0.9;

    // 각 구간에 맞는 텍스트의 위치 계산 (0%, 50%, 80%, 100%)
    double zeroPosition = 0.0; // 0%
    double oneFiftyPosition = progressBarWidth * 0.45; // 50%
    double threeFiftyPosition = progressBarWidth * 0.75; // 80%
    double fiveHundredPosition = progressBarWidth * 0.9; // 100%

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 가로바를 중앙에 배치하기 위해 Center 위젯을 사용
        Center(
          child: Stack(
            children: [
              // 기본 가로바
              Container(
                height: 20,
                width: progressBarWidth, // 전체 가로폭의 90%로 설정
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // 진행된 부분 (75%)
              Container(
                height: 20,
                width: progressBarWidth * 0.75, // 75% 진행 상태
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 111, 97),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // 0P 위치 (왼쪽 끝)
              Positioned(
                left: zeroPosition,
                child: Text(
                  '0P',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // 150P 위치 (가로바 너비의 절반 지점)
              Positioned(
                left: oneFiftyPosition,
                child: Text(
                  '150P',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // 350P 위치 (가로바 너비의 80% 지점)
              Positioned(
                left: threeFiftyPosition,
                child: Text(
                  '350P',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // 500P 위치 (가로바 끝 지점)
              Positioned(
                left: fiveHundredPosition,
                child: Text(
                  '500P',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
