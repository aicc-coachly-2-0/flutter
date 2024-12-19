import 'package:flutter_riverpod/flutter_riverpod.dart';

// 식단 목표 상태 관리
class DietGoalNotifier extends StateNotifier<String?> {
  DietGoalNotifier() : super(null);

  // 선택된 식단 목표 저장 함수
  void setDietGoal(String? goal) {
    state = goal;
  }

  // 상태 초기화
  void reset() {
    state = null;
  }
}

final dietGoalProvider =
    StateNotifierProvider<DietGoalNotifier, String?>((ref) {
  return DietGoalNotifier();
});

// 하루 몇 끼 상태 관리
class MealFrequencyNotifier extends StateNotifier<String?> {
  MealFrequencyNotifier() : super(null);

  // 선택된 식사 빈도 저장 함수
  void setMealFrequency(String? frequency) {
    state = frequency;
  }

  // 상태 초기화
  void reset() {
    state = null;
  }
}

final mealFrequencyProvider =
    StateNotifierProvider<MealFrequencyNotifier, String?>((ref) {
  return MealFrequencyNotifier();
});

// 활동량 상태 관리
class ActivityLevelNotifier extends StateNotifier<String?> {
  ActivityLevelNotifier() : super(null);

  // 선택된 활동량 저장 함수
  void setActivityLevel(String? level) {
    state = level;
  }

  // 상태 초기화
  void reset() {
    state = null;
  }
}

final activityLevelProvider =
    StateNotifierProvider<ActivityLevelNotifier, String?>((ref) {
  return ActivityLevelNotifier();
});

class FoodPreferenceNotifier extends StateNotifier<List<String>> {
  FoodPreferenceNotifier() : super([]);

  // 선택된 음식 선호 저장 함수
  void toggleFoodPreference(String preference) {
    // 이미 선택된 음식이 있다면 제거하고, 없으면 추가
    if (state.contains(preference)) {
      state = [...state]..remove(preference); // 선택 해제
    } else {
      state = [...state, preference]; // 선택 추가
    }
  }

  // 상태 초기화
  void reset() {
    state = [];
  }
}

final foodPreferenceProvider =
    StateNotifierProvider<FoodPreferenceNotifier, List<String>>((ref) {
  return FoodPreferenceNotifier();
});

// 알레르기나 주의할 음식 상태 관리
class AllergyNotifier extends StateNotifier<String?> {
  AllergyNotifier() : super(null);

  // 알레르기 정보 설정
  void setAllergy(String? allergy) {
    state = allergy;
  }

  // 상태 초기화
  void reset() {
    state = null;
  }
}

// 채식주의자 여부 상태 관리
class VegetarianNotifier extends StateNotifier<bool?> {
  VegetarianNotifier() : super(null);

  // 채식 여부 설정
  void setVegetarian(bool? isVegetarian) {
    state = isVegetarian;
  }

  // 상태 초기화
  void reset() {
    state = null;
  }
}

// 다이어트 식단 상태 관리
class DietPlanNotifier extends StateNotifier<List<String>> {
  DietPlanNotifier() : super([]);

  // 선택된 다이어트 식단 추가/제거
  void toggleDietPlan(String dietPlan) {
    if (state.contains(dietPlan)) {
      state = [...state]..remove(dietPlan);
    } else {
      state = [...state, dietPlan];
    }
  }

  // 상태 초기화
  void reset() {
    state = [];
  }
}

// 상태 관리 프로바이더 설정
final allergyProvider = StateNotifierProvider<AllergyNotifier, String?>((ref) {
  return AllergyNotifier();
});

final vegetarianProvider =
    StateNotifierProvider<VegetarianNotifier, bool?>((ref) {
  return VegetarianNotifier();
});

final dietPlanProvider =
    StateNotifierProvider<DietPlanNotifier, List<String>>((ref) {
  return DietPlanNotifier();
});

// 1. 하루 섭취 목표 칼로리 상태 관리
class CalorieGoalNotifier extends StateNotifier<String?> {
  CalorieGoalNotifier() : super(null);

  void setCalorieGoal(String? goal) {
    state = goal;
  }

  void reset() {
    state = null;
  }
}

