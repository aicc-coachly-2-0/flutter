import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/payment/payment_widget.dart';

class PaymentAgree extends StatelessWidget {
  const PaymentAgree({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentAgreement(
            onAgreementComplete: () {
              // 결제 로직 실행
              print("동의 완료 후 결제 진행");
            },
          ),
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("결제 동의"),
        backgroundColor: const Color.fromARGB(255, 255, 111, 97),
      ),
      body: const Center(
        child: CircularProgressIndicator(), // 초기 로딩 화면
      ),
    );
  }
}

class PaymentAgreement extends StatefulWidget {
  final VoidCallback onAgreementComplete;

  const PaymentAgreement({super.key, required this.onAgreementComplete});

  @override
  State<PaymentAgreement> createState() => _PaymentAgreementState();
}

class _PaymentAgreementState extends State<PaymentAgreement> {
  bool _allAgreed = false;
  bool _term1Agreed = false;
  bool _term2Agreed = false;

  void _updateAllAgreed(bool value) {
    setState(() {
      _allAgreed = value;
      _term1Agreed = value;
      _term2Agreed = value;
    });
  }

  void _updateIndividualAgreed() {
    setState(() {
      _allAgreed = _term1Agreed && _term2Agreed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("이용약관 동의"),
        backgroundColor: const Color.fromARGB(255, 255, 111, 97),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: _allAgreed,
                  onChanged: (value) {
                    _updateAllAgreed(value!);
                  },
                ),
                const Text(
                  '전체 약관에 동의합니다.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Checkbox(
                  value: _term1Agreed,
                  onChanged: (value) {
                    setState(() {
                      _term1Agreed = value!;
                      _updateIndividualAgreed();
                    });
                  },
                ),
                const Expanded(
                  child: Text(
                    '이용약관 동의 (필수)',
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: _term2Agreed,
                  onChanged: (value) {
                    setState(() {
                      _term2Agreed = value!;
                      _updateIndividualAgreed();
                    });
                  },
                ),
                const Expanded(
                  child: Text(
                    '개인정보 처리방침 동의 (필수)',
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _allAgreed
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PaymentWidget(),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color.fromARGB(255, 255, 111, 97),
              ),
              child: const Text(
                '동의하고 결제하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
