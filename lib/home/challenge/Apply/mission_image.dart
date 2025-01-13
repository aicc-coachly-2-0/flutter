import 'package:flutter/material.dart';

class MissionImage extends StatelessWidget {
  const MissionImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      color: Colors.grey[300], // 이미지를 대신하는 색
      child: Icon(
        Icons.image, // 이미지 아이콘
        size: 80,
        color: Colors.white,
      ),
    );
  }
}
