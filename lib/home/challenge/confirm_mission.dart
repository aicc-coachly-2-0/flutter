import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/challenge/challenge_bottom_bar.dart';
import 'package:flutter_application_test/nav/report_mission_button.dart';

class ConfirmMission extends StatefulWidget {
  const ConfirmMission({super.key});

  @override
  _ConfirmMissionState createState() => _ConfirmMissionState();
}

class _ConfirmMissionState extends State<ConfirmMission>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 미션 사진과 제목
            Stack(
              alignment: Alignment.topLeft, // 제목을 상단 왼쪽에 배치
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[300], // 임시로 회색 박스
                  child: Icon(
                    Icons.image, // 이미지 대신 아이콘
                    size: 100,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Text(
                    '미션 제목',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // 인증 기간 및 가능 시간
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '인증기간: 2024-01-01 ~ 2024-12-31',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    Text(
                      '인증가능: 평일매일(00:00~23:59)',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),

            // 인증방법 및 유의사항 Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '인증방법 및 유의사항',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    // BottomSheet 열기
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true, // 높이를 설정할 수 있도록 활성화
                      builder: (BuildContext context) {
                        return ChallengeBottomBar();
                      },
                      // 화면 높이의 60%로 설정
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.65,
                      ),
                    );
                  },
                ),
              ],
            ),

            SizedBox(height: 16),

            // 내인증, 참가자 인증 탭
            TabBar(
              controller: _tabController,
              indicatorColor: Color.fromARGB(255, 255, 111, 97), // 밑줄 색상
              indicatorWeight: 3.0, // 밑줄 두께
              labelColor: Colors.black, // 선택된 탭 텍스트 색상
              unselectedLabelColor: Colors.grey, // 선택되지 않은 탭 텍스트 색상
              tabs: const [
                Tab(text: '내인증'), // 내인증 탭
                Tab(text: '참가자 인증'), // 참가자 인증 탭
              ],
            ),
            SizedBox(height: 16),

            // 미션 달성률 바
            Text(
              '미션 달성률',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildMissionProgressBar(context),

            SizedBox(height: 16),

            // 탭에 따른 내용 표시
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildFeedTab(), // 내인증 탭
                  _buildCommunityTab(), // 참가자 인증 탭
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMissionProgressBar(BuildContext context) {
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

  // 내인증 탭 내용
  Widget _buildFeedTab() {
    return Center(
      child: Text('내인증 탭 내용'), // 내인증 내용
    );
  }

  // 참가자 인증 탭 내용
  Widget _buildCommunityTab() {
    return Center(
      child: Text('참가자 인증 탭 내용'), // 참가자 인증 내용
    );
  }
}
