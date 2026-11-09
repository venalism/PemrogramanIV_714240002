import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final int contactCount;
  final VoidCallback onOpenContacts;

  const HomeScreen({
    super.key,
    required this.contactCount,
    required this.onOpenContacts,
  });

  // GANTI dengan data Anda.
  static const String nama = 'Nadi Azzada Akbar';
  static const String npm = '714240002';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: SafeArea(
        child: Center(
          child: Card(
            margin: const EdgeInsets.all(24),
            elevation: 4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 48,
                    child: Icon(Icons.person, size: 48),
                  ),
                  const SizedBox(height: 16),
                  const Text(nama,
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text('NPM: $npm', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 4),
                  const Text('D4 Teknik Informatika - ULBI'),
                  const SizedBox(height: 16),
                  Text('Jumlah kontak tersimpan: $contactCount'),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: onOpenContacts,
                    icon: const Icon(Icons.contacts),
                    label: const Text('Buka Daftar Kontak'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}