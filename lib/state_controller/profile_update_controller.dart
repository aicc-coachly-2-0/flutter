import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileUpdateState {
  final String? profileImagePath; // 프로필 이미지 경로
  final String nickname; // 닉네임
  final String bio; // 자기소개
  final bool isNicknameValid; // 닉네임 유효성 여부

  ProfileUpdateState({
    this.profileImagePath,
    this.nickname = '',
    this.bio = '',
    this.isNicknameValid = false,
  });

  // copyWith 메소드로 상태를 변경 가능하도록 한다.
  ProfileUpdateState copyWith({
    String? profileImagePath,
    String? nickname,
    String? bio,
    bool? isNicknameValid,
  }) {
    return ProfileUpdateState(
      profileImagePath: profileImagePath ?? this.profileImagePath,
      nickname: nickname ?? this.nickname,
      bio: bio ?? this.bio,
      isNicknameValid: isNicknameValid ?? this.isNicknameValid,
    );
  }
}

class ProfileUpdateNotifier extends StateNotifier<ProfileUpdateState> {
  ProfileUpdateNotifier() : super(ProfileUpdateState());

  // 프로필 이미지 경로 설정
  void setProfileImage(String imagePath) {
    state = state.copyWith(profileImagePath: imagePath);
  }

  // 닉네임 설정
  void setNickname(String nickname) {
    state = state.copyWith(nickname: nickname);
  }

  // 자기소개 설정
  void setBio(String bio) {
    state = state.copyWith(bio: bio);
  }

  // 닉네임 중복 확인
  void validateNickname() {
    // 여기에 실제 중복 체크 로직을 구현할 수 있습니다. 예시로 비어있지 않으면 유효하다고 가정.
    state = state.copyWith(isNicknameValid: state.nickname.isNotEmpty);
  }

  // 상태 초기화 (리셋)
  void resetState() {
    state = ProfileUpdateState();
  }
}

// ProfileUpdate 상태를 관리하는 Provider
final profileUpdateProvider =
    StateNotifierProvider<ProfileUpdateNotifier, ProfileUpdateState>(
  (ref) => ProfileUpdateNotifier(),
);
