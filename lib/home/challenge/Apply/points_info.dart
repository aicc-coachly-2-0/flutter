// import 'package:flutter/material.dart';
// import 'package:flutter_application_test/home/challenge/all_mission_get.dart'; // Mission 모델 임포트

// class PointsInfo extends StatelessWidget {
//   final Mission mission; // Mission 객체를 전달받도록 수정

//   const PointsInfo({required this.mission, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: const Color.fromARGB(255, 255, 224, 193), // 옅은 베이지색 배경
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildPointRow('100% 완주 시 받는 포인트',
//               '${mission.fullCompletionPoints}P'), // 실제 포인트 데이터로 변경
//           SizedBox(height: 8),
//           _buildPointRow('80% 완주 시 받는 포인트',
//               '${mission.eightyPercentCompletionPoints}P'), // 실제 포인트 데이터로 변경
//           SizedBox(height: 8),
//           _buildPointRow('50% 완주 시 받는 포인트',
//               '${mission.fiftyPercentCompletionPoints}P'), // 실제 포인트 데이터로 변경
//         ],
//       ),
//     );
//   }

//   Row _buildPointRow(String title, String points) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//               fontSize: 16, color: Color.fromARGB(244, 159, 159, 159)),
//         ),
//         Text(
//           points,
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//       ],
//     );
//   }
// }
