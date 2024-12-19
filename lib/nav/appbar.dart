// import 'package:flutter/material.dart';
// import 'package:flutter_application_test/nav/sidebar.dart'; // 사이드바 임포트

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;

//   const CustomAppBar({super.key, required this.title});

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight); // 앱바의 높이

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       automaticallyImplyLeading: false, // 기본 뒤로가기 버튼 제거
//       backgroundColor: const Color(0xFFFEF9EB), // 원하는 앱바 색상
//       title: Text(title), // 외부에서 전달받은 title을 표시
//       actions: [
//         // 메뉴 아이콘 추가
//         // IconButton(
//         //   icon: const Icon(Icons.menu), // 메뉴 아이콘
//         //   onPressed: () {
//         //     // 메뉴 버튼 클릭 시 사이드바 열기
//         //     Scaffold.of(context).openDrawer();
//         //   },
//         // ),
//       ],
//     );
//   }
// }
