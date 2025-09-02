//final publishableKey = dotenv.env['STRIPE_PK_TEST_KEY'] ?? 'NOT_SET';
//final secretKey = dotenv.env['STRIPE_SK_TEST_KEY'] ?? '';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

enum PaymentStatus { idle, loading, success, failed, cancelled }

class StripePaymentProvider extends ChangeNotifier {
  PaymentStatus _paymentStatus = PaymentStatus.idle;
  String? _errorMessage;
  Map<String, dynamic>? _intentPaymentData;
  final secretKey = dotenv.env['STRIPE_SK_TEST_KEY'] ?? '';

  // Getters
  PaymentStatus get paymentStatus => _paymentStatus;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _paymentStatus == PaymentStatus.loading;

  // Reset payment state
  void resetPaymentState() {
    _paymentStatus = PaymentStatus.idle;
    _errorMessage = null;
    _intentPaymentData = null;
    notifyListeners();
  }

  // Create payment intent
  Future<Map<String, dynamic>?> _createPaymentIntent(
      double amount,
      String currency,
      ) async {
    try {
      Map<String, dynamic> paymentInfo = {
        'amount': (amount * 100).toInt().toString(), // Convert to cents
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: paymentInfo,
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      log('Payment Intent Response: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to create payment intent: ${response.body}');
      }
    } catch (e) {
      log('Error creating payment intent: $e');
      rethrow;
    }
  }

  // Initialize payment sheet
  Future<void> _initializePaymentSheet(
      Map<String, dynamic> paymentIntentData,
      String merchantName,
      ) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          allowsDelayedPaymentMethods: true,
          paymentIntentClientSecret: paymentIntentData['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: merchantName,
        ),
      );
      log('Payment Sheet initialized successfully');
    } catch (e) {
      log('Error initializing payment sheet: $e');
      rethrow;
    }
  }

  // Present payment sheet
  Future<void> _presentPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      log('Payment completed successfully');
    } catch (e) {
      log('Error presenting payment sheet: $e');
      rethrow;
    }
  }

  // Main payment method
  Future<void> processPayment({
    required double amount,
    required String currency,
    String merchantName = 'Your Business',
  }) async {
    try {
      // Set loading state
      _paymentStatus = PaymentStatus.loading;
      _errorMessage = null;
      notifyListeners();

      log('Processing payment of $amount $currency');

      // Step 1: Create payment intent
      _intentPaymentData = await _createPaymentIntent(amount, currency);
      if (_intentPaymentData == null) {
        throw Exception('Failed to create payment intent');
      }

      // Step 2: Initialize payment sheet
      await _initializePaymentSheet(_intentPaymentData!, merchantName);

      // Step 3: Present payment sheet
      await _presentPaymentSheet();

      // Payment successful
      _paymentStatus = PaymentStatus.success;
      _intentPaymentData = null;
      log('Payment process completed successfully');

    } on StripeException catch (e) {
      _errorMessage = e.error.localizedMessage;
      _paymentStatus = PaymentStatus.cancelled;
      log('Stripe error: ${e.error.localizedMessage}');

    } catch (e) {
      _errorMessage = e.toString();
      _paymentStatus = PaymentStatus.failed;
      log('Payment error: $e');
    }

    notifyListeners();
  }

  // Alternative method for legacy compatibility
  Future<void> makePayment(BuildContext context, {required int amount}) async {
    await processPayment(
      amount: amount / 100.0, // Convert cents to dollars
      currency: 'USD',
      merchantName: 'MovieVerse',
    );
  }

  // Quick payment method with preset amounts
  Future<void> makeQuickPayment(double amount) async {
    await processPayment(
      amount: amount,
      currency: 'USD',
      merchantName: 'Himel',
    );
  }
}