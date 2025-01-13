import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/challenge/all_mission_get.dart'; // Mission 모델 임포트
import 'package:flutter_application_test/home/challenge/detail_mission_get.dart'; // MissionDetails 모델 임포트
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_test/get_method/user_info_get.dart'; // UserInfo 모델 임포트

class MissionDetailsWidget extends ConsumerStatefulWidget {
  final Mission mission; // mission 객체를 받도록 수정

  const MissionDetailsWidget({required this.mission, super.key});

  @override
  _MissionDetailsWidgetState createState() => _MissionDetailsWidgetState();
}

class _MissionDetailsWidgetState extends ConsumerState<MissionDetailsWidget> {
  late Future<MissionDetails> missionDetails;
  late Future<UserInfo> userInfo; // UserInfo를 가져오기 위한 변수

  @override
  void initState() {
    super.initState();
    // mission에서 roomNumber를 가져와서 fetchMissionDetails 함수 호출
    missionDetails = fetchMissionDetails(ref, widget.mission.roomNumber);
    // authProvider에서 UserInfo를 가져오는 비동기 작업
    userInfo = fetchUserDetails(ref);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserInfo>(
      future: userInfo, // UserInfo를 먼저 받아옴
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white),
              ),
              SizedBox(width: 8),
              Text(
                widget.mission.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              CircularProgressIndicator(), // 로딩 중에 CircularProgressIndicator 표시
            ],
          );
        }

        if (userSnapshot.hasError) {
          return Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white),
              ),
              SizedBox(width: 8),
              Text(
                widget.mission.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text('사용자 정보를 불러올 수 없습니다.'), // 사용자 정보를 불러오는 데 실패했을 때 표시
            ],
          );
        }

        if (!userSnapshot.hasData) {
          return Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white),
              ),
              SizedBox(width: 8),
              Text(
                widget.mission.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text('사용자 정보가 없습니다.'), // 사용자 정보가 없을 경우 표시
            ],
          );
        }

        final user = userSnapshot.data!; // 성공적으로 받은 UserInfo
        // 미션 세부 정보를 가져오는 FutureBuilder
        return FutureBuilder<MissionDetails>(
          future: missionDetails, // MissionDetails를 가져오는 future
          builder: (context, missionSnapshot) {
            if (missionSnapshot.connectionState == ConnectionState.waiting) {
              return Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  SizedBox(width: 8),
                  Text(
                    widget.mission.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  CircularProgressIndicator(), // 로딩 중에 CircularProgressIndicator 표시
                ],
              );
            }

            if (missionSnapshot.hasError) {
              return Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  SizedBox(width: 8),
                  Text(
                    widget.mission.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text('미션 세부 정보를 불러올 수 없습니다.'), // 미션 정보를 불러오는 데 실패했을 때 표시
                ],
              );
            }

            if (!missionSnapshot.hasData) {
              return Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  SizedBox(width: 8),
                  Text(
                    widget.mission.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text('미션 상세 정보를 불러올 수 없습니다.'), // 미션 데이터가 없을 경우 표시
                ],
              );
            }

            final missionDetails = missionSnapshot.data!; // 미션 세부 정보
            // 미션과 사용자 정보를 정상적으로 받아왔을 때 화면에 표시
            return Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(
                      '${dotenv.env['FTP_URL']}${widget.mission.usersImgLink}'), // 이미지 링크를 받아와서 표시
                ),
                SizedBox(width: 8),
                Text(
                  missionDetails.roomCreatorName, // 미션 제목
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(Icons.people, size: 16, color: Colors.black),
                    SizedBox(width: 4),
                    Text(
                      ': ${missionDetails.participantCount}명', // 참여자 수를 미션 객체에서 받아옴
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
