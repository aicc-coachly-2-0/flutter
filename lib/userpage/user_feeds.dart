// user_feed.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_test/get_method/user_feed_get.dart';
import 'package:flutter_application_test/state_controller/loginProvider.dart'; // authProvider
import 'package:flutter_application_test/userpage/feed_check.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserFeeds extends ConsumerWidget {
  UserFeeds({super.key});

  final FeedService feedService = FeedService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Feed>>(
          future: feedService.fetchFeeds(ref), // Feed 데이터를 비동기적으로 가져옴
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('에러가 발생했습니다: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('피드가 없습니다.'));
            } else {
              final feeds = snapshot.data!;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2.0,
                  mainAxisSpacing: 2.0,
                ),
                itemCount: feeds.length,
                itemBuilder: (context, index) {
                  final feed = feeds[index];
                  final imageUrl = '${dotenv.env['FTP_URL']}${feed.imgNumber}';

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FeedCheck(feed: feed), // feed 객체 전달
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
              );
            }
          },
        ),
      ),
    );
  }
}
