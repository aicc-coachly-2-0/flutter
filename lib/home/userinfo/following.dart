import 'package:flutter/material.dart';

class Following extends StatefulWidget {
  const Following({super.key});

  @override
  _FollowingState createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
  // 팔로잉 상태를 관리하는 리스트 (예시)
  List<Map<String, String>> followers = [
    {'name': 'User1', 'image': 'assets/image1.png', 'isFollowing': 'true'},
    {'name': 'User2', 'image': 'assets/image2.png', 'isFollowing': 'false'},
    {'name': 'User3', 'image': 'assets/image3.png', 'isFollowing': 'true'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: followers.length,
        itemBuilder: (context, index) {
          final follower = followers[index];
          bool isFollowing = follower['isFollowing'] == 'true';
          return ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(follower['image']!),
            ),
            title: Text(
              follower['name']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: isFollowing
                    ? Colors.white // 팔로잉일 때 텍스트 색상
                    : const Color.fromARGB(255, 255, 176, 123),
                backgroundColor: isFollowing
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
                  follower['isFollowing'] = isFollowing ? 'false' : 'true';
                });
              },
              child: Text(
                isFollowing ? '팔로잉' : '팔로우',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isFollowing
                      ? Colors.white
                      : const Color.fromARGB(255, 255, 176, 123),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
