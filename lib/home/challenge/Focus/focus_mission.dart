import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/challenge/DeadLine/deadline_mission_get.dart';
import 'package:flutter_application_test/home/challenge/DeadLine/detail_deadline_mission.dart';
import 'package:flutter_application_test/home/challenge/Focus/detail_focus_mission.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FocusMission extends StatelessWidget {
  const FocusMission({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            '다양한 미션들을 만나보세요 !',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black38,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '지금 주목받는 미션',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailFocusMission(),
                  ),
                );
              },
            ),
          ],
        ),

        // FutureBuilder로 비동기적으로 데이터를 가져오고 UI에 반영
        FutureBuilder<List<Mission>>(
          future: fetchUpcomingMissions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('에러: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('미션이 없습니다.'));
            } else {
              final missions = snapshot.data!;
              return SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: missions.length,
                  itemBuilder: (context, index) {
                    final mission = missions[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                color: Colors.grey[300],
                                child: Image.network(
                                  '${dotenv.env['FTP_URL']}${mission.imgLink}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Text(
                                  '👥 ${mission.participantCount}명',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            '시작 날짜: ${mission.startedAt}',
                            style: TextStyle(
                              fontSize: 14,
                              color: const Color.fromARGB(255, 255, 126, 51),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            mission.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            mission.duration,
                            style:
                                TextStyle(fontSize: 8, color: Colors.black54),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
