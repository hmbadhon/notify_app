import 'package:fcm_config/fcm_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hmb_app/get_di.dart';
import 'package:hmb_app/utils/constants.dart';
import 'package:hmb_app/view/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;
void main() async {
  await FCMConfig.instance
      .init(
    defaultAndroidChannel: const AndroidNotificationChannel(
      'test',
      'test app',
    ),
  )
      .then(
    (value) {
      if (!kIsWeb) {
        FCMConfig.instance.messaging.subscribeToTopic('test');
      }
    },
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await init();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Test App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: kPrimaryColor,
        ),
        fontFamily: GoogleFonts.roboto().fontFamily,
        primaryColor: kPrimaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      defaultTransition: Transition.rightToLeft,
      transitionDuration: Duration(
        milliseconds: 500,
      ),
      home: SplashScreen(),
    );
  }
}
