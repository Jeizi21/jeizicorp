import 'package:flutter/material.dart';

import 'cleaning_dashboard_screen.dart';

void main() {
  runApp(const CleaningApp());
}

class CleaningApp extends StatelessWidget {
  const CleaningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Módulo de Limpieza',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const CleaningDashboardScreen(),
    );
  }
}
