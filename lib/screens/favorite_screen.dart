import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: const Center(
        child: Text(
          "Your Favorite Movies",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
    );
  }
}
