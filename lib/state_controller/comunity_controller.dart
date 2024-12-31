import 'package:flutter_riverpod/flutter_riverpod.dart';

// 상태 관리 클래스
class BoardUploadState {
  final String selectedBoard;
  final String title;
  final String content;
  final String? imagePath;
  final bool isImageSelected;

  BoardUploadState({
    this.selectedBoard = '',
    this.title = '',
    this.content = '',
    this.imagePath,
    this.isImageSelected = false,
  });

  // 상태를 복사하여 새로운 값으로 업데이트
  BoardUploadState copyWith({
    String? selectedBoard,
    String? title,
    String? content,
    String? imagePath,
    bool? isImageSelected,
  }) {
    return BoardUploadState(
      selectedBoard: selectedBoard ?? this.selectedBoard,
      title: title ?? this.title,
      content: content ?? this.content,
      imagePath: imagePath ?? this.imagePath,
      isImageSelected: isImageSelected ?? this.isImageSelected,
    );
  }
}

// 상태 관리 프로바이더
final boardUploadProvider =
    StateNotifierProvider<BoardUploadNotifier, BoardUploadState>(
  (ref) => BoardUploadNotifier(),
);

class BoardUploadNotifier extends StateNotifier<BoardUploadState> {
  BoardUploadNotifier() : super(BoardUploadState());

  // 게시판 선택
  void setBoard(String board) {
    state = state.copyWith(selectedBoard: board);
  }

  // 제목 입력
  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  // 내용 입력
  void setContent(String content) {
    state = state.copyWith(content: content);
  }

  // 이미지 설정
  void setImage(String imagePath) {
    state = state.copyWith(imagePath: imagePath, isImageSelected: true);
  }

  // 이미지 리셋
  void resetImage() {
    state = state.copyWith(imagePath: null, isImageSelected: false);
  }

  // 모든 상태 리셋
  void resetAll() {
    state = BoardUploadState();
  }
}
