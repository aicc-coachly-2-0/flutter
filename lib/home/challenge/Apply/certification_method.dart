import 'package:flutter/material.dart';

class CertificationMethod extends StatelessWidget {
  const CertificationMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('인증 방법',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCertificationImage(
                'assets/yes.jpeg', 'O', '피트니스 앱 화면을 날짜와 함께 캡쳐해 인증하기'),
            _buildCertificationImage(
                'assets/no.jpeg', 'X', '날짜가 보이지 않는 사진, 인증과 관계없는 사진 중복사진 사용 등'),
          ],
        ),
      ],
    );
  }

  Widget _buildCertificationImage(
      String imagePath, String status, String description) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.asset(imagePath, width: 180, height: 180),
              Container(
                width: 180,
                color: status == 'O' ? Colors.green : Colors.red,
                child: Text(
                  status,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(description,
              style: TextStyle(fontSize: 12), textAlign: TextAlign.start),
        ],
      ),
    );
  }
}
