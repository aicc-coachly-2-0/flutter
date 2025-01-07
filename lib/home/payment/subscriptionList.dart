import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // intl 패키지 추가

class SubscriptionList extends StatefulWidget {
  final int userNumber;

  const SubscriptionList({Key? key, required this.userNumber})
      : super(key: key);

  @override
  _SubscriptionListState createState() => _SubscriptionListState();
}

class _SubscriptionListState extends State<SubscriptionList> {
  List<dynamic> activeSubscriptions = [];
  List<dynamic> historySubscriptions = [];

  @override
  void initState() {
    super.initState();
    fetchSubscriptions();
  }

  Future<void> fetchSubscriptions() async {
    final String url =
        'http://localhost:8000/api/subscription/${widget.userNumber}'; // API URL 수정
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          // 구독 상태에 따라 active와 history로 분리
          activeSubscriptions = data
              .where((subscription) => subscription['state'] == 'active')
              .toList();
          historySubscriptions = data
              .where((subscription) => subscription['state'] == 'inactive')
              .toList();
        });
      } else {
        throw Exception('구독 정보 조회 실패');
      }
    } catch (error) {
      print('구독 정보 조회 중 오류 발생: $error');
    }
  }

  // 날짜 포맷 변환 함수
  String formatDate(String dateStr) {
    final DateTime date = DateTime.parse(dateStr);
    final DateFormat formatter = DateFormat('yyyy-MM-dd'); // yyyy-MM-dd 형식
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내 구독 내역'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // '구독 중' 제목 왼쪽 정렬
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    "구독중",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              activeSubscriptions.isEmpty
                  ? const Center(child: Text('현재 구독 중인 서비스가 없습니다.'))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: activeSubscriptions.length,
                          itemBuilder: (context, index) {
                            final subscription = activeSubscriptions[index];
                            final formattedStartDate =
                                formatDate(subscription['created_at']);
                            final formattedExpirationDate = formatDate(
                                subscription['expiration_date']); // 날짜 포맷
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                title: const Text('AI Service'),
                                subtitle: Text(
                                    '구독 시작일: $formattedStartDate\n만료일: $formattedExpirationDate'), // 포맷된 시작일 및 만료일
                                trailing: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    // 구독 취소 버튼
                                    if (subscription['state'] == 'active')
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            subscription['state'] =
                                                'inactive'; // 상태 변경
                                          });
                                          // 구독 취소 후, 상태를 inactive로 업데이트하고 만료일을 표시
                                          print('구독 취소됨');
                                        },
                                        child: const Text('구독 취소'),
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.red,
                                        ),
                                      ),
                                    // 구독 취소 후 만료일 표시
                                    if (subscription['state'] == 'inactive')
                                      Text(
                                        '만료일: $formattedExpirationDate',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
              // const Divider(),
              // '히스토리' 제목 왼쪽 정렬
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    "히스토리",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              historySubscriptions.isEmpty
                  ? const Center(child: Text('히스토리 정보가 없습니다.'))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: historySubscriptions.length,
                          itemBuilder: (context, index) {
                            final subscription = historySubscriptions[index];
                            final formattedStartDate =
                                formatDate(subscription['created_at']);
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                title: Text('AI Service'),
                                subtitle: Text(
                                    '구독 시작일: $formattedStartDate'), // 포맷된 시작일
                                trailing: Text('상태: ${subscription['state']}'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
