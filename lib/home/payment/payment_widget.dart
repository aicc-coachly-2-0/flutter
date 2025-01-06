import 'package:bootpay/bootpay.dart';
import 'package:bootpay/model/extra.dart';
import 'package:bootpay/model/item.dart';
import 'package:bootpay/model/payload.dart';
import 'package:bootpay/model/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/payment/payment_success.dart';
import 'package:flutter_application_test/state_controller/loginProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert'; // JSON 변환을 위해 필요
import 'package:http/http.dart' as http; // HTTP 요청을 위해 필요

// 결제 위젯
class PaymentWidget extends ConsumerWidget {
  const PaymentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);

    // 페이지가 로드되자마자 결제를 실행
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bootpayTest(context, ref);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("결제 진행 중"),
        backgroundColor: const Color.fromARGB(255, 255, 111, 97),
      ),
      body: const Center(
        child: CircularProgressIndicator(), // 결제 진행 중 로딩 표시
      ),
    );
  }

  void bootpayTest(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);

    // null 체크
    if (user == null) {
      // user가 null일 경우 처리 (에러 메시지나 기본값으로 대체)
      print('로그인된 사용자가 없습니다.');
      return;
    }

    // user가 null이 아닌 경우에만 진행
    Payload payload = getPayload(ref);

    Bootpay().requestSubscription(
      context: context,
      payload: payload,
      showCloseButton: false,
      onCancel: (String data) {
        print('결제 취소: $data');
      },
      onError: (String data) {
        print('결제 실패: $data');
      },
      onDone: (String data) async {
        print('결제 완료: $data');

        final parsedData = jsonDecode(data);
        final receiptId = parsedData['data']['receipt_id'];
        final subscriptionId = parsedData['data']['subscription_id'];
        final userNumber = user.userNumber;

// PaymentSuccess 페이지로 전달
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentSuccess(
              receiptId: receiptId,
              subscriptionId: subscriptionId,
              userNumber: userNumber,
            ),
          ),
        );
      },
      onIssued: (String data) {
        print('------- onIssued: $data');
      },
      onConfirm: (String data) {
        return true;
      },
      onClose: () {
        print('결제 창 닫힘');
        Bootpay().dismiss(context);
      },
    );
  }

  Payload getPayload(WidgetRef ref) {
    final user = ref.watch(authProvider);

    Payload payload = Payload();
    Item item1 = Item();
    item1.name = "AI Service";
    item1.qty = 1;
    item1.id = "ITEM_CODE_AI_Service";
    item1.price = 1000;

    List<Item> itemList = [item1];

    payload.androidApplicationId = '67626cfbcc5274a3ac3fc91a';
    payload.iosApplicationId = '67626cfbcc5274a3ac3fc91b';
    payload.pg = '나이스페이';
    payload.method = '카드자동';
    payload.orderName = "테스트 상품";
    payload.price = 1000.0;

    payload.subscriptionId = DateTime.now().millisecondsSinceEpoch.toString();

    payload.metadata = {
      "callbackParam1": "value12",
    };
    payload.items = itemList;

    Extra extra = Extra();
    extra.appScheme = 'bootpayFlutterExample';
    extra.cardQuota = '3';

    // payload.user = userInfo;
    payload.extra = extra;

    return payload;
  }
}
