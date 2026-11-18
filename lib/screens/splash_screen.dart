import 'dart:async';

import 'package:flutter/material.dart';

import 'katalog_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Pindah otomatis ke halaman katalog setelah 10 detik
    Timer(const Duration(seconds: 10), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HalamanKatalog()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF064E3B), // Hijau zamrud khas Borneo
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Menampilkan logo dari folder assets/images/
              Image.asset(
                'assets/images/logo_borneo.png',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
                // Ikon cadangan otomatis jika nama file gambar belum terbaca
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.storefront_rounded,
                    size: 100,
                    color: Color(0xFFD4AF37),
                  );
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'KRIYA BORNEO',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.5,
                  color: Color(0xFFD4AF37), // Warna emas
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Galeri Kriya & Sasirangan Khas Kalsel',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
              const SizedBox(height: 36),
              const SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  color: Color(0xFFD4AF37),
                  strokeWidth: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
