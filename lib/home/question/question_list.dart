import 'package:flutter/material.dart';

class QuestionList extends StatelessWidget {
  const QuestionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색 설정
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // 섹션 1
            _buildQuestionSection(
              context,
              category: '계정',
              title: '내 계정 비밀번호를 잃어버렸어요.',
            ),
            Divider(color: Colors.grey, thickness: 1), // 구분선

            // 섹션 2
            _buildQuestionSection(
              context,
              category: '결제/환불',
              title: '결제한 금액이 환불되지 않았습니다.',
            ),
            Divider(color: Colors.grey, thickness: 1), // 구분선

            // 섹션 3
            _buildQuestionSection(
              context,
              category: '기타',
              title: '서비스 이용 중 오류가 발생했습니다.',
            ),
            Divider(color: Colors.grey, thickness: 1), // 구분선

            // 섹션 4
            _buildQuestionSection(
              context,
              category: '이용문의',
              title: '이용 가능한 기능에 대해 문의합니다.',
            ),
            Divider(color: Colors.grey, thickness: 1), // 구분선
          ],
        ),
      ),
    );
  }

  // 문의 섹션 빌드 함수
  Widget _buildQuestionSection(BuildContext context,
      {required String category, required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 문의 유형
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 111, 97), // 색상 지정
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '[$category]', // 대괄호 안에 카테고리 표시
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 10), // 문의유형과 제목 간의 간격

          // 문의 제목
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
