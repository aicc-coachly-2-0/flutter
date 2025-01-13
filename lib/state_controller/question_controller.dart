import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionState {
  final String? category;
  final String title;
  final String content;
  final bool isAgree;

  QuestionState({
    this.category,
    this.title = '',
    this.content = '',
    this.isAgree = false,
  });

  // 상태 초기화
  QuestionState reset() {
    return QuestionState();
  }

  // 상태 업데이트
  QuestionState copyWith({
    String? category,
    String? title,
    String? content,
    bool? isAgree,
  }) {
    return QuestionState(
      category: category ?? this.category,
      title: title ?? this.title,
      content: content ?? this.content,
      isAgree: isAgree ?? this.isAgree,
    );
  }
}

class QuestionNotifier extends StateNotifier<QuestionState> {
  QuestionNotifier() : super(QuestionState());

  // 문의 유형 설정
  void setCategory(String? category) {
    state = state.copyWith(category: category);
  }

  // 문의 제목 설정
  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  // 문의 내용 설정
  void setContent(String content) {
    state = state.copyWith(content: content);
  }

  // 개인정보 수집 동의 설정
  void setAgree(bool isAgree) {
    state = state.copyWith(isAgree: isAgree);
  }

  // 상태 초기화
  void reset() {
    state = state.reset();
  }
}

final questionProvider = StateNotifierProvider<QuestionNotifier, QuestionState>(
  (ref) => QuestionNotifier(),
);
