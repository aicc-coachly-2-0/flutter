import 'package:flutter/material.dart';
import 'package:flutter_application_test/state_controller/ai_question_notifier.dart';
import 'package:flutter_application_test/ai_questions_pt/injury_check.dart';
import 'package:flutter_application_test/home/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonalInfoPage extends ConsumerWidget {
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 각 상태를 가져옴
    final age = ref.watch(ageProvider);
    final gender = ref.watch(genderProvider);
    final height = ref.watch(heightProvider);
    final weight = ref.watch(weightProvider);

    void onAgeSelected(String age) {
      ref.read(ageProvider.notifier).setAge(age); // age 상태 업데이트
    }

    void onGenderSelected(String gender) {
      ref.read(genderProvider.notifier).setGender(gender); // gender 상태 업데이트
    }

    void onHeightSelected(String height) {
      ref.read(heightProvider.notifier).setHeight(height); // height 상태 업데이트
    }

    void onWeightSelected(String weight) {
      ref.read(weightProvider.notifier).setWeight(weight); // weight 상태 업데이트
    }

    // "다음" 버튼 클릭 시 실행되는 함수 (다음 질문 페이지로 이동)
    void onNext() {
      // 값들이 null이 아닌지 확인
      print("Age: $age, Gender: $gender, Height: $height, Weight: $weight");

      if (age == null || gender == null || height == null || weight == null) {
        // 하나라도 비어 있으면 경고
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("모든 정보를 입력해주세요"),
              content: const Text("나이, 성별, 키, 몸무게를 모두 입력한 후 진행해주세요."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 다이얼로그 닫기
                  },
                  child: const Text("확인"),
                ),
              ],
            );
          },
        );
      } else {
        // 정보가 입력되었으면 InjuryPage로 이동
        print("페이지 이동을 시작합니다.");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const InjuryPage(),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "개인 정보 입력",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 111, 97), // 부드러운 색상
        elevation: 2,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Homepage(),
                ),
              );
            },
            child: const Text(
              "다음에 이용하기",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Text(
              "나이, 성별, 키, 몸무게를 입력해주세요.",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // 나이 선택
            _buildInputCard(
              context,
              title: "나이",
              child: DropdownButton<String>(
                value: age,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    ref.read(ageProvider.notifier).setAge(newValue);
                  }
                },
                items: List.generate(50, (index) {
                  final ageValue = (index + 1).toString();
                  return DropdownMenuItem<String>(
                    value: ageValue,
                    child: Text('$ageValue 세'),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // 성별 선택
            _buildInputCard(
              context,
              title: "성별",
              child: DropdownButton<String>(
                value: gender,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    ref.read(genderProvider.notifier).setGender(newValue);
                  }
                },
                items: <String>['남성', '여성']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // 키 선택
            _buildInputCard(
              context,
              title: "키",
              child: DropdownButton<String>(
                value: height,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    ref.read(heightProvider.notifier).setHeight(newValue);
                  }
                },
                items: List.generate(71, (index) {
                  final heightValue = (130 + index).toString();
                  return DropdownMenuItem<String>(
                    value: heightValue,
                    child: Text('$heightValue cm'),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // 몸무게 선택
            _buildInputCard(
              context,
              title: "몸무게",
              child: DropdownButton<String>(
                value: weight,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    ref.read(weightProvider.notifier).setWeight(newValue);
                  }
                },
                items: List.generate(111, (index) {
                  final weightValue = (30 + index).toString();
                  return DropdownMenuItem<String>(
                    value: weightValue,
                    child: Text('$weightValue kg'),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),

            // "다음" 버튼
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton(
                onPressed: onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color.fromARGB(255, 255, 111, 97), // 핑크색 배경
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "다음",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 입력 항목 카드 생성
  Widget _buildInputCard(BuildContext context,
      {required String title, required Widget child}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}
