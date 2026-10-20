# Pertemuan 04 – Praktikum Latihan: Layout Row & Column dengan MainAxisAlignment

**Mata Kuliah:** Pemrograman Mobile  
**NIM:** 714240002  
**Pertemuan:** 04  
**Jenis:** Praktikum – Latihan (`latihan04`)  

---

## 📋 Deskripsi Project

Project Flutter ini merupakan hasil **latihan praktikum Pertemuan 04** yang berfokus pada pemahaman mendalam tentang sistem layout di Flutter, khususnya penggunaan widget `Row` dan `Column` dengan berbagai nilai properti `mainAxisAlignment`. Project ini secara visual mendemonstrasikan perbedaan perilaku setiap nilai `MainAxisAlignment` dalam mengatur posisi child widget secara horizontal.

---

## 🗂️ Struktur File

```
lib/
├── main.dart           # Entry point aplikasi (tidak aktif digunakan, hanya referensi)
├── material_app.dart   # Root widget yang mengonfigurasi MaterialApp
├── material_page.dart  # Halaman utama berisi demonstrasi MainAxisAlignment
├── stateful.dart       # Contoh StatefulWidget (counter interaktif)
└── stateless.dart      # Contoh StatelessWidget (UI statis)
```

---

## 📄 Dokumentasi Kode

### `main.dart`

File entry point yang mengatur konfigurasi aplikasi dan mendelegasikan tampilan ke `AppMaterial`.

```dart
import 'package:flutter/material.dart';    // Mengimpor library Material Design Flutter
import 'package:pone/material_app.dart';   // Mengimpor widget AppMaterial sebagai root

void main() {
  runApp(const AppMaterial()); // Titik masuk program; menjalankan AppMaterial sebagai root widget
}
```

**Kelas `MyApp` (StatelessWidget – referensi boilerplate):**
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Konstruktor const dengan key diteruskan ke parent

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo', // Judul aplikasi di task switcher OS
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), // Skema warna dari satu seed color
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'), // Halaman awal aplikasi
    );
  }
}
```

**Kelas `MyHomePage` (StatefulWidget – referensi boilerplate):**
```dart
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title}); // Parameter title wajib diisi

  final String title; // Properti final: nilai tidak berubah setelah widget dibuat

  @override
  State<MyHomePage> createState() => _MyHomePageState(); // Membuat State terkait widget ini
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0; // State: menyimpan jumlah tombol ditekan

  void _incrementCounter() {
    setState(() {  // Memberitahu Flutter bahwa state berubah → UI akan dirender ulang
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
          mainAxisAlignment: MainAxisAlignment.center, // Child Column diposisikan di tengah vertikal
          children: [
            const Text('You have pushed the button this many times:'), // Teks statis
            Text(
              '$_counter',                                       // Nilai counter ditampilkan dinamis
              style: Theme.of(context).textTheme.headlineMedium, // Style dari tema aplikasi
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter, // Memanggil fungsi increment saat tombol ditekan
        tooltip: 'Increment',         // Tooltip yang muncul saat tombol ditekan lama
        child: const Icon(Icons.add), // Ikon "+" pada FAB
      ),
    );
  }
}
```

---

### `material_app.dart`

File root widget yang mengonfigurasi `MaterialApp` dan menentukan tema serta halaman awal.

```dart
import 'package:flutter/material.dart';    // Mengimpor library Material Design
import 'package:pone/material_page.dart';  // Mengimpor halaman HomePage

class AppMaterial extends StatelessWidget {
  const AppMaterial({super.key}); // Konstruktor const

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: false), // Menggunakan tema terang dengan Material 2 (bukan Material 3)
      home: HomePage(),                             // Halaman awal yang ditampilkan
    );
  }
}
```

> **Catatan:** Parameter `useMaterial3: false` secara eksplisit menonaktifkan Material Design 3, sehingga tampilan menggunakan komponen Material Design 2 yang lebih klasik.

---

### `material_page.dart`

File inti project ini. Mendemonstrasikan semua nilai `MainAxisAlignment` pada widget `Row` secara berurutan.

**Kelas `HomePage` (StatelessWidget – Halaman Utama):**
```dart
class HomePage extends StatelessWidget {
  const HomePage({super.key}); // Konstruktor const

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),              // Judul halaman
        backgroundColor: Colors.lightBlue,    // Warna AppBar biru muda
      ),
      drawer: Drawer(                          // Panel navigasi samping
        child: ListView(
          children: [
            ListTile(title: Text('Homepage')), // Item navigasi pertama: Homepage
            ListTile(title: Text('Settings')), // Item navigasi kedua: Settings
          ],
        ),
      ),
      body: MyContainer(), // Body menggunakan widget MyContainer yang berisi demonstrasi layout
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),         // Tab Home
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'), // Tab Settings
        ],
      ),
    );
  }
}
```

**Kelas `MyContainer` (StatelessWidget – Inti Demonstrasi Layout):**

Widget ini menampilkan 6 baris ikon secara berurutan, masing-masing dengan nilai `MainAxisAlignment` yang berbeda, disertai label penjelasnya.

```dart
class MyContainer extends StatelessWidget {
  const MyContainer({super.key}); // Konstruktor const

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Semua child rata ke kiri (sumbu silang/horizontal)
      children: <Widget>[

        // ── HEADER ──
        Text(
          'Task',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold), // Judul besar dan tebal
        ),
        SizedBox(height: 20), // Spasi vertikal 20 pixel

