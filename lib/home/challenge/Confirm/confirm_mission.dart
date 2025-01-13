import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/challenge/Confirm/mission_bottom_sheet.dart';
import 'package:flutter_application_test/home/challenge/Confirm/my_confirm.dart';
import 'package:flutter_application_test/home/challenge/Confirm/users_confirm.dart';
import 'package:flutter_application_test/home/challenge/Mymission/my_mission_get.dart';
import 'package:flutter_application_test/home/challenge/challenge_bottom_bar.dart';
import 'package:flutter_application_test/nav/report_mission_button.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'mission_progress_bar.dart';
import 'mission_tabs.dart';

class ConfirmMission extends StatefulWidget {
  final ParticipatingMission participatingmission;

  const ConfirmMission({required this.participatingmission, super.key});

  @override
  _ConfirmMissionState createState() => _ConfirmMissionState();
}

class _ConfirmMissionState extends State<ConfirmMission>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final roomNumber = widget.participatingmission.roomNumber; // roomNumber

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.participatingmission.title,
            style: TextStyle(color: Colors.black)),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) {
                  return ReportMissionButton();
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[300],
                  child: widget.participatingmission.missionImgLink.isNotEmpty
                      ? Image.network(
                          '${dotenv.env['FTP_URL']}${widget.participatingmission.missionImgLink}',
                          fit: BoxFit.cover)
                      : Icon(Icons.image, size: 100, color: Colors.white),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Text(
                    widget.participatingmission.title,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '인증기간: ${_formatDate(widget.participatingmission.startedAt)} ~ ${_formatDate(widget.participatingmission.endedAt)}',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    Text(
                      '인증가능: ${widget.participatingmission.certFreq}',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('인증방법 및 유의사항',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.black54),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return ChallengeBottomBar();
                      },
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.65),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            MissionTabs(tabController: _tabController),
            SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildFeedTab(roomNumber), // roomNumber 전달
                  _buildCommunityTab(roomNumber),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: ElevatedButton(
          onPressed: () {
            // 인증하기 버튼 클릭 시 BottomSheet 열기
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return BottomSheetImagePicker(
                    roomNumber: roomNumber); // 사진 선택 BottomSheet
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 255, 126, 51),
            padding: EdgeInsets.symmetric(vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          child:
              Text('인증하기', style: TextStyle(fontSize: 16, color: Colors.white)),
        ),
      ),
    );
  }

  // roomNumber를 전달하는 방법
  Widget _buildFeedTab(int roomNumber) {
    return Center(child: MyConfirm(roomNumber: roomNumber)); // roomNumber 전달
  }

  Widget _buildCommunityTab(int roomNumber) {
    return Center(child: UsersConfirm(roomNumber: roomNumber));
  }

  String _formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('yyyy-MM-dd').format(parsedDate);
  }
}
