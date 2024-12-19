import 'package:flutter/material.dart';

class VideoTime extends StatefulWidget {
  const VideoTime({super.key});

  @override
  State<VideoTime> createState() => _VideoTimeState();
}

class _VideoTimeState extends State<VideoTime> {
  // 초기 아이템 수
  int _itemCount = 4;

  // 색상 리스트
  List<Color> colors = [
    Colors.blue,
    Colors.yellow,
    Colors.teal,
    Colors.red,
  ];

  // PageController
  final PageController _pageController = PageController();

  // 페이지 변경 시 호출되는 메서드
  void _onPageChanged(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 150),
      curve: Curves.linear,
    );

    // 마지막 페이지에 도달하면 아이템 추가
    if (page == _itemCount - 1) {
      setState(() {
        _itemCount += 4;
        colors.addAll([
          Colors.black,
          Colors.yellow,
          Colors.teal,
          Colors.white,
        ]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical, // 세로 스크롤
      itemCount: _itemCount, // 아이템 수
      onPageChanged: _onPageChanged, // 페이지 변경 처리
      itemBuilder: (context, index) => Container(
        color: colors[index], // 각 페이지의 색상
        child: Center(
          child: Text('Screen $index'), // 화면 인덱스 텍스트
        ),
      ),
    );
  }
}
