import 'package:flutter/material.dart';
import 'package:multi_payment_gateway/payment_model.dart';
import 'package:multi_payment_gateway/services/paymob_service.dart';
import 'package:multi_payment_gateway/services/paypal_service.dart';
import 'package:multi_payment_gateway/services/stripe_service.dart';
import 'package:multi_payment_gateway/setup_payment.dart';
import 'package:multi_payment_gateway/transaction.dart';

class StripePayment extends StatelessWidget {
  const StripePayment({super.key});

  Future<void> payWithStripe() async {
    var token =
        "sk_test_51S1mmXRpR96vcwXxK3gfGqnDlMvlaPxSdik3mDZ2spMRGEBUPZxBAHv0TWrIoKeZrr3sFM1m24oXf7HT2NEt8yog00zg0cOzZ8";
    final SetupStripePayment intent = SetupStripePayment(token: token);
    await StripeService.instance.pay(setupPayment: intent);
  }

  Future<void> payWithPaymob(BuildContext context) async {
    final SetupPaymobPayment setupPayment = SetupPaymobPayment(
      context: context,
      frameId: "923378", //839579
      integrationId: int.parse("5095409"),
      apiKey:
          "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRBME5qRXpNU3dpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS5VcThrOFRZWnNVTF8xT2pud3ltLXJIcXZvUV84MzBWUHlIUWhxSVpFQXhVZ1JMTlRvdDYwVFNncmRXQTJmeGZuVXdqN212M2JKRHVpN3BzN3BiNWpHdw==",
    );
    await PaymobPaymentService.instance.pay(setupPayment: setupPayment);
  }

  void payWithPaypal(BuildContext context) async {
    final paypalModel = SetupePaypalPayment(
      context: context,
      clientId: "PAYPAL_CLIENT_ID",
      secretKey: "E%GezcmK9Wm)U@zINmmM*cA^KHw-QrK71kixwT6q",
    );
    await PaypalService.instance.pay(setupPayment: paypalModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("payment"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: () async {
              await payWithStripe();
            },
            icon: Icon(Icons.payment),
          ),
          IconButton(
            onPressed: () {
              payWithPaypal(context);
            },
            icon: Icon(Icons.payment),
          ),
          IconButton(
            onPressed: () async {
              await payWithPaymob(context);
            },
            icon: Icon(Icons.payment),
          ),
        ],
      ),
    );
  }
}
