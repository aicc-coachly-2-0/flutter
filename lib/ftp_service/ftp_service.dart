import 'dart:io';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FtpService {
  Future<File> downloadProfileImage(String userId) async {
    final ftpServer = dotenv.env['FTP_BASE_URL'];
    final ftpUser = dotenv.env['FTP_USER'];
    final ftpPassword = dotenv.env['FTP_PASSWORD'];
    final ftpPort = int.tryParse(dotenv.env['FTP_PORT'] ?? '2100') ?? 2100;

    FTPConnect ftpConnect = FTPConnect(
      ftpServer ?? '',
      user: ftpUser ?? '',
      pass: ftpPassword ?? '',
      port: ftpPort,
    );

    try {
      await ftpConnect.connect();
      print('FTP 연결 성공');

      // 파일 경로
      final filePath = '/coachly/profile/user_$userId.jpg';
      final file = File('/path/to/save/user_$userId.jpg'); // 로컬 저장 경로 설정

      // FTP에서 파일 다운로드
      await ftpConnect.downloadFile(filePath, file);

      ftpConnect.disconnect();
      return file;
    } catch (e) {
      print('이미지 다운로드 실패: $e');
      throw 'FTP 이미지 다운로드 실패: $e';
    }
  }
}
