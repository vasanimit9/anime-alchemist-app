import 'package:anime_alchemist/screens/home.dart';
import 'package:anime_alchemist/screens/news.dart';
import 'package:anime_alchemist/screens/releases.dart';
import 'package:anime_alchemist/constants.dart';
import 'package:anime_alchemist/screens/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: CustomColors.bgColor,
        scaffoldBackgroundColor: CustomColors.bgColor,
      ),
      initialRoute: Home.route,
      routes: {
        Home.route: (context) => Home(),
        News.route: (context) => News(),
        Releases.route: (context) => Releases(),
        WebViewScreen.route: (context) => WebViewScreen(),
      },
    );
  }
}
