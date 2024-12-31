import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart'; // image_picker 임포트

class QuestionState {
  final String? category;
  final String title;
  final String content;
  final List<String> images; // 이미지 링크 리스트
  final bool isAgree;

  QuestionState({
    this.category,
    this.title = '',
    this.content = '',
    this.images = const [],
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
    List<String>? images,
    bool? isAgree,
  }) {
    return QuestionState(
      category: category ?? this.category,
      title: title ?? this.title,
      content: content ?? this.content,
      images: images ?? this.images,
      isAgree: isAgree ?? this.isAgree,
    );
  }
}

class QuestionNotifier extends StateNotifier<QuestionState> {
  final ImagePicker _picker = ImagePicker(); // 이미지 피커 인스턴스

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

  // 사진 추가 (갤러리에서 사진 선택)
  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      state = state.copyWith(images: [...state.images, pickedFile.path]);
    }
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
