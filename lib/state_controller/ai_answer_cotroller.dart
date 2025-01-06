import 'package:flutter_riverpod/flutter_riverpod.dart';

final aiDietAnswersProvider =
    StateNotifierProvider<AiDietAnswersNotifier, List<String>>((ref) {
  return AiDietAnswersNotifier();
});

class AiDietAnswersNotifier extends StateNotifier<List<String>> {
  AiDietAnswersNotifier() : super([]);

  // 답변 추가
  void addAnswer(String answer) {
    state = [...state, answer];
  }

  // 특정 인덱스의 식단 정보를 반환
  String getAnswerByIndex(int index) {
    if (index >= 0 && index < state.length) {
      return state[index];
    } else {
      return ''; // 유효하지 않은 인덱스일 경우 빈 문자열 반환
    }
  }

  // 특정 식사(아침, 점심, 저녁, 간식)에 해당하는 텍스트 부분만 반환
  String getMealPart(String meal) {
    if (state.isEmpty) {
      return '';
    }

    // 텍스트 전체를 하나의 문자열로 결합
    String fullAnswer = state.join('\n');
    // meal (예: '아침', '점심')을 기준으로 해당 식사의 텍스트를 잘라서 반환
    final mealStart = fullAnswer.indexOf(meal);
    if (mealStart == -1) {
      return ''; // 식사를 찾지 못했을 경우 빈 문자열 반환
    }

    final mealEnd = _getNextMealStart(fullAnswer, mealStart + meal.length);
    return fullAnswer.substring(mealStart, mealEnd).trim();
  }

  // 다음 식사(아침, 점심, 저녁, 간식)의 시작 인덱스를 찾는 함수
  int _getNextMealStart(String fullAnswer, int startIndex) {
    final meals = ['아침', '점심', '저녁', '간식'];
    int nextMealStart = fullAnswer.length;

    for (var meal in meals) {
      final mealIndex = fullAnswer.indexOf(meal, startIndex);
      if (mealIndex != -1 && mealIndex < nextMealStart) {
        nextMealStart = mealIndex;
      }
    }
    return nextMealStart;
  }
}

final aiExerciseAnswersProvider =
    StateNotifierProvider<AiExerciseAnswersNotifier, List<String>>((ref) {
  return AiExerciseAnswersNotifier();
});

class AiExerciseAnswersNotifier extends StateNotifier<List<String>> {
  AiExerciseAnswersNotifier() : super([]);

  // 답변 추가
  void addAnswer(String answer) {
    state = [...state, answer];
  }

  // 특정 인덱스의 운동 루틴을 반환
  String getAnswerByIndex(int index) {
    if (index >= 0 && index < state.length) {
      return state[index];
    } else {
      return ''; // 유효하지 않은 인덱스일 경우 빈 문자열 반환
    }
  }

  // 특정 요일(월요일, 화요일, 수요일 등)에 해당하는 운동 루틴만 반환
  String getExercisePart(String day) {
    if (state.isEmpty) {
      return '';
    }

    // 텍스트 전체를 하나의 문자열로 결합
    String fullAnswer = state.join('\n');
    // 요일(예: '월요일', '화요일')을 기준으로 해당 요일의 운동 루틴을 잘라서 반환
    final dayStart = fullAnswer.indexOf(day);
    if (dayStart == -1) {
      return ''; // 요일을 찾지 못했을 경우 빈 문자열 반환
    }

    final dayEnd = _getNextDayStart(fullAnswer, dayStart + day.length);
    return fullAnswer.substring(dayStart, dayEnd).trim();
  }

  // 다음 요일(월요일, 화요일, 수요일 등)의 시작 인덱스를 찾는 함수
  int _getNextDayStart(String fullAnswer, int startIndex) {
    final days = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];
    int nextDayStart = fullAnswer.length;

    for (var day in days) {
      final dayIndex = fullAnswer.indexOf(day, startIndex);
      if (dayIndex != -1 && dayIndex < nextDayStart) {
        nextDayStart = dayIndex;
      }
    }
    return nextDayStart;
  }
}
