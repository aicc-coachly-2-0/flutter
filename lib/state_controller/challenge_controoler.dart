// challenge_upload_state.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChallengeUploadState {
  final String missionTitle;
  final String? imagePath;
  final int participants;
  final String selectedMissionType; // 미션 종류
  final List<String> selectedTasks; // 선택된 미션 항목들
  final String selectedDuration; // 미션 수행 기간
  final String selectedFrequency; // 인증 빈도
  final int weeklyCount; // 주간 인증 횟수
  final DateTime? missionStartDate; // 미션 시작일
  final String missionDescription; // 미션 설명
  final int pointsFor100Percent; // 100% 완주 시 포인트
  final int pointsFor80Percent; // 80% 완주 시 포인트
  final int pointsFor50Percent; // 50% 완주 시 포인트

  ChallengeUploadState({
    this.missionTitle = '',
    this.imagePath,
    this.participants = 0,
    this.selectedMissionType = '',
    this.selectedTasks = const [],
    this.selectedDuration = '',
    this.selectedFrequency = '',
    this.weeklyCount = 0,
    this.missionStartDate,
    this.missionDescription = '',
    this.pointsFor100Percent = 0,
    this.pointsFor80Percent = 0,
    this.pointsFor50Percent = 0,
  });

  ChallengeUploadState copyWith({
    String? missionTitle,
    String? imagePath,
    int? participants,
    String? selectedMissionType,
    List<String>? selectedTasks,
    String? selectedDuration,
    String? selectedFrequency,
    int? weeklyCount,
    DateTime? missionStartDate,
    String? missionDescription,
    int? pointsFor100Percent,
    int? pointsFor80Percent,
    int? pointsFor50Percent,
  }) {
    return ChallengeUploadState(
      missionTitle: missionTitle ?? this.missionTitle,
      imagePath: imagePath ?? this.imagePath,
      participants: participants ?? this.participants,
      selectedMissionType: selectedMissionType ?? this.selectedMissionType,
      selectedTasks: selectedTasks ?? this.selectedTasks,
      selectedDuration: selectedDuration ?? this.selectedDuration,
      selectedFrequency: selectedFrequency ?? this.selectedFrequency,
      weeklyCount: weeklyCount ?? this.weeklyCount,
      missionStartDate: missionStartDate ?? this.missionStartDate,
      missionDescription: missionDescription ?? this.missionDescription,
      pointsFor100Percent: pointsFor100Percent ?? this.pointsFor100Percent,
      pointsFor80Percent: pointsFor80Percent ?? this.pointsFor80Percent,
      pointsFor50Percent: pointsFor50Percent ?? this.pointsFor50Percent,
    );
  }

  // 상태 초기화
  ChallengeUploadState reset() {
    return ChallengeUploadState();
  }
}

class ChallengeUploadNotifier extends StateNotifier<ChallengeUploadState> {
  ChallengeUploadNotifier() : super(ChallengeUploadState());

  void setMissionTitle(String title) {
    state = state.copyWith(missionTitle: title);
  }

  void setImage(String imagePath) {
    state = state.copyWith(imagePath: imagePath);
  }

  void setParticipants(int participants) {
    state = state.copyWith(participants: participants);
  }

  void setMissionType(String missionType) {
    state = state.copyWith(selectedMissionType: missionType, selectedTasks: []);
  }

  void toggleTask(String task) {
    List<String> updatedTasks = List.from(state.selectedTasks);
    if (updatedTasks.contains(task)) {
      updatedTasks.remove(task);
    } else {
      updatedTasks.add(task);
    }
    state = state.copyWith(selectedTasks: updatedTasks);
  }

  void setDuration(String duration) {
    state = state.copyWith(selectedDuration: duration);
  }

  void setFrequency(String frequency) {
    state = state.copyWith(selectedFrequency: frequency);
  }

  void setWeeklyCount(int count) {
    state = state.copyWith(weeklyCount: count);
  }

  void setMissionStartDate(DateTime startDate) {
    state = state.copyWith(missionStartDate: startDate);
  }

  void setMissionDescription(String description) {
    state = state.copyWith(missionDescription: description);
  }

  void setPointsFor100Percent(int points) {
    state = state.copyWith(pointsFor100Percent: points);
  }

  void setPointsFor80Percent(int points) {
    state = state.copyWith(pointsFor80Percent: points);
  }

  void setPointsFor50Percent(int points) {
    state = state.copyWith(pointsFor50Percent: points);
  }

  // 상태 초기화
  void reset() {
    state = state.reset();
  }
}

final challengeUploadProvider =
    StateNotifierProvider<ChallengeUploadNotifier, ChallengeUploadState>(
  (ref) => ChallengeUploadNotifier(),
);
