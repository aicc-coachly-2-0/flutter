import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

// Auth 상태 관리용 Notifier
class AuthController extends StateNotifier<Map<String, String>> {
  AuthController()
      : super({
          'loginId': '',
          'password': '',
          'confirmPassword': '',
          'phoneNumber': '',
          'email': '',
        });

  // 로그인 아이디 설정
  void setLoginId(String id) {
    state = {...state, 'loginId': id};
  }

  // 비밀번호 설정
  void setPassword(String password) {
    state = {...state, 'password': password};
  }

  // 비밀번호 확인 설정
  void setConfirmPassword(String confirmPassword) {
    state = {...state, 'confirmPassword': confirmPassword};
  }

  // 연락처 설정
  void setPhoneNumber(String phoneNumber) {
    state = {...state, 'phoneNumber': phoneNumber};
  }

  // 이메일 설정
  void setEmail(String email) {
    state = {...state, 'email': email};
  }

  // 폼 검증
  bool validateForm() {
    return state['loginId']!.isNotEmpty &&
        state['password']!.isNotEmpty &&
        state['confirmPassword']! == state['password'] &&
        state['phoneNumber']!.isNotEmpty &&
        state['email']!.isNotEmpty;
  }
}

// Auth 상태 관리용 provider
final authControllerProvider =
    StateNotifierProvider<AuthController, Map<String, String>>(
  (ref) => AuthController(),
);

class ProfileModel {
  final String? profileImagePath;
  final String? nickname;
  final DateTime? birthDate;
  final String? gender;

  ProfileModel({
    this.profileImagePath,
    this.nickname,
    this.birthDate,
    this.gender,
  });

  // 상태 업데이트를 위한 copyWith 메서드
  ProfileModel copyWith({
    String? profileImagePath,
    String? nickname,
    DateTime? birthDate,
    String? gender,
  }) {
    return ProfileModel(
      profileImagePath: profileImagePath ?? this.profileImagePath,
      nickname: nickname ?? this.nickname,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
    );
  }

  // 상태를 직관적으로 출력할 수 있도록 toString 메서드 재정의
  @override
  String toString() {
    return 'ProfileModel(profileImagePath: $profileImagePath, nickname: $nickname, birthDate: $birthDate, gender: $gender)';
  }
}

class ProfileController extends StateNotifier<ProfileModel> {
  ProfileController() : super(ProfileModel());

  final ImagePicker _picker = ImagePicker();

  // 프로필 사진 선택
  Future<void> pickProfileImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      state = state.copyWith(profileImagePath: image.path);
    }
  }

  // 닉네임 업데이트
  void setNickname(String nickname) {
    state = state.copyWith(nickname: nickname);
  }

  // 생일 업데이트
  void setBirthDate(DateTime birthDate) {
    state = state.copyWith(birthDate: birthDate);
  }

  // 성별 업데이트
  void setGender(String gender) {
    state = state.copyWith(gender: gender);
  }
}

// Profile 상태를 관리하는 provider
final profileProvider = StateNotifierProvider<ProfileController, ProfileModel>(
  (ref) => ProfileController(),
);
