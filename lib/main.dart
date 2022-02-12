import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salla/core/style/themes.dart';
import 'package:salla/features/onBoarding/presentation/pages/onBoarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: OnBoarding());
  }
}
