import 'package:flutter/material.dart';
import 'package:flutter_application_test/community/board_upload.dart';
import 'package:flutter_application_test/community/widgets/board_button.dart';
import 'package:flutter_application_test/community/widgets/hot_post_widget.dart';
import 'package:flutter_application_test/home/hot_posts.dart';

class MainCommunity extends StatelessWidget {
  const MainCommunity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "다양한 주제로 소통해요~~",
                style: TextStyle(
                    fontSize: 15, color: Color.fromARGB(255, 170, 170, 170)),
              ),
              const SizedBox(height: 10),
              const Text(
                "커뮤니티 보러가기",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return BoardButton(index: index); // 게시판 버튼 호출
                },
              ),
              const SizedBox(height: 10),
              const HotPosts()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BoardUpload(),
            ),
          );
        },
        backgroundColor: const Color.fromARGB(255, 255, 111, 97),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
