import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_test/state_controller/loginProvider.dart'; // authProvider 가져오기

class PaymentSuccess extends ConsumerWidget {
  final String receiptId;

  const PaymentSuccess({
    super.key,
    required this.receiptId,
  });

  // 백엔드로 결제 정보 전송 함수
  Future<void> sendPaymentInfoToBackend(BuildContext context) async {
    const endpoint = 'http://localhost:8080/lookup-billingkey'; // 실제 서버 URL로 수정
    final uri = Uri.parse(endpoint);

    // 결제 정보를 담은 데이터 객체
    final paymentData = {
      'receiptId': receiptId,
      // 필요한 다른 데이터가 있다면 여기에 추가 가능
    };

    try {
      // HTTP POST 요청
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(paymentData), // JSON 데이터 전송
      );
      print("$paymentData");

      if (response.statusCode == 200) {
        print('결제 정보 전송 성공: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('결제 정보가 성공적으로 전송되었습니다.')),
        );
      } else {
        print(
            '결제 정보 전송 실패: 상태 코드: ${response.statusCode}, 응답: ${response.body}');
        throw Exception('결제 정보 전송 실패');
      }
    } catch (error) {
      print('백엔드 요청 중 오류 발생: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('결제 정보 전송 중 오류가 발생했습니다.')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 로그인된 사용자 정보를 authProvider에서 가져오기
    // final user = ref.watch(authProvider);

    // 결제 정보를 백엔드로 전송
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await sendPaymentInfoToBackend(context);
      } catch (error) {
        print("결제 정보 전송 오류: $error");
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("결제 성공"),
        backgroundColor: const Color.fromARGB(255, 255, 111, 97),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '결제가 성공적으로 완료되었습니다!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text('영수증 ID: $receiptId', style: const TextStyle(fontSize: 16)),
            // 추가적으로 결제 관련 정보를 UI로 보여줄 수 있습니다.
          ],
        ),
      ),
    );
  }
}
