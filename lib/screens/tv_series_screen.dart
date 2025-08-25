import 'package:flutter/material.dart';

class TvSeriesScreen extends StatelessWidget {
  const TvSeriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: const Center(
        child: Text(
          "TV Series Content Here",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
    );
  }
}
