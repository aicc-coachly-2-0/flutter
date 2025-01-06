import 'package:flutter/material.dart';
import 'faq_service.dart'; // FAQ 데이터를 가져오는 서비스 임포트
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Frequencyquestion extends ConsumerWidget {
  const Frequencyquestion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // FAQ 서비스 인스턴스화
    final FaqService faqService = FaqService();

    return Scaffold(
      appBar: AppBar(
        title: Text('자주 묻는 질문'),
      ),
      body: FutureBuilder<List<Faq>>(
        // FAQ 데이터를 비동기적으로 가져옴
        future:
            faqService.fetchFaqs(ref), // ref를 통해 authProvider에 접근하여 유저 정보 전달
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 로딩 중일 때 로딩 인디케이터 표시
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // 오류 발생 시 오류 메시지 표시
            return Center(child: Text('오류 발생: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // 데이터가 없을 경우 빈 화면 표시
            return Center(child: Text('FAQ 항목이 없습니다.'));
          } else {
            // FAQ 데이터가 있을 경우 리스트로 표시
            List<Faq> faqs = snapshot.data!;

            return ListView.builder(
              itemCount: faqs.length,
              itemBuilder: (context, index) {
                Faq faq = faqs[index];
                return ExpansionTile(
                  title: Text(
                    'Q${index + 1}. ${faq.content}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    Icons.arrow_drop_down, // 밑을 가리키는 화살표 아이콘
                    color: Colors.grey,
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(faq.answer),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
