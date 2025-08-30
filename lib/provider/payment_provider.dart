import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import '../constants/stripe_keys.dart';

class PaymentProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> makePayment(BuildContext context, {int amount = 5000}) async {
    _isLoading = true;
    notifyListeners();

    try {
      // 1️⃣ Create PaymentIntent on Stripe (Dummy API call)
      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${StripeKeys.secretKey}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          'amount': amount.toString(), // in cents
          'currency': 'usd',
          'payment_method_types[]': 'card'
        },
      );

      final jsonResponse = jsonDecode(response.body);

      // 2️⃣ Init payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: jsonResponse['client_secret'],
          merchantDisplayName: 'MovieVerse',
        ),
      );

      // 3️⃣ Present payment sheet
      await Stripe.instance.presentPaymentSheet();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ Payment successful")),
        );
      }
    } catch (e) {
      debugPrint("Payment error: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("❌ Payment failed: $e")),
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
