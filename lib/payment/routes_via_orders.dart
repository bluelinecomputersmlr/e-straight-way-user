import 'dart:convert';

import 'package:http/http.dart' as http;

class RoutesViaOrders {
  void routApiCall(String paymentId, double grandTotal) async {
    var uname = 'rzp_live_Bm7fhzUxrM1frD';
    var pword = 'rATj0FwTR2oCwFEGUF66yA3B';
    var authn = 'Basic ' + base64Encode(utf8.encode('$uname:$pword'));

    var headers = {
      'content-type': 'application/json',
      'Authorization': authn,
    };

    var data = '{"amount": ${grandTotal * 100}, "currency": "INR"}';

    var url =
        Uri.parse('https://api.razorpay.com/v1/payments/$paymentId/capture');
    var res = await http.post(url, headers: headers, body: data);
    //print(res.body);
    if (res.statusCode != 200)
      throw Exception('http.post error: statusCode= ${res.statusCode}');
    //print(res.body);
  }
}
