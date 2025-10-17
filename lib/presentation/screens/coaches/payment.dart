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
    String.fromEnvironment('STRIPE_TOKEN');
    final SetupStripePayment intent = SetupStripePayment(token: token);
    await StripeService.instance.pay(setupPayment: intent);
  }

  Future<void> payWithPaymob(BuildContext context) async {
    final SetupPaymobPayment setupPayment = SetupPaymobPayment(
      context: context,
      frameId: "923378", //839579
      integrationId: int.parse("5095409"),
      apiKey:
      String.fromEnvironment('PAYMOB_APIKEY'),
    );
    await PaymobPaymentService.instance.pay(setupPayment: setupPayment);
  }

  void payWithPaypal(BuildContext context) async {
    final paypalModel = SetupePaypalPayment(
      context: context,
      clientId: "PAYPAL_CLIENT_ID",
      secretKey: String.fromEnvironment('PAYPAL_SECRET_KEY'),
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
