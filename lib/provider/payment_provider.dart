import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _paymentStatus = '';
  String get paymentStatus => _paymentStatus;

  Future<void> makePayment(BuildContext context, {int amount = 5000}) async {
    final publishableKey = dotenv.env['STRIPE_PK_TEST_KEY'] ?? 'NOT_SET';
    debugPrint("🚀 === STARTING PAYMENT PROCESS ===");
    debugPrint("💰 Amount: $amount cents (\$${amount / 100})");
    debugPrint("🔑 Using publishable key: ${publishableKey.substring(0, 20)}...");

    _isLoading = true;
    _paymentStatus = '';
    notifyListeners();

    try {
      // 1️⃣ Create PaymentIntent
      debugPrint("📝 Step 1: Creating payment intent...");
      final paymentIntentData = await _createPaymentIntent(amount);
      debugPrint("✅ Payment intent created successfully!");
      debugPrint("🆔 Payment Intent ID: ${paymentIntentData['id']}");
      debugPrint("🔐 Client Secret: ${paymentIntentData['client_secret'].substring(0, 20)}...");

      // 2️⃣ Initialize payment sheet
      debugPrint("🎨 Step 2: Initializing payment sheet...");
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData['client_secret'],
          merchantDisplayName: 'Movie Verse',
          style: ThemeMode.dark,
          appearance: const PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              primary: Color(0xFFEB2F3D),
            ),
          ),
        ),
      );
      debugPrint("✅ Payment sheet initialized successfully!");

      // 3️⃣ Present payment sheet
      debugPrint("📱 Step 3: Presenting payment sheet...");
      debugPrint("👆 Payment sheet should open now - look for card input form!");

      await Stripe.instance.presentPaymentSheet();

      debugPrint("🎉 Step 4: Payment completed successfully!");
      _paymentStatus = 'Payment successful!';

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("🎉 Payment successful! Movie booked!"),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      }

    } on StripeException catch (e) {
      debugPrint("💳 Stripe Exception: ${e.error}");
      _paymentStatus = 'Stripe error: ${e.error}';

      if (context.mounted) {
        String errorMessage = "❌ Payment failed";

        switch (e.error.code) {
          case FailureCode.Canceled:
            errorMessage = "Payment was cancelled by user";
            debugPrint("🚫 User cancelled payment");
            break;
          case FailureCode.Failed:
            errorMessage = "Payment failed. Please try again.";
            debugPrint("💥 Payment processing failed");
            break;
          default:
            errorMessage = "Payment error: ${e.error.localizedMessage ?? e.error.message}";
            debugPrint("🐛 Other Stripe error: ${e.error}");
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.orange,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      debugPrint("💥 General Exception: $e");
      _paymentStatus = 'General error: $e';

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("❌ Unexpected error: $e"),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
      debugPrint("🏁 === PAYMENT PROCESS COMPLETED ===");
    }
  }

  // Create Payment Intent
  Future<Map<String, dynamic>> _createPaymentIntent(int amount) async {
    final secretKey = dotenv.env['STRIPE_SK_TEST_KEY'] ?? '';
    debugPrint("🔧 Creating payment intent with secret key (hidden)...");
    debugPrint("🔧 Creating payment intent with Stripe API...");
    debugPrint("💵 Amount: $amount, Currency: USD");

    try {
      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          'amount': amount.toString(),
          'currency': 'usd',
          'payment_method_types[]': 'card',
          'metadata[app]': 'movie_verse',
          'metadata[platform]': 'flutter',
        },
      );

      debugPrint("📡 Stripe API response status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint("✅ Payment intent API call successful");
        return data;
      } else {
        debugPrint("❌ Stripe API error response: ${response.body}");
        throw Exception('Stripe API returned ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      debugPrint("💥 Network/API error: $e");
      rethrow;
    }
  }
}