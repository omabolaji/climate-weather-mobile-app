import 'package:flutter/material.dart';
import 'loading_screen.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  runApp(
    ClimateApp(),
  );
}

class ClimateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: LoadingScreen(),
    );
  }
}
