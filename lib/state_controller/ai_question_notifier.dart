import 'package:flutter_riverpod/flutter_riverpod.dart'; // 변경된 임포트

// ExerciseLevelNotifier와 Provider 설정 예시
// 운동 레벨 상태 관리
class ExerciseLevelNotifier extends StateNotifier<String?> {
  ExerciseLevelNotifier() : super(null);

  void setExerciseLevel(String? level) {
    state = level;
  }
}

final exerciseLevelProvider =
    StateNotifierProvider<ExerciseLevelNotifier, String?>(
  (ref) => ExerciseLevelNotifier(),
);

// 운동 장소 상태 관리
class SelectPlaceNotifier extends StateNotifier<String?> {
  SelectPlaceNotifier() : super(null);

  // 선택된 운동 장소 설정 함수
  void setSelectedPlace(String? place) {
    state = place; // 선택된 운동 장소 저장
  }
}

final exercisePlaceProvider =
    StateNotifierProvider<SelectPlaceNotifier, String?>(
  (ref) => SelectPlaceNotifier(),
);

// 일주일 운동 횟수 상태 관리
class ExerciseFrequencyNotifier extends StateNotifier<String?> {
  ExerciseFrequencyNotifier() : super(null);

  // 선택된 운동 장소 설정 함수
  void setExerciseFrequency(String? frequency) {
    state = frequency; // 선택된 운동 장소 저장
  }

  // 상태 초기화
  void reset() {
    state = null;
  }
}

final exerciseFrequencyProvider =
    StateNotifierProvider<ExerciseFrequencyNotifier, String?>(
  (ref) => ExerciseFrequencyNotifier(),
);

// 운동 목표 상태 관리
class ExerciseGoalNotifier extends StateNotifier<String?> {
  ExerciseGoalNotifier() : super(null);

  // 선택된 운동 장소 설정 함수
  void setExerciseGoal(String? goal) {
    state = goal; // 선택된 운동 장소 저장
  }

  // 상태 초기화
  void reset() {
    state = null;
  }
}

final exerciseGoalProvider =
    StateNotifierProvider<ExerciseGoalNotifier, String?>(
  (ref) => ExerciseGoalNotifier(),
);

// 운동 초점 상태 관리
class FocusOnExerciseNotifier extends StateNotifier<Set<String>> {
  FocusOnExerciseNotifier() : super({});

  // 운동 초점 선택
  void toggleFocus(String focus) {
    if (state.contains(focus)) {
      state = {...state}..remove(focus); // 이미 선택된 항목은 취소
    } else if (state.length < 3) {
      state = {...state}..add(focus); // 최대 3개까지만 선택 가능
    }
  }

  // 상태 초기화
  void reset() {
    state = {};
  }
}

// FocusOnExercise 상태 관리 프로바이더
final focusOnExerciseProvider =
    StateNotifierProvider<FocusOnExerciseNotifier, Set<String>>((ref) {
  return FocusOnExerciseNotifier();
});

// 나이 상태 관리
class AgeNotifier extends StateNotifier<String?> {
  AgeNotifier() : super(null);

  void setAge(String? age) {
    state = age; // 나이 상태 설정
  }

  void reset() {
    state = null; // 나이 초기화
  }
}

final ageProvider = StateNotifierProvider<AgeNotifier, String?>(
  (ref) => AgeNotifier(),
);

// 성별 상태 관리
class GenderNotifier extends StateNotifier<String?> {
  GenderNotifier() : super(null);

  void setGender(String? gender) {
    state = gender; // 성별 상태 설정
  }

  void reset() {
    state = null; // 성별 초기화
  }
}

final genderProvider = StateNotifierProvider<GenderNotifier, String?>(
  (ref) => GenderNotifier(),
);

// 키 상태 관리
class HeightNotifier extends StateNotifier<String?> {
  HeightNotifier() : super(null);

  void setHeight(String? height) {
    state = height; // 키 상태 설정
  }

  void reset() {
    state = null; // 키 초기화
  }
}

final heightProvider = StateNotifierProvider<HeightNotifier, String?>(
  (ref) => HeightNotifier(),
);

// 몸무게 상태 관리
class WeightNotifier extends StateNotifier<String?> {
  WeightNotifier() : super(null);

  void setWeight(String? weight) {
    state = weight; // 몸무게 상태 설정
  }

  void reset() {
    state = null; // 몸무게 초기화
  }
}

final weightProvider = StateNotifierProvider<WeightNotifier, String?>(
  (ref) => WeightNotifier(),
);

// 부상 여부를 관리할 Notifier 클래스
class InjuryStatusNotifier extends StateNotifier<Map<String, bool>> {
  InjuryStatusNotifier() : super({});

  // 부상 부위 초기화
  void initializeInjuryStatus(List<String> bodyParts) {
    state = {
      for (var part in bodyParts) part: false,
    };
  }

  // 부상 부위 상태 토글
  void toggleInjuryStatus(String bodyPart) {
    state = {
      ...state,
      bodyPart: !(state[bodyPart] ?? false),
    };
  }
}

// 부상 상태를 관리하는 Provider
final injuryStatusProvider =
    StateNotifierProvider<InjuryStatusNotifier, Map<String, bool>>(
  (ref) => InjuryStatusNotifier(),
);

// 운동 능력 상태 관리 (새로 추가된 부분)
class ExerciseAbilityNotifier extends StateNotifier<String?> {
  ExerciseAbilityNotifier() : super(null);

  // 운동 능력 설정 함수
  void setExerciseAbility(String? ability) {
    state = ability;
  }

  // 상태 초기화
  void reset() {
    state = null;
  }
}

final exerciseAbilityProvider =
    StateNotifierProvider<ExerciseAbilityNotifier, String?>(
  (ref) => ExerciseAbilityNotifier(),
);
