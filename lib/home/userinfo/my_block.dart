import 'package:flutter/material.dart';

class MyBlock extends StatefulWidget {
  const MyBlock({super.key});

  @override
  _BlockState createState() => _BlockState();
}

class _BlockState extends State<MyBlock> {
  // 팔로잉 상태를 관리하는 리스트 (예시)
  List<Map<String, String>> blcok_users = [
    {'name': 'User1', 'image': 'assets/image.png', 'isBlock': 'true'},
    {'name': 'User2', 'image': 'assets/image.png', 'isFollowing': 'false'},
    {'name': 'User3', 'image': 'assets/image.png', 'isBlock': 'true'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('나의 차단 목록'), // 탭에 맞는 타이틀 표시
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: blcok_users.length,
        itemBuilder: (context, index) {
          final blockUser = blcok_users[index];
          bool isBlock = blockUser['isBlock'] == 'true';
          return ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(blockUser['image']!),
            ),
            title: Text(
              blockUser['name']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                maximumSize: Size(100, 40), // 버튼 크기 고정 (너비 100, 높이 40)
                minimumSize: Size(100, 40), // 버튼 크기 고정 (너비 100, 높이 40)
                foregroundColor: isBlock
                    ? Colors.white // 팔로잉일 때 텍스트 색상
                    : const Color.fromARGB(255, 255, 176, 123),
                backgroundColor: isBlock
                    ? const Color.fromARGB(255, 255, 176, 123) // 팔로잉일 때 배경색
                    : Colors.white, // 팔로우일 때 텍스트 색상
                side: BorderSide(
                  color: const Color.fromARGB(255, 255, 176, 123), // 테두리 색상
                  width: 1.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onPressed: () {
                setState(() {
                  // 팔로우/팔로잉 상태 변경
                  blockUser['isBlock'] = isBlock ? 'false' : 'true';
                });
              },
              child: Text(
                isBlock ? '차단 해제' : '차단하기',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isBlock
                      ? Colors.white
                      : const Color.fromARGB(255, 255, 176, 123),
                ),
                softWrap: false, // 줄 바꿈 하지 않음
                maxLines: 1, // 텍스트가 1줄로만 표시되도록 설정
              ),
            ),
          );
        },
      ),
    );
  }
}
