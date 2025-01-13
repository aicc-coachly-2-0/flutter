// detail_question.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_test/state_controller/question_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../question_category_dropdown.dart'; // 문의 유형 드롭다운
import '../question_form.dart'; // 문의 제목 및 내용 폼
import '../submit_button.dart'; // 문의하기 버튼

class ApplyQuestion extends ConsumerWidget {
  const ApplyQuestion({super.key});

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
            const QuestionCategoryDropdown(),

            const SizedBox(
              height: 20,
            ),

            // 문의 제목 및 내용 폼
            const QuestionForm(),

            // 문의하기 버튼
            const SubmitButton(),
          ],
        ),
      ),
    );
  }
}