        // ── DEMO 1: spaceEvenly ──
        Text('MainAxisAlignment: MainAxisAlignment.spaceEvenly'), // Label penjelasan
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Jarak antar ikon dan tepi sama rata
          children: <Widget>[
            Icon(Icons.share),      // Ikon pertama: Share
            Icon(Icons.thumb_up),   // Ikon kedua: Jempol atas
            Icon(Icons.thumb_down), // Ikon ketiga: Jempol bawah
          ],
        ),
        SizedBox(height: 20),

        // ── DEMO 2: spaceAround ──
        Text('MainAxisAlignment: MainAxisAlignment.spaceAround'), // Label penjelasan
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, // Jarak di sekitar setiap item sama; tepi = setengah jarak antar item
          children: <Widget>[
            Icon(Icons.share),
            Icon(Icons.thumb_up),
            Icon(Icons.thumb_down),
          ],
        ),
        SizedBox(height: 20),

        // ── DEMO 3: spaceBetween ──
        Text('MainAxisAlignment: MainAxisAlignment.spaceBetween'), // Label penjelasan
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Item pertama & terakhir menempel ke tepi; sisa jarak dibagi rata
          children: <Widget>[
            Icon(Icons.share),
            Icon(Icons.thumb_up),
            Icon(Icons.thumb_down),
          ],
        ),
        SizedBox(height: 20),

        // ── DEMO 4: start ──
        Text('MainAxisAlignment: MainAxisAlignment.start'), // Label penjelasan
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start, // Semua item menempel ke tepi kiri (awal sumbu utama)
          children: <Widget>[
            Icon(Icons.share),
            Icon(Icons.thumb_up),
            Icon(Icons.thumb_down),
          ],
        ),
        SizedBox(height: 20),

        // ── DEMO 5: center ──
        Text('MainAxisAlignment: MainAxisAlignment.center'), // Label penjelasan
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center, // Semua item diposisikan di tengah baris
          children: <Widget>[
            Icon(Icons.share),
            Icon(Icons.thumb_up),
            Icon(Icons.thumb_down),
          ],
        ),
        SizedBox(height: 20),

        // ── DEMO 6: end ──
        Text('MainAxisAlignment: MainAxisAlignment.end'), // Label penjelasan
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end, // Semua item menempel ke tepi kanan (akhir sumbu utama)
          children: <Widget>[
            Icon(Icons.share),
            Icon(Icons.thumb_up),
            Icon(Icons.thumb_down),
          ],
        ),
      ],
    );
  }
}
```

---

### `stateful.dart`

File ini merupakan contoh mandiri `StatefulWidget` yang menampilkan counter interaktif dengan tema gelap.

```dart
import 'package:flutter/material.dart'; // Mengimpor library Material Design

