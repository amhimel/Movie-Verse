import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/movie_provider.dart';
import '../widgets/search_result_widget.dart';

class MovieSearchScreen extends StatefulWidget {
  const MovieSearchScreen({super.key});

  @override
  State<MovieSearchScreen> createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends State<MovieSearchScreen> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Search movies...",
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            if (_debounce?.isActive ?? false) _debounce?.cancel();
            _debounce = Timer(const Duration(milliseconds: 500), () {
              movieProvider.searchMovies(value); // ✅ call provider
            });
          },
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear, color: Colors.white),
            onPressed: () {
              _controller.clear();
              movieProvider.clearSearch(); // ✅ clear provider state
            },
          )
        ],
      ),
      body: movieProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : movieProvider.searchResults.isEmpty
          ? const Center(
        child: Text("No results found",
            style: TextStyle(color: Colors.white)),
      )
          : ListView.builder(
        itemCount: movieProvider.searchResults.length,
        itemBuilder: (context, index) {
          final movie = movieProvider.searchResults[index];
          return SearchResultWidget(movieModel: movie);
        },
      ),

      backgroundColor: Colors.black,
    );
  }
}
