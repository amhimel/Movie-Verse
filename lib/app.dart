import 'package:flutter/material.dart';
import 'package:movie_verse/provider/favorite_provider.dart';
import 'package:movie_verse/provider/movie_provider.dart';
import 'package:movie_verse/provider/tv_shows_provider.dart';
import 'package:movie_verse/screens/splash_screen.dart';
import 'package:movie_verse/services/init_getIt.dart';
import 'package:movie_verse/services/navigation_service.dart';
import 'package:movie_verse/widgets/custom_bottom_nav.dart';
import 'package:provider/provider.dart';

import 'constants/my_app_constants.dart';
import 'constants/my_app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  //final navigationKey = NavigationService().navigatorKey;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MovieProvider>(create: (_) => MovieProvider()),
        ChangeNotifierProvider<FavoriteProvider>(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider<TvShowsProvider>(create: (_) => TvShowsProvider()),
      ],
      child: MaterialApp(
        navigatorKey: getIt<NavigationService>().navigatorKey,
        title: MyAppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: MyAppTheme.darkTheme,
        home: SplashScreen(),
      ),
    );
  }
}