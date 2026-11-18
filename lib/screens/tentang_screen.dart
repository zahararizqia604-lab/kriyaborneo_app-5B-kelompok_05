import 'package:flutter/material.dart';

class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key});

  @override
  Widget build(BuildContext context) {
    const anggotaKelompok = [
      {'nama': 'Rizqia Zahara', 'nim': 'E030424066'},
      {'nama': 'Nazwa Astrid NS', 'nim': 'E030424057'},
      {'nama': 'Rasyifa Alicia Puteri', 'nim': 'E030424089'},
      {'nama': 'Azkia Ainu Zulfa', 'nim': 'E030424044'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Tentang Kriya Borneo'),
        backgroundColor: const Color(0xFF064E3B),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Kartu Profil UMKM
            Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo_borneo.png',
                      width: 90,
                      height: 90,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.storefront_rounded,
                        size: 70,
                        color: Color(0xFF064E3B),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Galeri Kriya Borneo',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF064E3B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Pusat Sasirangan & Kerajinan Tangan Kalimantan Selatan',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const Divider(height: 28),
                    const Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Color(0xFFB45309),
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Jl. Kampung Sasirangan, Seberang Mesjid, Banjarmasin',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Color(0xFFB45309),
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Buka Setiap Hari: 09.00 – 21.00 WITA',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Kriya Borneo menghadirkan karya autentik pengrajin lokal Kalimantan Selatan, mulai dari kain sasirangan pewarna alam, anyaman purun Hulu Sungai, kopiah jangang Margasari, hingga perhiasan batu kecubung Martapura.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.5,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Kartu Daftar Tim Kelompok 05
            Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.groups_rounded, color: Color(0xFF064E3B)),
                        SizedBox(width: 8),
                        Text(
                          'Tim Pengembang (Kelompok 05 - 5B)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF064E3B),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    ...anggotaKelompok.map((anggota) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundColor: const Color(0xFF064E3B)
                              .withValues(alpha: 0.12),
                          child: const Icon(
                            Icons.person,
                            color: Color(0xFF064E3B),
                          ),
                        ),
                        title: Text(
                          anggota['nama']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        subtitle: Text(
                          anggota['nim']!,
                          style: const TextStyle(fontSize: 12),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
