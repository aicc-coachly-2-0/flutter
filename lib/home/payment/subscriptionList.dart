import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SubscriptionList extends StatefulWidget {
  final int userNumber;

  const SubscriptionList({Key? key, required this.userNumber})
      : super(key: key);

  @override
  _SubscriptionListState createState() => _SubscriptionListState();
}

class _SubscriptionListState extends State<SubscriptionList> {
  List<dynamic> subscriptionList = [];

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
          subscriptionList = data.isEmpty ? [] : data;
        });
      } else {
        throw Exception('구독 정보 조회 실패');
      }
    } catch (error) {
      print('구독 정보 조회 중 오류 발생: $error');
    }
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
        child: subscriptionList.isEmpty
            ? const Center(child: Text('현재 구독 정보가 없습니다.'))
            : ListView.builder(
                itemCount: subscriptionList.length,
                itemBuilder: (context, index) {
                  final subscription = subscriptionList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text('구독 서비스: ${subscription['service_name']}'),
                      subtitle: Text('구독 시작일: ${subscription['start_date']}'),
                      trailing: Text('상태: ${subscription['status']}'),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
