import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedUploadState {
  final String? imagePath; // 이미지 경로
  final String title; // 제목
  final String description; // 내용
  final bool isImageSelected; // 이미지 선택 여부
  final bool isAlbumExpanded; // 앨범 확장 여부

  FeedUploadState({
    this.imagePath,
    this.title = '',
    this.description = '',
    this.isImageSelected = false,
    this.isAlbumExpanded = false, // 초기 상태는 앨범이 확장되지 않은 상태
  });

  FeedUploadState copyWith({
    String? imagePath,
    String? title,
    String? description,
    bool? isImageSelected,
    bool? isAlbumExpanded,
  }) {
    return FeedUploadState(
      imagePath: imagePath ?? this.imagePath,
      title: title ?? this.title,
      description: description ?? this.description,
      isImageSelected: isImageSelected ?? this.isImageSelected,
      isAlbumExpanded: isAlbumExpanded ?? this.isAlbumExpanded,
    );
  }
}

class FeedUploadNotifier extends StateNotifier<FeedUploadState> {
  FeedUploadNotifier() : super(FeedUploadState());

  // 이미지 경로 업데이트
  void setImage(String imagePath) {
    state = state.copyWith(imagePath: imagePath, isImageSelected: true);
  }

  // 제목 업데이트
  void setTitle(String title) {
    state = state.copyWith(title: title); // text -> title로 수정
  }

  // 내용 업데이트
  void setDescription(String description) {
    state =
        state.copyWith(description: description); // text -> description으로 수정
  }

  // 앨범 확장 상태 업데이트
  void toggleAlbumExpansion() {
    state = state.copyWith(isAlbumExpanded: !state.isAlbumExpanded);
  }

  // 이미지 선택 초기화
  void resetImage() {
    state = state.copyWith(imagePath: null, isImageSelected: false);
  }

  // 제목 초기화
  void resetTitle() {
    state = state.copyWith(title: '');
  }

  // 내용 초기화
  void resetDescription() {
    state = state.copyWith(description: '');
  }
}

// FeedUpload 상태를 관리하는 Provider
final feedUploadProvider =
    StateNotifierProvider<FeedUploadNotifier, FeedUploadState>(
  (ref) => FeedUploadNotifier(),
);
