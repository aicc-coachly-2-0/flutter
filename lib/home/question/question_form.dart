import 'package:flutter/material.dart';
import 'package:flutter_application_test/state_controller/question_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionForm extends ConsumerStatefulWidget {
  const QuestionForm({super.key});

  @override
  _QuestionFormState createState() => _QuestionFormState();
}

class _QuestionFormState extends ConsumerState<QuestionForm> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    final questionState = ref.read(questionProvider);
    titleController = TextEditingController(text: questionState.title);
    contentController = TextEditingController(text: questionState.content);
  }

  @override
  void dispose() {
    // TextEditingController 메모리 해제
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final questionState = ref.watch(questionProvider);

    return Column(
      children: [
        // 문의 제목 입력
        TextField(
          controller: titleController,
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
          controller: contentController,
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

        // 개인정보 수집 동의 체크박스
        Row(
          children: [
            Checkbox(
              value: questionState.isAgree,
              onChanged: (bool? value) {
                ref.read(questionProvider.notifier).setAgree(value ?? false);
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
      ],
    );
  }
}
