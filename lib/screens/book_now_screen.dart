import 'package:flutter/material.dart';
import 'package:movie_verse/constants/my_app_icons.dart';
import 'package:provider/provider.dart';
import '../constants/my_app_colors.dart';
import '../constants/my_app_constants.dart';
import '../models/movie_model.dart';
import '../provider/stripe_payment_provider.dart';
import '../widgets/cached_detail_image_widget.dart';

class BookNowScreen extends StatelessWidget {
  final MovieModel? movieModel;
  final double ticketPrice;

  const BookNowScreen({
    super.key,
    this.movieModel,
    this.ticketPrice = 15.99,
  });

  @override
  Widget build(BuildContext context) {
    final paymentProvider = Provider.of<StripePaymentProvider>(context);
    final priceInCents = (ticketPrice * 100).round();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Movie Ticket"),
        backgroundColor: MyAppColors.darkBackgroundColor,
      ),
      backgroundColor: MyAppColors.darkBackgroundColor,
      body: paymentProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie Details (if provided)
            if (movieModel != null) ...[
              Hero(
                tag: "movie_${movieModel!.id}",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedDetailImageWidget(
                    //height: double.infinity,
                    width: double.infinity,
                    imageUrl: '${MyAppConstants.imagePath}${movieModel!.backdropPath}',
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => const Icon(
                      Icons.movie,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                movieModel!.title ?? 'Movie Ticket',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 5),
                  Text(
                    "${movieModel!.voteAverage?.toStringAsFixed(1)}/10",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const Spacer(),
                   Icon(MyAppIcons.iconRelease, color: MyAppColors.darkErrorColor, size: 20),
                  Text(
                    movieModel!.releaseDate ?? '',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],

            // Booking Details
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: MyAppColors.darkSecondaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Booking Summary',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildBookingRow('Movie Ticket', '\$${ticketPrice.toStringAsFixed(2)}'),
                  _buildBookingRow('Service Fee', '\$2.50'),
                  const Divider(color: Colors.grey),
                  _buildBookingRow(
                    'Total',
                    '\$${(ticketPrice + 2.50).toStringAsFixed(2)}',
                    isTotal: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Payment Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  final totalAmount = ((ticketPrice + 2.50) * 100).round();
                  paymentProvider.makePayment(context, amount: totalAmount);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyAppColors.darkElevatedButtonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Pay \$${(ticketPrice + 2.50).toStringAsFixed(2)} with Stripe",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Test Cards Info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.withOpacity(0.3)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '💳 Test Card Numbers:',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  SizedBox(height: 4),
                  Text('• Visa: 4242 4242 4242 4242', style: TextStyle(color: Colors.white70)),
                  Text('• Mastercard: 5555 5555 5555 4444', style: TextStyle(color: Colors.white70)),
                  Text('• Use any future date and any CVC', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white70,
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: isTotal ? Colors.white : Colors.white70,
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}