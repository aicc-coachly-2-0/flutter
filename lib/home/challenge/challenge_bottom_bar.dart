import 'package:flutter/material.dart';

class ChallengeBottomBar extends StatelessWidget {
  const ChallengeBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 제목과 X 버튼을 포함하는 Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 제목
              Text(
                '인증 방법 및 유의 사항',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // X 버튼
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context); // 하단바 닫기
                },
              ),
            ],
          ),

          // 제목 밑에 밑줄 추가
          Divider(
            color: Colors.black54, // 밑줄 색
            thickness: 1, // 밑줄 두께
          ),

          SizedBox(height: 16),

          // 인증 방법 제목
          Text(
            '인증 방법',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),

          // 사진 두 장을 한 줄에 나란히 배치
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 첫 번째 사진과 설명
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 사진과 초록색 "O" 띠
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image.asset('assets/image.png',
                            width: 180, height: 180), // O 이미지
                        Container(
                          width: 180,
                          color: Colors.green, // 초록색 띠
                          child: Text(
                            'O',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4), // 사진과 텍스트 사이 간격
                    Text(
                      '피트니스 앱 화면을 날짜와 함께 캡쳐해 인증하기',
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              // 두 번째 사진과 설명
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 사진과 빨간색 "X" 띠
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image.asset('assets/image.png',
                            width: 180, height: 180), // X 이미지
                        Container(
                          width: 180,
                          color: Colors.red, // 빨간색 띠
                          child: Text(
                            'X',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4), // 사진과 텍스트 사이 간격
                    Text(
                      '날짜가 보이지 않는 사진, 인증과 관계없는 사진 중복사진 사용 등',
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // 미션 유의 사항
          Text(
            '미션 유의 사항',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            "- 해당 첼린지는 기간 동안 '평일 매일', '하우레 1회' 인증해주세요.",
            style: TextStyle(fontSize: 13),
          ),
          SizedBox(height: 4),
          Text(
            "- 00시 00분 ~ 23시 59분 사이에 인증해주세요.",
            style: TextStyle(fontSize: 13),
          ),
          SizedBox(height: 4),
          Text(
            "- 인증 날짜 이전에 찍은 사진은 인증 시 사용하실 수 없습니다.",
            style: TextStyle(fontSize: 13),
          ),
          SizedBox(height: 4),
          Text(
            "- 인증샷은 해당 미션 참가자에게만 공개됩니다.",
            style: TextStyle(fontSize: 13),
          ),
          SizedBox(height: 4),
          Text(
            "- 적절하지 않은 인증샷의 경우 최종 검토 후 경고 처리됩니다.",
            style: TextStyle(fontSize: 13),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
