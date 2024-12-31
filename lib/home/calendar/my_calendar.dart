import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarUpdate extends StatefulWidget {
  const CalendarUpdate({super.key});

  @override
  _CalendarUpdateState createState() => _CalendarUpdateState();
}

class _CalendarUpdateState extends State<CalendarUpdate> {
  late Map<DateTime, List<String>> _selectedEvents; // 날짜에 해당하는 운동 기록 리스트
  late DateTime _focusedDay; // 현재 화면에 표시되는 날짜
  late DateTime _selectedDay; // 선택된 날짜

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
    _selectedEvents = {};
  }

  // 운동을 기록하는 팝업창을 띄우는 함수
  void _showAddEventDialog(BuildContext context) {
    TextEditingController eventController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('운동 기록 추가'),
          content: TextField(
            controller: eventController,
            decoration: InputDecoration(hintText: '운동 기록을 입력하세요'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // 다이얼로그 닫기
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (eventController.text.isNotEmpty) {
                    if (_selectedEvents[_selectedDay] != null) {
                      _selectedEvents[_selectedDay]!.add(eventController.text);
                    } else {
                      _selectedEvents[_selectedDay] = [eventController.text];
                    }
                  }
                });
                Navigator.pop(context); // 다이얼로그 닫기
              },
              child: Text('등록'),
            ),
          ],
        );
      },
    );
  }

  // 선택된 날짜의 운동 기록을 보여주는 위젯
  List<Widget> _getEventsForDay(DateTime day) {
    final events = _selectedEvents[day] ?? [];
    return events.map((event) => ListTile(title: Text(event))).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('운동 기록 달력'),
      ),
      body: Column(
        children: [
          // TableCalendar 위젯
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2025, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              // 선택된 날짜인지 여부를 반환
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: _getEventsForDay,
          ),
          const SizedBox(height: 8.0),

          // 운동 기록 리스트
          Expanded(
            child: ListView(
              children: _getEventsForDay(_selectedDay),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEventDialog(context), // 운동 기록 추가 버튼
        child: Icon(Icons.add),
      ),
    );
  }
}