void main() => runApp(const MyStateful()); // Entry point alternatif; menjalankan MyStateful langsung

class MyStateful extends StatefulWidget {
  const MyStateful({super.key}); // Konstruktor const

  @override
  State<MyStateful> createState() => _MyStatefulState(); // Membuat objek State
}

class _MyStatefulState extends State<MyStateful> {
  int counter = 0; // State: variabel yang merespons aksi pengguna dan memicu rebuild UI

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(), // Tema gelap untuk seluruh aplikasi
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Column hanya sebesar ukuran children-nya, tidak full height
            children: [
              Text('ARIF BANYAK BERDOA'),   // Teks statis
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    counter--; // Mengurangi counter 1; setState memicu build() dipanggil ulang
                  });
                },
                child: const Text('- 1 dosa'), // Label tombol pengurangan
              ),
              Text('ARIF BANYAK DOSA'),     // Teks statis
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    counter++; // Menambah counter 1; setState memicu build() dipanggil ulang
                  });
                },
                child: const Text('+ 1 dosa'), // Label tombol penambahan
              ),
              Text('Total dosa: $counter'),  // Nilai counter ditampilkan dinamis via string interpolation
            ],
          ),
        ),
      ),
    );
  }
}
```

---

### `stateless.dart`

File ini menunjukkan keterbatasan `StatelessWidget`: tombol yang ditekan tidak dapat memperbarui tampilan karena tidak ada mekanisme state.

```dart
import 'package:flutter/material.dart'; // Mengimpor library Material Design

class MyWidget extends StatelessWidget {
  const MyWidget({super.key}); // Konstruktor const; tidak menerima parameter dari luar

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo', // Judul aplikasi
      home: Scaffold(
        body: Column(
          children: [
            Center(
              child: Text('Arif banyak dosa'), // Teks yang ditampilkan di tengah secara horizontal
            ),
            ElevatedButton(
              onPressed: () {
                int counter = 0; // Variabel lokal – bukan state, nilainya tidak tersimpan
                counter++;       // Operasi ini tidak mengubah UI karena tidak ada setState
              },
              child: Text('+ 1 dosa'), // Label tombol
            ),
          ],
        ),
      ),
      theme: ThemeData.dark() // Tema gelap untuk seluruh aplikasi
    );
  }
}
```

---

## 🧩 Konsep Utama yang Dipelajari

### Perbandingan `MainAxisAlignment` pada Widget `Row`

| Nilai | Perilaku |
|---|---|
| `start` | Semua item menempel ke tepi kiri (awal sumbu) |
| `center` | Semua item diposisikan di tengah baris |
| `end` | Semua item menempel ke tepi kanan (akhir sumbu) |
| `spaceBetween` | Item pertama dan terakhir di tepi; sisa ruang dibagi rata di antara item |
| `spaceAround` | Setiap item mendapat ruang yang sama di sekitarnya; ruang di tepi = ½ ruang antar item |
| `spaceEvenly` | Seluruh ruang (termasuk tepi) dibagi merata di antara semua item |

### Konsep Flutter Lainnya

| Konsep | Penjelasan |
|---|---|
| `CrossAxisAlignment.start` | Mengatur posisi child pada sumbu silang (vertikal untuk `Column`) ke posisi awal/kiri |
| `SizedBox` | Widget kotak kosong yang digunakan sebagai spasi tetap antara widget |
| `ThemeData.light(useMaterial3: false)` | Menggunakan tema terang dengan komponen Material Design versi 2 |

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
