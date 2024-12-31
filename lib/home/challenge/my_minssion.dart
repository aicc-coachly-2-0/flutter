import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/challenge/confirm_mission.dart';

class MyMission extends StatelessWidget {
  const MyMission({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 첫 번째 섹션 제목
        Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Text(
            '인증하고 포인트 꼭 받아가세요!',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black38,
            ),
          ),
        ),

        // "참여중인 미션" 제목
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            '참여중인 미션',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),

        // 참여중인 미션이 없을 때 표시하는 박스 (ListView 사용)
        SizedBox(
          height: 250, // 이미지 크기
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // 가로 스크롤
            itemCount: 5, // 미션의 개수 (예시로 5개)
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {
                    // 미션을 클릭했을 때 동작
                    // 예: 다른 페이지로 이동
                    _navigateToMissionDetail(context, index);
                  },
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
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // 미션 상세 페이지로 이동하는 함수 (예시)
  void _navigateToMissionDetail(BuildContext context, int index) {
    // 미션 상세 페이지로 이동 (이 예시에서는 그냥 메시지를 표시)
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('미션 ${index + 1}'),
          content: Text('미션 ${index + 1}의 상세 페이지로 이동합니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ConfirmMission(),
                  ),
                );
              },
              child: Text('닫기'),
            ),
          ],
        );
      },
    );
  }
}

        // 점선 박스
        // Padding(
        //   padding: const EdgeInsets.only(top: 16.0),
        //   child: Container(
        //     padding: const EdgeInsets.all(16.0),
        //     decoration: BoxDecoration(
        //       border: Border.all(
        //         color: Colors.black38,
        //         width: 1,
        //         style: BorderStyle.solid, // 점선 스타일
        //       ),
        //       borderRadius: BorderRadius.circular(12.0),
        //     ),
        //     child: Center(
        //       child: Text(
        //         '아직 참여중인 미션이 없습니다.',
        //         style: TextStyle(
        //           fontSize: 16,
        //           color: Colors.black54,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
 
