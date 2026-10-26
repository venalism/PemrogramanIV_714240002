import 'package:flutter/material.dart';

import 'detail_screen.dart';
import 'profile_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Color primaryColor = Color(0xFF5B5FEF);
  static const Color inkColor = Color(0xFF20223A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas Pertemuan 5'),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color(0xFFEEF0FF),
              Color(0xFFF8F8FC),
              Color(0xFFEAF7FF),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 390),
              child: Card(
                elevation: 9,
                shadowColor: primaryColor.withValues(alpha: 0.14),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(28, 32, 28, 28),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEEFFF),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          'STUDENT PROFILE',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: primaryColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(26),
                        child: Image.asset(
                          profileImageAsset,
                          width: 160,
                          height: 160,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 160,
                              height: 160,
                              color: const Color(0xFFEEEFFF),
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.person_rounded,
                                size: 76,
                                color: primaryColor,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        studentName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: inkColor,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F9),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Text(
                          'NPM: $studentNpm',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF60637A),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) => const DetailScreen(
                                  name: studentName,
                                  npm: studentNpm,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.badge_outlined),
                          label: const Text('Lihat Detail Profil'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            minimumSize: const Size.fromHeight(54),
                            textStyle: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