// 2. 식사 준비 시간 상태 관리
class MealPrepTimeNotifier extends StateNotifier<String?> {
  MealPrepTimeNotifier() : super(null);

  void setMealPrepTime(String? time) {
    state = time;
  }

  void reset() {
    state = null;
  }
}

// 3. 외식 여부 상태 관리
class DiningOutNotifier extends StateNotifier<bool?> {
  DiningOutNotifier() : super(null);

  void setDiningOut(bool? diningOut) {
    state = diningOut;
  }

  void reset() {
    state = null;
  }
}

// 상태 관리 프로바이더들
final calorieGoalProvider =
    StateNotifierProvider<CalorieGoalNotifier, String?>((ref) {
  return CalorieGoalNotifier();
});

final mealPrepTimeProvider =
    StateNotifierProvider<MealPrepTimeNotifier, String?>((ref) {
  return MealPrepTimeNotifier();
});

final diningOutProvider =
    StateNotifierProvider<DiningOutNotifier, bool?>((ref) {
  return DiningOutNotifier();
});

// 1. 간식 자주 섭취 여부 상태 관리
class SnackFrequencyNotifier extends StateNotifier<String?> {
  SnackFrequencyNotifier() : super(null);

  void setSnackFrequency(String? frequency) {
    state = frequency;
  }

  void reset() {
    state = null;
  }
}

// 2. 현재 몸무게 상태 관리
class CurrentWeightNotifier extends StateNotifier<double> {
  CurrentWeightNotifier() : super(70.0); // 초기값 (예: 70kg)

  void setCurrentWeight(double weight) {
    state = weight;
  }

  void reset() {
    state = 70.0; // 초기값 리셋
  }
}

// 3. 목표 몸무게 상태 관리
class GoalWeightNotifier extends StateNotifier<double> {
  GoalWeightNotifier() : super(70.0); // 초기값 (예: 70kg)

  void setGoalWeight(double weight) {
    state = weight;
  }

  void reset() {
    state = 70.0; // 초기값 리셋
  }
}

// 4. 혈당 관리 여부 상태 관리
class BloodSugarControlNotifier extends StateNotifier<bool?> {
  BloodSugarControlNotifier() : super(null);

  void setBloodSugarControl(bool? control) {
    state = control;
  }

  void reset() {
    state = null;
  }
}

// 5. 운동 빈도 상태 관리
class ExerciseFrequencyNotifier extends StateNotifier<String?> {
  ExerciseFrequencyNotifier() : super(null);

  void setExerciseFrequency(String? frequency) {
    state = frequency;
  }

  void reset() {
    state = null;
  }
}

// 상태 관리 프로바이더들
final snackFrequencyProvider =
    StateNotifierProvider<SnackFrequencyNotifier, String?>((ref) {
  return SnackFrequencyNotifier();
});

final currentWeightProvider =
    StateNotifierProvider<CurrentWeightNotifier, double>((ref) {
  return CurrentWeightNotifier();
});

final goalWeightProvider =
    StateNotifierProvider<GoalWeightNotifier, double>((ref) {
  return GoalWeightNotifier();
});

final bloodSugarControlProvider =
    StateNotifierProvider<BloodSugarControlNotifier, bool?>((ref) {
  return BloodSugarControlNotifier();
});

final dietExerciseFrequencyProvider =
    StateNotifierProvider<ExerciseFrequencyNotifier, String?>((ref) {
  return ExerciseFrequencyNotifier();
});

class ExerciseTypeNotifier extends StateNotifier<String?> {
  ExerciseTypeNotifier() : super(null);

  // 운동 종류 설정
  void setExerciseType(String? exerciseType) {
    state = exerciseType;
  }

  // 상태 초기화
  void reset() {
    state = null;
  }
}

final exerciseTypeProvider =
    StateNotifierProvider<ExerciseTypeNotifier, String?>(
  (ref) => ExerciseTypeNotifier(),
);

class PostExerciseMealNotifier extends StateNotifier<String?> {
  PostExerciseMealNotifier() : super(null);

  // 운동 후 회복을 위한 식사 여부 설정
  void setPostExerciseMeal(String? meal) {
    state = meal;
  }

