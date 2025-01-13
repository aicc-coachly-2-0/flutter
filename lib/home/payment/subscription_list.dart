import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // intl 패키지 추가

class SubscriptionList extends StatefulWidget {
  final int userNumber;

  const SubscriptionList({super.key, required this.userNumber});

  @override
  _SubscriptionListState createState() => _SubscriptionListState();
}

class _SubscriptionListState extends State<SubscriptionList> {
  List<dynamic> historySubscriptions = [];
  List<dynamic> activeSubscriptions = [];

  @override
  void initState() {
    super.initState();
    fetchSubscriptions();
  }

  Future<void> fetchSubscriptions() async {
    final String url =
        'http://localhost:8000/subscription/list/${widget.userNumber}'; // API URL 수정
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          // 'cancelled' 상태인 구독만 historySubscriptions에 저장
          historySubscriptions = data
              .where((subscription) => subscription['state'] == 'cancelled')
              .toList();

          // 'active' 상태인 구독만 activeSubscriptions에 저장
          activeSubscriptions = data
              .where((subscription) =>
                  subscription['state'] == 'active' ||
                  subscription['state'] == 'inactive')
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

  Future<void> refundSubscription(
      dynamic subscriptionId, int userNumber) async {
    const String url =
        'http://localhost:8000/subscription/refund'; // 구독 취소 API 엔드포인트

    try {
      print('구독 취소 요청 시작: $subscriptionId, $userNumber');
      final refundData = {
        'user_number': userNumber.toString(),
        'subscription_id': subscriptionId,
      };

      final response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(refundData));
      // 상태 코드와 응답 로그 출력
      print('응답 상태 코드: ${response.statusCode}');
      print('응답 바디: ${response.body}');

      if (response.statusCode == 200) {
        final Map<dynamic, dynamic> responseData = json.decode(response.body);

        // 응답에서 구독 정보 확인
        print('구독 정보: $responseData');

        print('구독 취소 완료');
        // 최신 구독 목록을 가져오기 위해 fetchSubscriptions 호출
        await fetchSubscriptions();
      } else {
        throw Exception('구독 취소 실패');
      }
    } catch (error) {
      print('구독 취소 중 오류 발생: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('내 구독 내역'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 현재 구독중
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            "구독중",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    activeSubscriptions.isEmpty
                        ? const Center(child: Text('현재 구독 중인 서비스가 없습니다.'))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: activeSubscriptions.length,
                            itemBuilder: (context, index) {
                              final subscription = activeSubscriptions[index];
                              final formattedStartDate =
                                  formatDate(subscription['created_at']);
                              final formattedExpirationDate =
                                  formatDate(subscription['expiration_date']);

                              return Card(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  title: Text(
                                      subscription['name'] ?? 'AI Service'),
                                  subtitle: Text(
                                      '구독 시작일: $formattedStartDate\n만료일: $formattedExpirationDate'),
                                  trailing: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      if (subscription['state'] == 'active')
                                        TextButton(
                                          onPressed: () async {
                                            // 구독 취소 API 호출
                                            await refundSubscription(
                                                subscription['subscription_id'],
                                                widget.userNumber);
                                          },
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.red,
                                          ),
                                          child: const Text('구독 취소'),
                                        ),
                                      if (subscription['state'] == 'inactive')
                                        const Text(
                                          '요청 확인중',
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 14),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
              // 히스토리 구독 내역
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            "구독 내역",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    historySubscriptions.isEmpty
                        ? const Center(child: Text('구독 내역이 없습니다.'))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: historySubscriptions.length,
                            itemBuilder: (context, index) {
                              final subscription = historySubscriptions[index];
                              final formattedStartDate =
                                  formatDate(subscription['created_at']);
                              final formattedExpirationDate =
                                  formatDate(subscription['expiration_date']);
                              return Card(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  title: Text(
                                      subscription['name'] ?? 'AI Service'),
                                  subtitle: Text(
                                      '구독 시작일: $formattedStartDate\n만료일: $formattedExpirationDate'),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
