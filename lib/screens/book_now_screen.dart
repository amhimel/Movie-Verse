import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/payment_provider.dart';

class BookNowScreen extends StatelessWidget {
  const BookNowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentProvider = Provider.of<PaymentProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Book Now")),
      body: Center(
        child: paymentProvider.isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
          onPressed: () {
            paymentProvider.makePayment(context, amount: 5000);
          },
          child: const Text("Pay \$50 with Stripe"),
        ),
      ),
    );
  }
}
