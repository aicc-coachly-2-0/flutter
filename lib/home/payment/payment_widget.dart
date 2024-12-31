import 'package:bootpay/bootpay.dart';
import 'package:bootpay/model/extra.dart';
import 'package:bootpay/model/item.dart';
import 'package:bootpay/model/payload.dart';
import 'package:bootpay/model/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/home/payment/payment_success.dart';
import 'dart:convert'; // JSON 변환을 위해 필요
import 'package:http/http.dart' as http; // HTTP 요청을 위해 필요


class PaymentWidget extends StatelessWidget {
  const PaymentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentAgreement(
            onAgreementComplete: () {
              bootpayTest(context);
            },
          ),
        ),
      );
    });

            return Scaffold(
      appBar: AppBar(
        title: const Text("운동 장소 선택"),
        backgroundColor: const Color.fromARGB(255, 255, 111, 97),
      ),
      body: const Center(
        child: CircularProgressIndicator(), // While redirecting, show a loading indicator
      ),
    );
  }

 void bootpayTest(BuildContext context) {
  Payload payload = getPayload();
  if (kIsWeb) {
    payload.extra?.openType = "iframe";
  }

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
        
        // JSON 파싱
        final parsedData = jsonDecode(data);
 // 필요한 값만 추출
      final receiptId = parsedData['data']['receipt_id'];
      final subscriptionId = parsedData['data']['subscription_id'];
      final userId = 'userId'; // authProvider에서 가져오거나 필요 시 전달


        // PaymentSuccess 화면으로 데이터 전달
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentSuccess(
              receiptId: receiptId,
              subscriptionId: subscriptionId,
              userId: userId,
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
}


class PaymentAgreement extends StatefulWidget {
  final VoidCallback onAgreementComplete;

  const PaymentAgreement({Key? key, required this.onAgreementComplete})
      : super(key: key);

  @override
  State<PaymentAgreement> createState() => _PaymentAgreementState();
}

class _PaymentAgreementState extends State<PaymentAgreement> {
  bool _allAgreed = false;
  bool _term1Agreed = false;
  bool _term2Agreed = false;

  void _updateAllAgreed(bool value) {
    setState(() {
      _allAgreed = value;
      _term1Agreed = value;
      _term2Agreed = value;
    });
  }

  void _updateIndividualAgreed() {
    setState(() {
      _allAgreed = _term1Agreed && _term2Agreed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("이용약관 동의"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: _allAgreed,
                  onChanged: (value) {
                    _updateAllAgreed(value!);
                  },
                ),
                const Text(
                  '전체 약관에 동의합니다.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Checkbox(
                  value: _term1Agreed,
                  onChanged: (value) {
                    setState(() {
                      _term1Agreed = value!;
                      _updateIndividualAgreed();
                    });
                  },
                ),
                const Expanded(
                  child: Text(
                    '이용약관 동의 (필수)',
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: _term2Agreed,
                  onChanged: (value) {
                    setState(() {
                      _term2Agreed = value!;
                      _updateIndividualAgreed();
                    });
                  },
                ),
                const Expanded(
                  child: Text(
                    '개인정보 처리방침 동의 (필수)',
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _allAgreed
                  ? () {
                       widget.onAgreementComplete();
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('동의하고 결제하기'),
            ),
          ],
        ),
      ),
    );
  }
}


Payload getPayload() {
  Payload payload = Payload();
  Item item1 = Item();
  item1.name = "AI Service"; // 주문정보에 담길 상품명
  item1.qty = 1; // 해당 상품의 주문 수량
  item1.id = "ITEM_CODE_AI_Service"; // 해당 상품의 고유 키
  item1.price = 1000; // 상품의 가격

  Item item2 = Item();
  item2.name = "키보드"; // 주문정보에 담길 상품명
  item2.qty = 1; // 해당 상품의 주문 수량
  item2.id = "ITEM_CODE_KEYBOARD"; // 해당 상품의 고유 키
  item2.price = 500; // 상품의 가격
  List<Item> itemList = [item1, item2];

  payload.androidApplicationId ='67626cfbcc5274a3ac3fc91a'; // android application id
  payload.iosApplicationId = '67626cfbcc5274a3ac3fc91b'; // ios application id

  payload.pg = '나이스페이';
  payload.method = '카드자동';
  // payload.methods = ['card', 'phone', 'vbank', 'bank', 'kakao'];
  payload.orderName = "테스트 상품"; //결제할 상품명
  payload.price = 1000.0; //정기결제시 0 혹은 주석

  // payload.orderId = DateTime.now().millisecondsSinceEpoch.toString(); //주문번호, 개발사에서 고유값으로 지정해야함
  payload.subscriptionId = DateTime.now()
      .millisecondsSinceEpoch
      .toString(); //주문번호, 개발사에서 고유값으로 지정해야함

  payload.metadata = {
    "callbackParam1": "value12",
  }; // 전달할 파라미터, 결제 후 되돌려 주는 값
  payload.items = itemList; // 상품정보 배열

  User user = User(); // 구매자 정보
  user.username = "박토씨";
  user.email = "user1@gmail";
  // user.area = "서울";
  user.phone = "010-4033-4678";
  // user.addr = '서울시 동작구 상도로 222';

  // 로그인 연결 후 받아올 코드 
  // User user = User();
  // user.id = userId; // 로그인 시 전달받은 user_id
  // user.username = username; // 사용자 이름
  // user.email = email; // 사용자 이메일
  // user.phone = phone; // 사용자 전화번호
  // payload.user = user;

  Extra extra = Extra(); // 결제 옵션
  extra.appScheme = 'bootpayFlutterExample';
  extra.cardQuota = '3';
  // extra.openType = 'popup';

  // extra.carrier = "SKT,KT,LGT"; //본인인증 시 고정할 통신사명
  // extra.ageLimit = 20; // 본인인증시 제한할 최소 나이 ex) 20 -> 20살 이상만 인증이 가능

  payload.user = user;
  payload.extra = extra;
  return payload;
}


// Future<void> sendToBackend(String receiptId, String userNumber) async {
//   final uri = Uri.parse('http://localhost:8000/api/subscriptions/billing-key'); // 백엔드 URL

//   final body = jsonEncode({
//     'receipt_id': receiptId,
//     'user_number': userNumber,
//   });

//   try {
//     final response = await http.post(
//       uri,
//       headers: {'Content-Type': 'application/json'},
//       body: body,
//     );

//     if (response.statusCode == 200) {
//       print('백엔드에 성공적으로 데이터를 전송했습니다: ${response.body}');
//     } else {
//       print('백엔드 응답 오류: ${response.statusCode}, ${response.body}');
//     }
//   } catch (e) {
//     print('백엔드 요청 실패: $e');
//   }
// }

