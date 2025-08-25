import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:movie_verse/constants/my_app_colors.dart';
import 'package:movie_verse/widgets/custom_appbar.dart';
import 'package:movie_verse/widgets/popular_movie_card.dart';
import '../constants/my_app_icons.dart';
import '../widgets/movie_promo_card.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  late PageController _pageController;
  Timer? _autoPlayTimer;
  int _currentPage = 0;

  // Sample movie data (replace with TMDb API)
  final List<Map<String, String>> movies = [
    {
      "title": "Evil Dead Rise",
      "poster":
      "https://image.tmdb.org/t/p/w500/5ik4ATKmNtmJU6AYD0bLm56BCVM.jpg",
      "language": "ENGLISH",
      "genre": "HORROR",
      "format": "2D · 3D · 4DX",
    },
    {
      "title": "Oppenheimer",
      "poster":
      "https://image.tmdb.org/t/p/w500/bAFmcr7MEzC3yjuMj0Xy8jbKc6E.jpg",
      "language": "ENGLISH",
      "genre": "DRAMA",
      "format": "IMAX · 2D",
    },
    {
      "title": "Spider-Man: No Way Home",
      "poster":
      "https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg",
      "language": "ENGLISH",
      "genre": "ACTION",
      "format": "2D · 3D · IMAX",
    },
    {
      "title": "Avatar: The Way of Water",
      "poster":
      "https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg",
      "language": "ENGLISH",
      "genre": "SCI-FI",
      "format": "2D · 3D · 4DX",
    },
    {
      "title": "The Batman",
      "poster":
      "https://image.tmdb.org/t/p/w500/74xTEgt7R36Fpooo50r9T25onhq.jpg",
      "language": "ENGLISH",
      "genre": "THRILLER",
      "format": "2D · 3D",
    },
  ];
  late List<Map<String, String>> randomMovies;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);

    // Shuffle the movies so order is random
    randomMovies = List<Map<String, String>>.from(movies)..shuffle(Random());

    // Start auto-play
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 8), (timer) {
      if (_pageController.hasClients) {
        _currentPage++;
        if (_currentPage >= randomMovies.length) {
          _currentPage = 0;
        }
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoPlayTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 353,
              child: PageView.builder(
                controller: _pageController,
                itemCount: randomMovies.length,
                itemBuilder: (context, index) {
                  final movie = randomMovies[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 12,
                    ),
                    child: MoviePromoCard(
                      posterUrl: movie["poster"]!,
                      title: movie["title"]!,
                      language: movie["language"]!,
                      genre: movie["genre"]!,
                      format: movie["format"]!,
                      onWatchTrailer: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Watch Trailer: ${movie["title"]}"),
                          ),
                        );
                      },
                      onBook: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Booked: ${movie["title"]}")),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            // Recommended Movies
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Recommended Movies",style: TextStyle(fontSize: 16),),
                      Row(
                        children: [
                          Text("See All",style: TextStyle(color: MyAppColors.darkElevatedButtonColor),),
                          Icon(Icons.arrow_forward,color: MyAppColors.darkElevatedButtonColor,)

                        ],
                      ),

                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder: (context, int index) {
                      final popularMovie = movies[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 2), // Small gap between items
                        child: SizedBox(
                          width: 140, // Fixed width for each card
                          child: PopularMovieCardWidget(
                            imageUrl: popularMovie["poster"]!,
                            title: popularMovie["title"]!,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),


          ],
        ),
      ),
    );
  }
}