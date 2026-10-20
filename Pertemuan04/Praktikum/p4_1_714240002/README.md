# Pertemuan 04 – Praktikum 1: Halaman Detail Tempat Wisata Bandung

**Mata Kuliah:** Pemrograman Mobile  
**NIM:** 714240002  
**Pertemuan:** 04  
**Jenis:** Praktikum – Project (`p4_1_714240002`)  

---

## 📋 Deskripsi Project

Project Flutter ini merupakan hasil **praktikum 1 Pertemuan 04** yang membangun sebuah halaman detail tempat wisata di Bandung, yaitu **Ranca Upas Ciwidey**. Project ini mendemonstrasikan penggunaan widget layout `Column`, `Row`, `Container`, `SafeArea`, dan `Scaffold` untuk membangun tampilan informasi yang terstruktur dan informatif, tanpa menggunakan AppBar tradisional.

---

## 🗂️ Struktur File

```
lib/
├── main.dart           # Entry point awal (tidak menggunakan halaman utama / home kosong)
├── material_app.dart   # Root widget yang menjalankan halaman DetailScreen
└── material_page.dart  # Halaman detail tempat wisata Ranca Upas
```

---

## 📄 Dokumentasi Kode

### `main.dart`

File entry point aplikasi yang menginisialisasi `MyApp` tanpa halaman utama (home), berfungsi sebagai scaffolding awal.

```dart
import 'package:flutter/material.dart'; // Mengimpor library Material Design Flutter

void main() {
  runApp(const MyApp()); // Titik masuk program; menjalankan MyApp sebagai root widget
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Konstruktor const dengan key diteruskan ke parent

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tempat Wisata Bandung.' // Judul aplikasi di task switcher OS; tidak ada halaman home
    );
  }
}
```

**Kelas `MyHomePage` (StatefulWidget – referensi boilerplate, tidak digunakan secara aktif):**
```dart
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title}); // Parameter title wajib diisi

  final String title; // Properti final: nilai tidak berubah setelah widget dibuat

  @override
  State<MyHomePage> createState() => _MyHomePageState(); // Membuat State terkait
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0; // State: menyimpan jumlah tombol ditekan

  void _incrementCounter() {
    setState(() {  // Memberitahu Flutter bahwa state berubah → UI dirender ulang
      _counter++;  // Menambah nilai counter sebesar 1
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary, // Warna AppBar dari tema
        title: Text(widget.title), // Menampilkan judul dari properti widget
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Posisikan child di tengah vertikal
          children: [
            const Text('You have pushed the button this many times:'), // Teks statis keterangan
            Text(
              '$_counter',                                       // Nilai counter ditampilkan dinamis
              style: Theme.of(context).textTheme.headlineMedium, // Style dari tema aplikasi
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter, // Memanggil fungsi increment saat ditekan
        tooltip: 'Increment',         // Tooltip yang muncul saat ditekan lama
        child: const Icon(Icons.add), // Ikon "+" pada FAB
      ),
    );
  }
}
```

---

### `material_app.dart`

File root widget yang menginisialisasi aplikasi dan langsung menavigasi ke halaman `DetailScreen`.

```dart
import 'package:flutter/material.dart'; // Mengimpor library Material Design
import 'material_page.dart';            // Mengimpor halaman DetailScreen dari file yang sama package

void main() {
  runApp(const MyApp()); // Entry point alternatif yang aktif digunakan; menjalankan MyApp
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Konstruktor const

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tempat Wisata Bandung.', // Judul aplikasi
      home: const DetailScreen(),       // Halaman awal langsung menampilkan DetailScreen
    );
  }
}
// Komentar di bawah adalah bagian dari kode yang dapat dikembangkan lebih lanjut
```

---

### `material_page.dart`

File utama yang membangun tampilan halaman detail tempat wisata Ranca Upas dengan informasi lengkap dan layout yang terstruktur.

