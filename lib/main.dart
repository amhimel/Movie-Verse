import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:movie_verse/services/init_getIt.dart';
import 'app.dart';
import 'constants/stripe_keys.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Stripe.publishableKey = StripeKeys.publishableKey;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    _,
  ) async {
    setUpLocator();
    await dotenv.load(fileName: "assets/.env");
    runApp(const MyApp());
  });
}
