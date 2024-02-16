import 'package:flutter/material.dart';
import 'package:up_flix/colors.dart';
import 'package:up_flix/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uptflix',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colorss.scaffoldBgColor,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
