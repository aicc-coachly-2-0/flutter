import 'package:flutter/material.dart';
import 'package:flutter_application_test/community/Notice/notice_detail_page.dart';
import 'package:flutter_application_test/get_method/notice_get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoticeSection extends ConsumerWidget {
  const NoticeSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<Notice>>(
      future: getNotices(), // getNotices() 호출하여 데이터 가져오기
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('공지사항을 불러오는 데 실패했습니다.'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('활성화된 공지사항이 없습니다.'));
        } else {
          final notices = snapshot.data!;
          // 최근 3개의 공지사항만 추출
          final recentNotices = notices.take(3).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "공지사항",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Divider(thickness: 1.5),
              // 공지사항 리스트 생성
              ...List.generate(recentNotices.length, (index) {
                return Column(
                  children: [
                    ListTile(
                      title: Row(
                        children: [
                          const Text(
                            '[공지]',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 111, 97),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(recentNotices[index].title), // 실제 공지 제목 사용
                        ],
                      ),
                      onTap: () {
                        // 공지사항을 클릭하면 상세 페이지로 이동
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NoticeDetailPage(
                              notice: recentNotices[index],
                            ),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                  ],
                );
              }),
            ],
          );
        }
      },
    );
  }
}
