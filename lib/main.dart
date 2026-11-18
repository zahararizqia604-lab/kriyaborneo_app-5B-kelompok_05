import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';

void main() {
  runApp(const KriyaBorneoApp());
}

class KriyaBorneoApp extends StatelessWidget {
  const KriyaBorneoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kriya Borneo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF064E3B)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
