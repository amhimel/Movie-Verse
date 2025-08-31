import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:movie_verse/constants/my_app_colors.dart';
import 'package:movie_verse/screens/book_now_screen.dart';
import 'package:movie_verse/widgets/video_play_dialog.dart';
import 'package:movie_verse/widgets/popular_movie_card.dart';
import 'package:provider/provider.dart';
import '../models/movie_model.dart';
import '../provider/movie_provider.dart';
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

  List<MovieModel> randomMovies = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);

    // start autoplay
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 8), (timer) {
      if (_pageController.hasClients && randomMovies.isNotEmpty) {
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
            // ✅ Trending Movies Carousel
            SizedBox(
              height: 353,
              child: Consumer(
                builder: (context, MovieProvider trendingMovieProvider, child) {
                  if (trendingMovieProvider.moviesTrendList.isNotEmpty &&
                      randomMovies.isEmpty) {
                    randomMovies = List<MovieModel>.from(
                      trendingMovieProvider.moviesTrendList,
                    )..shuffle(Random());
                    debugPrint('Randomized movies: $randomMovies');
                  }

                  if (randomMovies.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }

                  return Consumer(
                    builder: (context, MovieProvider movieProvider, child) {
                      if (movieProvider.isLoading &&
                          movieProvider.moviesTrendList.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      } else if (movieProvider.fetchMoviesError.isNotEmpty) {
                        return const Center(child: Text('An error found'));
                      }

                      return NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (!movieProvider.isLoading &&
                              scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent) {
                            debugPrint('Fetch more movies');
                            movieProvider.getTrendingMovies();
                            return true;
                          }
                          return false;
                        },
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: movieProvider.moviesTrendList.length,
                          itemBuilder: (context, index) {
                            final movie = randomMovies[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 12,
                              ),
                              child: ChangeNotifierProvider.value(
                                value: movie,
                                child: MoviePromoCard(
                                  onWatchTrailer: () async {
                                    // getIt<NavigationService>().showSnackBar(
                                    //   Text("Watch Trailer: ${movie.title}"),
                                    // );
                                    final videoId = await movieProvider
                                        .getMovieTrailer(movie.id!);
                                    if (videoId != null) {
                                      getIt<NavigationService>().navigate(
                                        VideoPlayDialog(videoId: videoId),
                                      );
                                    } else {
                                      getIt<NavigationService>().showSnackBar(
                                        const Text(
                                          "No trailer available for this movie",
                                        ),
                                      );
                                    }
                                  },

                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
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
                      Text(
                        "Recommended Movies",
                        style: TextStyle(fontSize: 16),
                      ),
                      Row(
                        children: [
                          Text(
                            "See All",
                            style: TextStyle(
                              color: MyAppColors.darkElevatedButtonColor,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: MyAppColors.darkElevatedButtonColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 260,
                  child: Consumer(
                    builder: (context, MovieProvider movieProvider, child) {
                      if (movieProvider.isLoading &&
                          movieProvider.moviesList.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      } else if (movieProvider.fetchMoviesError.isNotEmpty) {
                        return const Center(child: Text('An error found'));
                      }
                      return NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (!movieProvider.isLoading &&
                              scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent) {
                            debugPrint('Fetch more movies');
                            movieProvider.getMovies();
                            return true;
                          }
                          return false;
                        },
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: movieProvider.moviesList.length,
                          itemBuilder: (context, index) {
                            final popularMovie =
                                movieProvider.moviesList[index];

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 3,
                                vertical: 2,
                              ),
                              child: SizedBox(
                                width: 160,
                                child: ChangeNotifierProvider.value(
                                  value: popularMovie,
                                  child: PopularMovieCardWidget(
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
