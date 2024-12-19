// import 'package:flutter/material.dart';
// import 'package:health/health.dart';

// class HealthDataFetcher {
//   void _requestPermissions() async {
//     // 요청하려는 데이터 유형을 설정
//     final types = [
//       HealthDataType.STEPS, // 걸음 수
//       HealthDataType.HEART_RATE, // 심박수
//       HealthDataType.SLEEP_IN_BED, // 수면 데이터
//     ];

//     // HealthKit 권한 요청
//     bool requested = await Health.requestAuthorization(types);

//     if (requested) {
//       // 권한이 승인되었으면 데이터를 가져올 수 있습니다.
//       _fetchHealthData();
//     } else {
//       // 권한이 거부되었을 경우
//       print("HealthKit 권한이 필요합니다.");
//     }
//   }

//   void _fetchHealthData() async {
//     DateTime startDate =
//         DateTime.now().subtract(Duration(days: 7)); // 최근 7일 데이터
//     DateTime endDate = DateTime.now();

//     // 데이터 요청
//     List<HealthDataPoint> healthData = await Health.getHealthDataFromTypes(
//       startDate,
//       endDate,
//       [HealthDataType.STEPS],
//     );

//     // 받은 데이터 출력
//     for (var data in healthData) {
//       print("데이터: ${data.value} ${data.dataType}");
//     }
//   }
// }
