// question_category_dropdown.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_test/state_controller/question_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionCategoryDropdown extends ConsumerWidget {
  const QuestionCategoryDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionState = ref.watch(questionProvider);

    return DropdownButtonFormField<String>(
      value: questionState.category,
      decoration: InputDecoration(
        labelText: '문의 유형',
        border: OutlineInputBorder(),
      ),
      onChanged: (String? newValue) {
        ref.read(questionProvider.notifier).setCategory(newValue);
      },
      items: <String>['계정', '커뮤니티', '미션', 'AI', '결제/환불', '신고', '기타']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
