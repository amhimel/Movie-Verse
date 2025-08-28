import 'package:flutter/material.dart';
import 'package:movie_verse/provider/tv_shows_provider.dart';
import 'package:movie_verse/widgets/custom_bottom_nav.dart';
import 'package:provider/provider.dart';

import '../provider/favorite_provider.dart';
import '../provider/movie_provider.dart';
import '../services/init_getIt.dart';
import '../services/navigation_service.dart';
import '../widgets/my_error_widget.dart';
import 'movie_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> _loadInitialData(BuildContext context) async {
    await Future.microtask(() async {
      if (!context.mounted) return;
      final movieProvider = Provider.of<MovieProvider>(context, listen: false);
      await movieProvider.getMovies();
      await movieProvider.getTrendingMovies();

      if (!context.mounted) return;
      final tvShowProvider = Provider.of<TvShowsProvider>(context, listen: false);
      await tvShowProvider.getTvShows();

      if (!context.mounted) return;
      final favProvider = Provider.of<FavoriteProvider>(context, listen: false);
      await favProvider.loadFavorites();

    });
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context,listen: false);
    return Scaffold(
      body: FutureBuilder(
        future: _loadInitialData(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Waiting..."),
                  SizedBox(height: 20),
                  CircularProgressIndicator.adaptive(),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            if (movieProvider.genresList.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                // This ensures that the context is fully built before accessing it
                getIt<NavigationService>().navigateReplace(CustomBottomNav());
              });
            }
            return Provider.of<MovieProvider>(context, listen: true).isLoading
                ? Center(child: CircularProgressIndicator.adaptive())
                : MyErrorWidget(
              errorText: "An error occurred.Please try again.",
              retryFunction: () async {
                // Retry logic can be implemented here
                await _loadInitialData(context);
              },
            );
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              // This ensures that the context is fully built before accessing it
              getIt<NavigationService>().navigateReplace(CustomBottomNav());
            });
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}