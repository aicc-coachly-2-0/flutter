import 'package:flutter/material.dart';

class Frequencyquestion extends StatelessWidget {
  const Frequencyquestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('자주 묻는 질문'),
      ),
      body: ListView(
        children: [
          // 첫 번째 질문 섹션
          ExpansionTile(
            title: Text(
              'Q1. 앱 사용 방법은 어떻게 되나요?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Icon(
              Icons.arrow_drop_down, // 밑을 가리키는 화살표 아이콘
              color: Colors.grey,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '앱 사용 방법은 간단합니다. 첫 화면에서 제공되는 기능을 이용하여 원하는 작업을 수행할 수 있습니다. 각 기능에 대한 자세한 설명은 앱 내 도움말에서 확인할 수 있습니다.',
                ),
              ),
            ],
          ),
          // 두 번째 질문 섹션
          ExpansionTile(
            title: Text(
              'Q2. 계정 정보를 수정하려면 어떻게 하나요?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Icon(
              Icons.arrow_drop_down, // 밑을 가리키는 화살표 아이콘
              color: Colors.grey,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '계정 정보는 설정 메뉴에서 수정할 수 있습니다. 이메일, 비밀번호, 프로필 정보 등 모든 항목을 변경할 수 있습니다.',
                ),
              ),
            ],
          ),
          // 세 번째 질문 섹션
          ExpansionTile(
            title: Text(
              'Q3. 비밀번호를 잊어버렸습니다. 어떻게 해야 하나요?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Icon(
              Icons.arrow_drop_down, // 밑을 가리키는 화살표 아이콘
              color: Colors.grey,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '비밀번호를 잊어버렸다면, 로그인 화면에서 "비밀번호 찾기" 버튼을 클릭하여 이메일을 통해 비밀번호를 재설정할 수 있습니다.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
