import 'package:flutter/material.dart';

class PaymentSuccess extends StatelessWidget {
  final String receiptId;
  final String subscriptionId;
  final String userId;

  const PaymentSuccess({
    Key? key,
    required this.receiptId,
    required this.subscriptionId,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            Text('구독 ID: $subscriptionId', style: const TextStyle(fontSize: 16)),
            Text('사용자 ID: $userId', style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
