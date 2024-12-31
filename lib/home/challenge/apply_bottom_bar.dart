import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/challenge/apply_complete.dart';

class ApplyBottomBar extends StatefulWidget {
  const ApplyBottomBar({super.key});

  @override
  _ApplyBottomBarState createState() => _ApplyBottomBarState();
}

class _ApplyBottomBarState extends State<ApplyBottomBar> {
  bool isChecked1 = false; // 첫 번째 체크박스 상태
  bool isChecked2 = false; // 두 번째 체크박스 상태

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4, // 바텀시트 높이 설정 (화면의 40%)
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 참여하기 텍스트와 닫기 버튼을 한 줄로 배치
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // 참여하기 텍스트 가운데 정렬
            children: [
              Expanded(
                child: Text(
                  '참여하기',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center, // 가운데 정렬
                ),
              ),
              IconButton(
                icon: Icon(Icons.close), // 닫기 버튼
                onPressed: () {
                  Navigator.pop(context); // 바텀 시트 닫기
                },
              ),
            ],
          ),
          Divider(), // 밑줄

          // 미션 참여 문구 (글자 크기 키우고 볼드 적용)
          Text(
            '미션이 시작되면 성실하게 참여해 주셔야 해요!',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          // 체크박스 2개와 문구
          Column(
            children: [
              Row(
                children: [
                  Checkbox(
                    value: isChecked1, // 첫 번째 체크박스 상태
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked1 = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      '미션 인증 시 부정 행위를 하지 않겠습니다.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: isChecked2, // 두 번째 체크박스 상태
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked2 = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      '미션을 성실히 참여할 것을 약속합니다.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // 제재 문구
          Text(
            '미션 진행 중 부정 행위 혹은 타인에게 피해를 주어 제재를 받을 경우 추후 포인트 획득 및 미션 참여에 불이익이 생길 수 있습니다.',
            style: TextStyle(fontSize: 12, color: Colors.red), // 빨간색으로 표시
          ),

          SizedBox(height: 16),

          // 미션 도전 버튼
          Center(
            child: ElevatedButton(
              onPressed: (isChecked1 && isChecked2)
                  ? () {
                      // 미션 도전 버튼 클릭 시 동작
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ApplyComplete(),
                        ),
                      );
                    }
                  : null, // 버튼이 비활성화 될 경우 null로 설정

              style: ElevatedButton.styleFrom(
                backgroundColor: (isChecked1 && isChecked2)
                    ? Color.fromARGB(255, 255, 111, 97) // 활성화된 색상
                    : Color.fromARGB(255, 211, 211, 211), // 비활성화된 색상
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                '미션 도전',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
