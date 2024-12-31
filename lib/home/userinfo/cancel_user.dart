import 'package:flutter/material.dart';

class CancelUser extends StatefulWidget {
  const CancelUser({super.key});

  @override
  _CancelUserState createState() => _CancelUserState();
}

class _CancelUserState extends State<CancelUser> {
  String? _selectedReason; // 선택된 탈퇴 사유
  final List<String> _reasons = [
    '개인 정보 보호',
    '서비스 이용 불편',
    '더 나은 서비스 제공',
    '기타',
  ];

  final TextEditingController _reasonController =
      TextEditingController(); // 기타 사유 입력을 위한 컨트롤러

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              '탈퇴하기',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            const SizedBox(height: 10),

            // 탈퇴 사유 선택
            const Text(
              'Coachly를 탈퇴하는 사유를 알려주세요',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),

            // 탈퇴 사유 선택 드롭다운
            DropdownButton<String>(
              isExpanded: true,
              hint: const Text('탈퇴 사유 선택'),
              value: _selectedReason,
              items: _reasons.map((String reason) {
                return DropdownMenuItem<String>(
                  value: reason,
                  child: Text(reason),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedReason = newValue;
                });
              },
            ),
            const SizedBox(height: 20),

            // 기타 사유일 경우 텍스트 입력란 표시
            if (_selectedReason == '기타') ...[
              const Text(
                '기타 사유를 입력해주세요:',
                style: TextStyle(fontSize: 16),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: TextField(
                  controller: _reasonController,
                  decoration: const InputDecoration(
                    hintText: '사유를 입력하세요',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ),
            ],
            const SizedBox(height: 20),

            // 탈퇴하기 버튼 (90% 차지)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedReason == null || _selectedReason!.isEmpty
                    ? null
                    : () {
                        // 탈퇴 처리 로직 추가
                        print('선택된 사유: $_selectedReason');
                        if (_selectedReason == '기타') {
                          print('기타 사유: ${_reasonController.text}');
                        }
                        Navigator.pop(context); // BottomSheet 닫기
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _selectedReason == null || _selectedReason!.isEmpty
                          ? Colors.grey // 사유가 선택되지 않으면 회색
                          : Color.fromARGB(255, 255, 111, 97), // 선택되면 주어진 색
                  foregroundColor: Colors.white, // 버튼 비활성화 색상
                  minimumSize: Size(double.infinity, 50), // 버튼 최소 크기 설정
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // 둥근 모서리
                  ),
                ),
                child: Text(
                  '탈퇴하기',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _selectedReason == null || _selectedReason!.isEmpty
                        ? Colors.white // 사유가 선택되지 않으면 하얀색 텍스트
                        : Colors.white, // 선택되면 하얀색 텍스트
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
