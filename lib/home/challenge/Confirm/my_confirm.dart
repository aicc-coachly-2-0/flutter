import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/challenge/Confirm/detail_my_cofirm.dart';
import 'package:flutter_application_test/state_controller/loginProvider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class MyConfirm extends ConsumerStatefulWidget {
  final int roomNumber;

  const MyConfirm({super.key, required this.roomNumber});

  @override
  _MyConfirmState createState() => _MyConfirmState();
}

class _MyConfirmState extends ConsumerState<MyConfirm> {
  late Future<List<Map<String, dynamic>>> _validationList;

  @override
  void initState() {
    super.initState();
    final user = ref.read(authProvider); // 로그인된 사용자 정보 가져오기
    if (user != null) {
      _validationList = fetchValidations(user.userNumber, widget.roomNumber);
    } else {
      // 로그인되지 않은 경우 처리
      _validationList = Future.value([]);
    }
  }

  // 인증샷 목록을 API에서 가져오는 함수
  Future<List<Map<String, dynamic>>> fetchValidations(
      int userNumber, int roomNumber) async {
    final url =
        'http://localhost:8080/missions/rooms/$roomNumber/my-validations/$userNumber';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> validations = data['data'];
      return validations.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load validations');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _validationList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No validation images available.'));
            } else {
              final validations = snapshot.data!;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 한 줄에 3개의 이미지를 표시
                  crossAxisSpacing: 8.0, // 이미지 간 간격
                  mainAxisSpacing: 8.0, // 세로 간 간격
                  childAspectRatio: 1.0, // 네모난 형태로 설정 (가로 세로 비율)
                ),
                itemCount: validations.length,
                itemBuilder: (context, index) {
                  final validation = validations[index];
                  final validationImageUrl =
                      '${dotenv.env['FTP_URL']}${validation['validation_img_link']}';
                  final userImageUrl =
                      '${dotenv.env['FTP_URL']}${validation['user_img_link']}';
                  final userName = validation['user_name'];

                  return GestureDetector(
                    onTap: () {
                      // 클릭 시 DetailMyConfirm 페이지로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailMyConfirm(
                            userImageUrl: userImageUrl,
                            userName: userName,
                            validationImageUrl: validationImageUrl,
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        validationImageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