  // 상태 초기화
  void reset() {
    state = null;
  }
}

final postExerciseMealProvider =
    StateNotifierProvider<PostExerciseMealNotifier, String?>(
  (ref) => PostExerciseMealNotifier(),
);

class SleepDurationNotifier extends StateNotifier<String?> {
  SleepDurationNotifier() : super(null);

  // 잠자는 시간 설정
  void setSleepDuration(String? sleepDuration) {
    state = sleepDuration;
  }

  // 상태 초기화
  void reset() {
    state = null;
  }
}

final sleepDurationProvider =
    StateNotifierProvider<SleepDurationNotifier, String?>(
  (ref) => SleepDurationNotifier(),
);

class FoodStressLevelNotifier extends StateNotifier<String?> {
  FoodStressLevelNotifier() : super(null);

  // 음식 스트레스 수준 설정
  void setFoodStressLevel(String? stressLevel) {
    state = stressLevel;
  }

  // 상태 초기화
  void reset() {
    state = null;
  }
}

final foodStressLevelProvider =
    StateNotifierProvider<FoodStressLevelNotifier, String?>(
  (ref) => FoodStressLevelNotifier(),
);

class AlcoholConsumptionNotifier extends StateNotifier<String?> {
  AlcoholConsumptionNotifier() : super(null);

  // 음주 여부 설정
  void setAlcoholConsumption(String? consumption) {
    state = consumption;
  }

  // 상태 초기화
  void reset() {
    state = null;
  }
}

final alcoholConsumptionProvider =
    StateNotifierProvider<AlcoholConsumptionNotifier, String?>(
  (ref) => AlcoholConsumptionNotifier(),
);

class MealEnvironmentNotifier extends StateNotifier<String?> {
  MealEnvironmentNotifier() : super(null);

  // 식사 환경 설정
  void setMealEnvironment(String? environment) {
    state = environment;
  }

  // 상태 초기화
  void reset() {
    state = null;
  }
}

final mealEnvironmentProvider =
    StateNotifierProvider<MealEnvironmentNotifier, String?>(
  (ref) => MealEnvironmentNotifier(),
);

class MealPreferencesNotifier extends StateNotifier<String?> {
  MealPreferencesNotifier() : super(null);

  // 식사 관련 원하는 점 설정
  void setMealPreferences(String? preferences) {
    state = preferences;
  }

  // 상태 초기화
  void reset() {
    state = null;
  }
}

final mealPreferencesProvider =
    StateNotifierProvider<MealPreferencesNotifier, String?>(
  (ref) => MealPreferencesNotifier(),
);

// 로딩 상태를 관리하는 StateNotifier
class LoadingStateNotifier extends StateNotifier<bool> {
  LoadingStateNotifier() : super(false);

  void startLoading() => state = true;
  void stopLoading() => state = false;
}

final loadingStateProvider =
    StateNotifierProvider<LoadingStateNotifier, bool>((ref) {
  return LoadingStateNotifier();
});

class AiFoodQuestionsNotifier extends StateNotifier<AiFoodQuestionsState> {
  AiFoodQuestionsNotifier() : super(AiFoodQuestionsState());

  // 로딩 상태 시작
  void startLoading() {
    state = state.copyWith(isLoading: true);
  }

  // 로딩 상태 종료
  void stopLoading() {
    state = state.copyWith(isLoading: false);
  }

  // AI 답변 설정
  void setAnswer(String answer) {
    state = state.copyWith(answer: answer);
  }
}

// aiFoodQuestionsNotifier 프로바이더 정의
final aiFoodQuestionsNotifier =
    StateNotifierProvider<AiFoodQuestionsNotifier, AiFoodQuestionsState>(
  (ref) => AiFoodQuestionsNotifier(),
);

class AiFoodQuestionsState {
  final bool isLoading;
  final String? answer;

  AiFoodQuestionsState({this.isLoading = false, this.answer});

  AiFoodQuestionsState copyWith({bool? isLoading, String? answer}) {
    return AiFoodQuestionsState(
      isLoading: isLoading ?? this.isLoading,
      answer: answer ?? this.answer,
    );
  }
}
