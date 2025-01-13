// user_feed.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_test/get_method/user_feed_get.dart';
import 'package:flutter_application_test/userpage/User/feeds_check.dart';
import 'package:flutter_application_test/userpage/feed_check.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UsersFeeds extends StatelessWidget {
  final List<Map<String, dynamic>> userFeedData;

  UsersFeeds({super.key, required this.userFeedData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: userFeedData.isEmpty
            ? const Center(child: Text('피드가 없습니다.'))
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2.0,
                  mainAxisSpacing: 2.0,
                ),
                itemCount: userFeedData.length,
                itemBuilder: (context, index) {
                  final feedData = userFeedData[index];
                  final feed = Feed.fromJson(feedData); // JSON -> Feed 객체로 변환
                  final imageUrl = '${dotenv.env['FTP_URL']}${feed.imgNumber}';

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FeedsCheck(feed: feed), // Feed 객체 전달
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
