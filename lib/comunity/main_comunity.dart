import 'package:flutter/material.dart';
import 'package:flutter_application_test/comunity/free_comunity.dart';

class MainCommunity extends StatelessWidget {
  const MainCommunity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 공지사항 섹션
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "공지사항",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      // 공지사항 페이지로 이동하는 코드 나중에 작성
                      print('공지사항 페이지로 이동');
                    },
                    child: const Text('More', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              const Divider(thickness: 1.5), // 공지사항과 다른 섹션을 구분하는 선
              // 공지사항 리스트 (최대 3개)
              Column(
                children: List.generate(3, (index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text('공지사항 제목 ${index + 1}'),
                      ),
                      const Divider(), // 각 공지사항을 구분하는 선
                    ],
                  );
                }),
              ),
              const SizedBox(height: 20),

              // 인기글 섹션
              const Text(
                "인기글",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // 인기글 리스트 (최대 5개)
              Column(
                children: List.generate(5, (index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12.0),
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        child: Text('P${index + 1}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      title: Text('인기글 제목 ${index + 1}'),
                      subtitle: Text('게시판: 인기글${index + 1}'),
                      onTap: () {
                        // 해당 인기글 페이지로 이동하는 코드 나중에 작성
                        print('인기글 ${index + 1} 페이지로 이동');
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),

              // 게시판 섹션
              const Text(
                "게시판",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // 게시판 목록을 ListView로 구성
              ListView(
                shrinkWrap: true, // 이 리스트는 내부 스크롤만 가능하게 만듭니다.
                physics:
                    const NeverScrollableScrollPhysics(), // 외부 스크롤과 중복되지 않게 설정
                children: [
                  _buildBoardButton(context, "자유"),
                  _buildBoardButton(context, "익명"),
                  _buildBoardButton(context, "오운완"),
                  _buildBoardButton(context, "러닝"),
                  _buildBoardButton(context, "헬린이"),
                  _buildBoardButton(context, "식단"),
                  _buildBoardButton(context, "챌린지"),
                  _buildBoardButton(context, "공지사항"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 게시판 버튼 생성
  Widget _buildBoardButton(BuildContext context, String boardName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        title: TextButton(
          onPressed: () {
            if (boardName == "자유") {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const FreeCommunity()), // 자유게시판 페이지로 이동
              );
            }
            // 해당 게시판 페이지로 이동하는 코드 나중에 작성
            print('$boardName 게시판으로 이동');
          },
          child: Text(
            boardName,
            style: const TextStyle(fontSize: 18, color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
