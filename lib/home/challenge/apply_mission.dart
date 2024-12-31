import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/challenge/apply_bottom_bar.dart';
import 'package:flutter_application_test/nav/report_mission_button.dart';

class ApplyMission extends StatelessWidget {
  const ApplyMission({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('미션 제목', style: TextStyle(color: Colors.black)),
        automaticallyImplyLeading: true, // 뒤로가기 버튼
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {
              // 점점점 버튼 클릭 시 동작
              showModalBottomSheet(
                context: context,
                isScrollControlled: true, // 스크롤 가능하도록 설정
                backgroundColor: Colors.transparent, // 모달 배경을 투명하게 처리
                builder: (BuildContext context) {
                  return ReportMissionButton(); // ReportButton 컴포넌트 호출
                },
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // 스크롤 형식
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 미션 이미지
            Container(
              width: double.infinity,
              height: 250,
              color: Colors.grey[300], // 이미지를 대신하는 색
              child: Icon(
                Icons.image, // 이미지 아이콘
                size: 80,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),

            // 미션을 만든 사람의 프로필과 참여자 수
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(width: 8),
                Text(
                  '미션 작성자 이름', // 예시 이름
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(Icons.people, size: 16, color: Colors.black),
                    SizedBox(width: 4),
                    Text(
                      ': 10명', // 참여자 수 예시
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),

            // 미션 제목, 날짜, 빈도수, 인증 횟수
            Text(
              '미션 제목',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '2024-01-01',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                Spacer(),
                Text(
                  '하루매일, 1회인증', // 빈도수와 인증 횟수 예시
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
            SizedBox(height: 16),

            // 100% 완주 포인트
            Text(
              '미션을 완료하면 100% 500P를 얻어요!',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            SizedBox(height: 8),
            Text(
              '미션에 대한 포인트는 미션 개설자가 선택합니다. 미션 참여시 꼭 획득 포인트를 확인하고 참가해 주세요.',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            SizedBox(height: 16),

            // 포인트 관련 정보 (가로폭 꽉 차게)
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 224, 193), // 옅은 베이지색 배경
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 100% 완주시 받는 포인트
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // 양쪽 끝에 배치
                    children: [
                      Text(
                        '100% 완주시 받는 포인트',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(244, 159, 159, 159)),
                      ),
                      Text(
                        '500P',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),

                  // 80% 완주시 받는 포인트
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // 양쪽 끝에 배치
                    children: [
                      Text(
                        '80% 완주시 받는 포인트',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(244, 159, 159, 159)),
                      ),
                      Text(
                        '400P',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),

                  // 50% 완주시 받는 포인트
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // 양쪽 끝에 배치
                    children: [
                      Text(
                        '50% 완주시 받는 포인트',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(244, 159, 159, 159)),
                      ),
                      Text(
                        '150P',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // 인증 방법
            Text('인증 방법',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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

            // 참여하기 버튼
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // 바텀 시트 열기
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true, // 스크롤 가능하게 설정
                    builder: (BuildContext context) {
                      return ApplyBottomBar(); // ApplyBottomBar 호출
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
            )
          ],
        ),
      ),
    );
  }
}
