import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 임포트
import 'package:flutter_application_test/get_method/community_get.dart'; // Post 클래스 임포트

class AnonymousImage extends StatelessWidget {
  final Post post;

  const AnonymousImage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final imageUrl = '${dotenv.env['FTP_URL']}${post.imgPath}';

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        imageUrl, // FTP에서 가져온 게시글 이미지 URL
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
      ),
    );
  }
}
