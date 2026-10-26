import 'package:flutter/material.dart';

import 'home_screen.dart';

void main() {
  runApp(const MiniProfileApp());
}

class MiniProfileApp extends StatelessWidget {
  const MiniProfileApp({super.key});

  static const Color primaryColor = Color(0xFF5B5FEF);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Profile Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        scaffoldBackgroundColor: const Color(0xFFF5F6FC),
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
