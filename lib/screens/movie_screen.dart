import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:movie_verse/constants/my_app_colors.dart';
import 'package:movie_verse/widgets/popular_movie_card.dart';
import '../models/movie_model.dart';
import '../services/init_getIt.dart';
import '../services/navigation_service.dart';
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

  // ✅ Use MovieModel list instead of Map
  final List<MovieModel> movies = [
    MovieModel(
      adult: false,
      backdropPath: "",
      genreIds: [27],
      id: 1,
      originalLanguage: "en",
      originalTitle: "Evil Dead Rise",
      overview: "Some horror movie description...",
      popularity: 50.0,
      posterPath:
      "https://image.tmdb.org/t/p/w500/5ik4ATKmNtmJU6AYD0bLm56BCVM.jpg",
      releaseDate: "2023-04-01",
      title: "Evil Dead Rise",
      video: false,
      voteAverage: 7.0,
      voteCount: 200,
    ),
    MovieModel(
      adult: false,
      backdropPath: "",
      genreIds: [28],
      id: 3,
      originalLanguage: "en",
      originalTitle: "Spider-Man: No Way Home",
      overview: "Spider-Man multiverse story...",
      popularity: 100.0,
      posterPath:
      "https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg",
      releaseDate: "2021-12-15",
      title: "Spider-Man: No Way Home",
      video: false,
      voteAverage: 8.2,
      voteCount: 1000,
    ),
    MovieModel(
      adult: false,
      backdropPath: "",
      genreIds: [878],
      id: 4,
      originalLanguage: "en",
      originalTitle: "Avatar: The Way of Water",
      overview: "Return to Pandora...",
      popularity: 120.0,
      posterPath:
      "https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg",
      releaseDate: "2022-12-16",
      title: "Avatar: The Way of Water",
      video: false,
      voteAverage: 7.9,
      voteCount: 800,
    ),
    MovieModel(
      adult: false,
      backdropPath: "",
      genreIds: [53],
      id: 5,
      originalLanguage: "en",
      originalTitle: "The Batman",
      overview: "Batman faces Riddler...",
      popularity: 110.0,
      posterPath:
      "https://image.tmdb.org/t/p/w500/74xTEgt7R36Fpooo50r9T25onhq.jpg",
      releaseDate: "2022-03-04",
      title: "The Batman",
      video: false,
      voteAverage: 8.0,
      voteCount: 700,
    ),
  ];

  late List<MovieModel> randomMovies;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);

    // ✅ Shuffle movies
    randomMovies = List<MovieModel>.from(movies)..shuffle(Random());

    // ✅ Auto-play
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
            // ✅ Promo Movies Carousel
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
                      movieModel: movie,
                      onWatchTrailer: () {
                        getIt<NavigationService>().showSnackBar(Text("Watch Trailer: ${movie.title}"));
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     content: Text("Watch Trailer: ${movie.title}"),
                        //   ),
                        // );
                      },
                      onBook: () {

                        getIt<NavigationService>().showSnackBar(Text("Booked: ${movie.title}"));
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(content: Text("Booked: ${movie.title}")),
                        // );
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),

            // ✅ Recommended Movies
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Recommended Movies",
                          style: TextStyle(fontSize: 16)),
                      Row(
                        children: [
                          Text("See All",
                              style: TextStyle(
                                  color: MyAppColors.darkElevatedButtonColor)),
                          Icon(Icons.arrow_forward,
                              color: MyAppColors.darkElevatedButtonColor),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 260,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final popularMovie = movies[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 3, vertical: 2),
                        child: SizedBox(
                          width: 160,
                          child: PopularMovieCardWidget(
                            imageUrl: popularMovie.posterPath ?? '',
                            title: popularMovie.title ?? '',
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
