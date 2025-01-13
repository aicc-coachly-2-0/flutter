import 'dart:convert';
import 'package:flutter_application_test/state_controller/loginProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

// FutureProvider로 질문 목록 가져오기
final myQuestionsProvider = FutureProvider<List<Question>>((ref) async {
  final user = ref.read(authProvider);
  final apiUrl =
      '${dotenv.env['API_BASE_URL']}/qnas/users/${user?.userNumber}/questions';

  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer ${user?.token}',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      // 필터링: 상태가 "pending"인 질문만 추출
      return responseData
          .where((question) => question['state'] == 'pending')
          .map((question) => Question.fromJson(question))
          .toList();
    } else {
      throw Exception('Failed to load questions');
    }
  } catch (e) {
    throw Exception('Error fetching questions: $e');
  }
});

// answeredQuestionsProvider: 답변 완료된 질문 목록
final answeredQuestionsProvider = FutureProvider<List<Question>>((ref) async {
  final user = ref.read(authProvider);
  final apiUrl =
      '${dotenv.env['API_BASE_URL']}/qnas/users/${user?.userNumber}/questions';

  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer ${user?.token}',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      // 필터링: 상태가 "answered"인 질문만 추출
      return responseData
          .where((question) => question['state'] == 'answered')
          .map((question) => Question.fromJson(question))
          .toList();
    } else {
      throw Exception('Failed to load questions');
    }
  } catch (e) {
    throw Exception('Error fetching questions: $e');
  }
});

// FutureProvider로 답변 목록 가져오기
final answersProvider =
    FutureProvider.family<List<Answer>, int>((ref, questionNumber) async {
  final apiUrl =
      '${dotenv.env['API_BASE_URL']}/qnas/questions/$questionNumber/answers';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      return responseData.map((answer) => Answer.fromJson(answer)).toList();
    } else {
      throw Exception('Failed to load answers');
    }
  } catch (e) {
    throw Exception('Error fetching answers: $e');
  }
});

// Question 모델 클래스
class Question {
  final int questionNumber;
  final int userNumber;
  final int questionClassificationNumber; // 필드 이름에 맞게 수정
  final String title;
  final String questionContent;
  final String createdAt;
  final String updatedAt;
  final String state;

  Question({
    required this.questionNumber,
    required this.userNumber,
    required this.questionClassificationNumber,
    required this.title,
    required this.questionContent,
    required this.createdAt,
    required this.updatedAt,
    required this.state,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionNumber: json['question_number'],
      userNumber: json['user_number'],
      questionClassificationNumber:
          json['question_classification_number'], // 필드 이름에 맞게 수정
      title: json['title'],
      questionContent: json['question_content'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      state: json['state'],
    );
  }
}

// Answer 모델 클래스
class Answer {
  final int answerNumber;
  final int questionNumber;
  final String answerContent;
  final String answerAt;
  final String state;

  Answer({
    required this.answerNumber,
    required this.questionNumber,
    required this.answerContent,
    required this.answerAt,
    required this.state,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      answerNumber: json['answer_number'],
      questionNumber: json['question_number'],
      answerContent: json['answer_content'],
      answerAt: json['answer_at'],
      state: json['state'],
    );
  }
}
