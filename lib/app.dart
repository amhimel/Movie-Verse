import 'package:flutter/material.dart';
import 'package:movie_verse/widgets/custom_bottom_nav.dart';

import 'constants/my_app_constants.dart';
import 'constants/my_app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyAppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: MyAppTheme.darkTheme,
      home: CustomBottomNav(),
    );
  }
}