import 'package:flutter/material.dart';

import 'screens/login_screen.dart';

void main() {
  runApp(const IndustrialControlApp());
}

class IndustrialControlApp extends StatelessWidget {
  const IndustrialControlApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryOrange = Color(0xFFF57C00);
    return MaterialApp(
      title: 'Control Diario Industrial',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryOrange),
        scaffoldBackgroundColor: const Color(0xFFFFF3E0),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryOrange,
          foregroundColor: Colors.white,
          elevation: 1,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryOrange, width: 2),
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
