import 'package:flutter/material.dart';

class HotPostWidget extends StatelessWidget {
  final String boardName;
  final String postTitle;

  const HotPostWidget({
    super.key,
    required this.boardName,
    required this.postTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            boardName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 111, 97),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            postTitle,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
