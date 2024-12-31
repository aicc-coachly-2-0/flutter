import 'package:flutter/material.dart';

class DeadlineMission extends StatelessWidget {
  const DeadlineMission({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 첫 번째 섹션 제목
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            '곧 시작해요 얼른 들어오세요 !',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black38,
            ),
          ),
        ),

        // "지금 주목받는 미션" 제목과 오른쪽 상단 화살표 버튼을 같은 선상에 배치
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '마감 임박 미션',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                // 버튼 클릭 시 동작
                print('자세히 보기 버튼 클릭');
              },
            ),
          ],
        ),

        // 미션 사진들이 가로스크롤로 나열되는 부분
        SizedBox(
          height: 250, // 이미지 크기
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // 가로 스크롤
            itemCount: 5, // 미션의 개수 (예시로 5개)
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 미션 이미지 (아이콘으로 대체)
                    Stack(
                      alignment: Alignment.topLeft, // 왼쪽 상단에 텍스트 위치
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          color: Colors.grey[300], // 이미지 대신 회색 박스
                          child: Icon(
                            Icons.image, // 이미지 아이콘
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                        // 참여자 수 (사람들 모티콘)
                        Positioned(
                          top: 8,
                          left: 8,
                          child: Text(
                            '👥 ${index + 10}명', // 사람 모티콘과 참여자 수
                            style: TextStyle(
                              fontSize: 10, // 아주 작은 폰트
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8), // 간격
                    // 시작 날짜
                    Text(
                      '시작 날짜: 2024-01-01',
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 255, 126, 51),
                      ),
                    ),
                    SizedBox(height: 4),
                    // 미션 이름
                    Text(
                      '미션 ${index + 1} 이름',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    // 기간
                    Text(
                      '${index + 1}주간', // 예시 기간
                      style: TextStyle(fontSize: 8, color: Colors.black54),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
