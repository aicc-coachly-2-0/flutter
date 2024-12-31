import 'package:flutter/material.dart';
import 'package:flutter_application_test/state_controller/question_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailQuestion extends ConsumerWidget {
  const DetailQuestion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 상태 가져오기
    final questionState = ref.watch(questionProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '문의하기',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false, // 기본 뒤로가기 버튼을 비활성화
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // 뒤로가기 시 상태 초기화
            ref.read(questionProvider.notifier).reset();
            Navigator.pop(context); // 페이지 뒤로가기
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // 문의 유형 (드롭다운)
            DropdownButtonFormField<String>(
              value: questionState.category,
              decoration: InputDecoration(
                labelText: '문의 유형',
                border: OutlineInputBorder(),
              ),
              onChanged: (String? newValue) {
                ref.read(questionProvider.notifier).setCategory(newValue);
              },
              items: <String>['계정', '결제/환불', '이용문의', '기타']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),

            // 문의 제목 입력
            TextField(
              controller: TextEditingController(text: questionState.title),
              onChanged: (title) {
                ref.read(questionProvider.notifier).setTitle(title);
              },
              decoration: InputDecoration(
                labelText: '문의 제목',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // 문의 내용 입력
            TextField(
              controller: TextEditingController(text: questionState.content),
              maxLines: 6, // 내용 입력란 크기 늘리기
              onChanged: (content) {
                ref.read(questionProvider.notifier).setContent(content);
              },
              decoration: InputDecoration(
                labelText: '문의 내용',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // 사진 첨부 (텍스트 박스 안에 이미지 링크 표시)
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // 사진 추가 버튼 클릭 시 갤러리 접근
                      ref.read(questionProvider.notifier).pickImage();
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        controller: TextEditingController(
                          text: questionState.images.isEmpty
                              ? '사진을 첨부해주세요'
                              : '첨부된 사진: ${questionState.images.length}개',
                        ),
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: '사진 첨부',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.add_circle_outline),
                        ),
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis, // 긴 텍스트는 '...'으로 표시
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // 선택된 이미지 링크 표시 (박스 안에 텍스트 형식으로)
            if (questionState.images.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('첨부된 이미지:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            List.generate(questionState.images.length, (index) {
                          return Text(
                            questionState.images[index],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis, // 길면 ...으로 표시
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            SizedBox(height: 16),

            // 개인정보 수집 동의 체크박스
            Row(
              children: [
                Checkbox(
                  value: questionState.isAgree,
                  onChanged: (bool? value) {
                    ref
                        .read(questionProvider.notifier)
                        .setAgree(value ?? false);
                  },
                ),
                Expanded(
                  child: Text(
                    '개인정보 수집에 동의합니다.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // 문의하기 버튼
            ElevatedButton(
              onPressed: questionState.isAgree
                  ? () {
                      // 문의하기 버튼 클릭 시 동작할 내용
                      print('문의 제목: ${questionState.title}');
                      print('문의 내용: ${questionState.content}');
                      print('선택된 카테고리: ${questionState.category}');
                      print('첨부된 이미지 링크: ${questionState.images}');
                    }
                  : null, // 동의하지 않으면 버튼 비활성화
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), // 버튼 너비를 90%로 설정
                backgroundColor: Color.fromARGB(255, 255, 111, 97), // 버튼 색상 변경
                foregroundColor: Colors.white, // 텍스트 색상 변경
              ),
              child: Text('문의하기'),
            )
          ],
        ),
      ),
    );
  }
}
