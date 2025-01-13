import 'package:flutter/material.dart';

class SortingSection extends StatelessWidget {
  const SortingSection({super.key});

  @override
  Widget build(BuildContext context) {
    String selectedSorting = '최신순'; // 정렬 방식
    String selectedUserFilter = '전체유저'; // 사용자 필터 방식

    return Row(
      children: [
        // 최신순 드롭다운 버튼
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Color.fromARGB(255, 255, 111, 97),
              width: 1,
            ),
          ),
          child: DropdownButton<String>(
            value: selectedSorting,
            onChanged: (String? newValue) {
              selectedSorting = newValue!;
            },
            items: <String>['최신순', '인기순']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            underline: Container(),
            icon: const Icon(Icons.arrow_drop_down),
            style: const TextStyle(color: Colors.black),
            iconSize: 24,
            elevation: 16,
            dropdownColor: Colors.white,
          ),
        ),
        const SizedBox(width: 20),
        // 전체유저 / 팔로우만 드롭다운 버튼
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Color.fromARGB(255, 255, 111, 97),
              width: 1,
            ),
          ),
          child: DropdownButton<String>(
            value: selectedUserFilter,
            onChanged: (String? newValue) {
              selectedUserFilter = newValue!;
            },
            items: <String>['전체유저', '팔로우만']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            underline: Container(),
            icon: const Icon(Icons.arrow_drop_down),
            style: const TextStyle(color: Colors.black),
            iconSize: 24,
            elevation: 16,
            dropdownColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
