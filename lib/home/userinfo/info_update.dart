import 'package:flutter/material.dart';

class MyInfoUpdate extends StatefulWidget {
  const MyInfoUpdate({super.key});

  @override
  _MyInfoUpdateState createState() => _MyInfoUpdateState();
}

class _MyInfoUpdateState extends State<MyInfoUpdate> {
  // 텍스트 필드 컨트롤러
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  String? _gender = '남성'; // 기본 성별

  // 생일 선택 함수
  Future<void> _selectDate(BuildContext context) async {
    final DateTime initialDate = DateTime.now();
    final DateTime firstDate = DateTime(1900); // 첫 번째 선택 가능한 날짜
    final DateTime lastDate = DateTime(2101); // 마지막 선택 가능한 날짜

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null && picked != initialDate) {
      // 날짜를 선택한 후, 형식을 'yyyy-MM-dd'로 설정하여 컨트롤러에 업데이트
      setState(() {
        _birthdayController.text =
            '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _phoneController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내 정보 수정'), // 앱바 제목
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // 바디의 패딩
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
          children: <Widget>[
            // 이름 입력
            const Text(
              '이름', // 필드 이름
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: '이름을 입력하세요',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),

            // 연락처 입력
            const Text(
              '연락처', // 필드 이름
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _contactController,
              decoration: const InputDecoration(
                hintText: '연락처를 입력하세요',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone, // 전화번호 입력 키보드
            ),
            const SizedBox(height: 16.0),

            // 전화번호 입력
            const Text(
              '전화번호', // 필드 이름
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                hintText: '전화번호를 입력하세요',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone, // 전화번호 입력 키보드
            ),
            const SizedBox(height: 16.0),

            // 생일 입력
            const Text(
              '생일', // 필드 이름
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () => _selectDate(context), // 날짜 선택 함수 호출
              child: AbsorbPointer(
                child: TextField(
                  controller: _birthdayController,
                  decoration: const InputDecoration(
                    hintText: '생일을 입력하세요',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.datetime, // 날짜 입력 키보드
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // 성별 선택
            const Text(
              '성별', // 필드 이름
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold, // 텍스트 두껍게
                color: Colors.black, // 검은색으로 변경
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _gender = '남성';
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: _gender == '남성'
                            ? Color.fromARGB(255, 255, 111, 97)
                            : const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: _gender == '남성'
                              ? Colors.transparent
                              : Colors.black, // 클릭된 버튼은 테두리 없음
                          width: 1.0, // 테두리 두께
                        ),
                      ),
                      child: const Text(
                        '남성',
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _gender = '여성';
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: _gender == '여성'
                            ? Color.fromARGB(255, 255, 111, 97)
                            : const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: _gender == '여성'
                              ? Colors.transparent
                              : Colors.black, // 클릭된 버튼은 테두리 없음
                          width: 1.0, // 테두리 두께
                        ),
                      ),
                      child: const Text(
                        '여성',
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20.0),

            // 수정 완료 버튼
            SizedBox(
              width: double.infinity, // 버튼을 가로폭 90%로 설정
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color.fromARGB(255, 255, 111, 97), // 수정 완료 버튼 색상 변경
                ),
                onPressed: () {
                  // 수정 완료 클릭 시 동작
                  print('이름: ${_nameController.text}');
                  print('연락처: ${_contactController.text}');
                  print('전화번호: ${_phoneController.text}');
                  print('생일: ${_birthdayController.text}');
                  print('성별: $_gender');
                  // 여기에 데이터 업데이트 로직 추가
                },
                child: const Text(
                  '수정 완료',
                  style: TextStyle(
                    color: Colors.white, // 텍스트 색상 하얀색으로 변경
                    fontWeight: FontWeight.w700, // 텍스트 두껍게
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