```dart
import 'package:flutter/material.dart'; // Mengimpor library Material Design

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key}); // Konstruktor const; tidak menerima parameter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( // SafeArea memastikan konten tidak tertimpa notch, status bar, atau gesture area
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Merentangkan child secara horizontal sepenuh layar
          children: <Widget>[

            // ── BLOK 1: JUDUL TEMPAT WISATA ──
            Container(
              margin: const EdgeInsets.only(top: 16.0), // Memberi jarak 16 pixel dari atas
              child: const Text(
                'Ranca Upas',                              // Nama tempat wisata
                textAlign: TextAlign.center,               // Teks rata tengah secara horizontal
                style: TextStyle(
                  fontSize: 30,                            // Ukuran font besar (30 pixel)
                  fontWeight: FontWeight.bold,             // Ketebalan font: tebal
                ),
              ),
            ),

            // ── BLOK 2: INFORMASI CEPAT (JAM, HARGA, HARI BUKA) ──
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0), // Jarak vertikal 16 pixel (atas & bawah)
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Tiga kolom info dibagi merata secara horizontal
                children: [

                  // Kolom 1: Hari Buka
                  const Column(
                    children: const [
                      Icon(Icons.calendar_today),  // Ikon kalender untuk menandai informasi hari buka
                      SizedBox(height: 8.0),        // Spasi vertikal 8 pixel antara ikon dan teks
                      Text('Open Everyday'),         // Keterangan: buka setiap hari
                    ],
                  ),

                  SizedBox(width: 16.0), // Spasi horizontal 16 pixel antara kolom info

                  // Kolom 2: Jam Operasional
                  const Column(
                    children: const [
                      Icon(Icons.access_time),  // Ikon jam untuk menandai informasi jam operasional
                      SizedBox(height: 8.0),     // Spasi vertikal 8 pixel
                      Text('9:00 - 20:00'),      // Keterangan: jam buka pukul 9 pagi hingga 8 malam
                    ],
                  ),

                  SizedBox(width: 16.0), // Spasi horizontal 16 pixel antara kolom info

                  // Kolom 3: Harga Tiket
                  const Column(
                    children: const [
                      Icon(Icons.monetization_on), // Ikon uang untuk menandai informasi harga
                      SizedBox(height: 8.0),        // Spasi vertikal 8 pixel
                      Text('Rp 20.000'),             // Keterangan: harga tiket masuk
                    ],
                  ),
                ],
              ),
            ),

            // ── BLOK 3: DESKRIPSI TEMPAT WISATA ──
            Container(
              padding: const EdgeInsets.all(16.0), // Padding dalam 16 pixel di semua sisi
              child: const Text(
                'Ranca Upas Ciwidey adalah kawasan bumi perkemahan di bawah pengelolaan perhutani. '
                'Tempat ini berada di kawasan wisata Bandung Selatan, satu lokasi dengan kawah putih, '
                'kolam Cimanggu dan situ Patenggang. Banyak hal yang bisa dilakukan di kawasan wisata ini, '
                'seperti berkemah, berinteraksi dengan rusa, sampai bermain di water park dan mandi air panas.',
                // Deskripsi lengkap tentang tempat wisata
                textAlign: TextAlign.justify, // Teks rata kanan-kiri (justified) untuk tampilan rapi
                style: TextStyle(fontSize: 16.0), // Ukuran font 16 pixel untuk teks deskripsi
              ),
            ),

          ],
        ),
      ),
    );
  }
}
```

---

## 🧩 Konsep Utama yang Dipelajari

| Konsep | Penjelasan |
|---|---|
| `SafeArea` | Widget yang memberikan padding otomatis agar konten tidak tertimpa area sistem (notch, status bar, navigation bar). |
| `CrossAxisAlignment.stretch` | Merentangkan semua child `Column` untuk mengisi lebar penuh parent (sumbu silang). |
| `EdgeInsets.only(top: ...)` | Memberikan margin hanya pada sisi tertentu (dalam hal ini, hanya atas). |
| `EdgeInsets.symmetric(vertical: ...)` | Memberikan margin yang sama pada sisi atas dan bawah sekaligus. |
| `EdgeInsets.all(...)` | Memberikan padding yang sama di semua sisi (atas, bawah, kiri, kanan). |
| `MainAxisAlignment.spaceEvenly` | Mendistribusikan item dalam `Row` secara merata termasuk di tepi. |
| `textAlign: TextAlign.justify` | Meratakan teks ke kiri dan kanan secara bersamaan, sehingga setiap baris memiliki lebar yang sama. |
| `Icon` | Widget untuk menampilkan ikon dari kumpulan Material Icons. |

---

## 🗺️ Fitur Aplikasi

- **Judul Tempat Wisata** – Nama "Ranca Upas" ditampilkan besar dan tebal di bagian atas.
- **Info Cepat** – Tiga kolom ikon yang menyajikan informasi hari buka, jam operasional, dan harga tiket secara ringkas.
- **Deskripsi** – Paragraf deskriptif yang menjelaskan tempat wisata secara lengkap dengan format rata kanan-kiri.

---

## 🚀 Cara Menjalankan

```bash
flutter pub get   # Mengunduh semua dependensi
flutter run       # Menjalankan aplikasi di emulator/perangkat
```

---

## 📦 Dependensi

| Package | Versi | Keterangan |
|---|---|---|
| `flutter` | SDK | Framework utama |
| `cupertino_icons` | ^1.0.8 | Ikon gaya iOS |
| `flutter_lints` | ^6.0.0 | Aturan lint untuk kode yang bersih |

**Dart SDK:** `^3.13.5`
