import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movie_verse/provider/favorite_provider.dart';
import 'package:movie_verse/provider/movie_provider.dart';
import 'package:movie_verse/provider/stripe_payment_provider.dart';
import 'package:movie_verse/provider/tv_shows_provider.dart';
import 'package:movie_verse/screens/splash_screen.dart';
import 'package:movie_verse/services/init_getIt.dart';
import 'package:movie_verse/services/navigation_service.dart';
import 'package:provider/provider.dart';

import 'constants/my_app_constants.dart';
import 'constants/my_app_theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //final navigationKey = NavigationService().navigatorKey;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSplash();
  }
  initSplash() async {
    debugPrint("Init Splash");
    await Future.delayed(const Duration(seconds: 3));
    debugPrint("Remove Splash");
    FlutterNativeSplash.remove();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MovieProvider>(create: (_) => MovieProvider()),
        ChangeNotifierProvider<FavoriteProvider>(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider<TvShowsProvider>(create: (_) => TvShowsProvider()),
        ChangeNotifierProvider<StripePaymentProvider>(create: (_) => StripePaymentProvider()),
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