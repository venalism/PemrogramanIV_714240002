# Pertemuan 03 – Praktikum: Pengenalan Widget StatelessWidget & StatefulWidget

**Mata Kuliah:** Pemrograman Mobile  
**NIM:** 714240002  
**Pertemuan:** 03  
**Jenis:** Praktikum  

---

## 📋 Deskripsi Project

Project Flutter ini merupakan hasil praktikum **Pertemuan 03** yang berfokus pada pemahaman dasar konsep widget di Flutter, khususnya perbedaan antara **StatelessWidget** dan **StatefulWidget**. Project ini juga mendemonstrasikan penggunaan berbagai komponen Material Design seperti `Scaffold`, `AppBar`, `Drawer`, `BottomNavigationBar`, dan `FloatingActionButton`.

---

## 🗂️ Struktur File

```
lib/
├── main.dart           # Entry point aplikasi & contoh widget bawaan Flutter
├── material_app.dart   # Root widget aplikasi menggunakan AppMaterial
├── material_page.dart  # Halaman utama dengan komponen Material Design lengkap
├── stateful.dart       # Contoh implementasi StatefulWidget (counter interaktif)
└── stateless.dart      # Contoh implementasi StatelessWidget (tampilan statis)
```

---

## 📄 Dokumentasi Kode

### `main.dart`

File utama yang menjadi entry point aplikasi Flutter.

```dart
import 'package:flutter/material.dart';   // Mengimpor library Material Design Flutter
import 'package:pone/stateless.dart';     // Mengimpor widget MyWidget (StatelessWidget)
import 'package:pone/stateful.dart';      // Mengimpor widget MyStateful (StatefulWidget)
import 'package:pone/material_app.dart';  // Mengimpor widget AppMaterial (root app)

void main() {
  runApp(const AppMaterial()); // Titik masuk program; menjalankan widget AppMaterial sebagai root
}
```

**Kelas `MyApp` (StatelessWidget):**
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Konstruktor const; super.key diteruskan ke parent untuk optimasi widget tree

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',            // Judul aplikasi (muncul di task switcher OS)
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), // Membuat skema warna dari satu warna dasar
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'), // Widget halaman utama yang ditampilkan pertama kali
    );
  }
}
```

**Kelas `MyHomePage` (StatefulWidget):**
```dart
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title}); // Parameter title wajib diisi

  final String title; // Properti title bersifat final (tidak berubah setelah inisialisasi)

  @override
  State<MyHomePage> createState() => _MyHomePageState(); // Membuat objek State terkait
}
```

**Kelas `_MyHomePageState` (State dari MyHomePage):**
```dart
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0; // Variabel state: menyimpan jumlah klik tombol, diawali 0

  void _incrementCounter() {
    setState(() {      // setState() memberi tahu Flutter bahwa state berubah → build() akan dipanggil ulang
      _counter++;      // Menambah nilai counter sebesar 1
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary, // Warna AppBar mengikuti tema aplikasi
        title: Text(widget.title), // Menampilkan properti title dari widget induk
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Memusatkan children secara vertikal
          children: [
            const Text('You have pushed the button this many times:'), // Teks keterangan statis
            Text(
              '$_counter',                                      // Menampilkan nilai counter secara dinamis
              style: Theme.of(context).textTheme.headlineMedium, // Menggunakan style teks bawaan tema
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter, // Memanggil fungsi increment saat tombol ditekan
        tooltip: 'Increment',         // Teks tooltip muncul saat tombol ditekan lama
        child: const Icon(Icons.add), // Ikon "+" pada tombol
      ),
    );
  }
}
```

---

### `material_app.dart`

File ini berisi widget root aplikasi yang mengonfigurasi `MaterialApp` dan menentukan halaman awal.

```dart
import 'package:flutter/material.dart';      // Mengimpor library Material Design
import 'package:pone/material_page.dart';    // Mengimpor halaman HomePage

class AppMaterial extends StatelessWidget {
  const AppMaterial({super.key}); // Konstruktor const untuk efisiensi widget tree

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const HomePage()); // Menjalankan MaterialApp dengan HomePage sebagai halaman utama
  }
}
```

---

### `material_page.dart`

File ini mendemonstrasikan penggunaan berbagai komponen Material Design dalam satu halaman, sekaligus memperlihatkan perbedaan antara `StatelessWidget` dan `StatefulWidget` dalam konteks yang lebih kompleks.

**Kelas `HomePage` (StatelessWidget – Halaman Utama):**
```dart
class HomePage extends StatelessWidget {
  const HomePage({super.key}); // Konstruktor const

  @override
  Widget build(BuildContext context) {
    return Scaffold(                     // Kerangka halaman Material Design
      appBar: AppBar(
        title: const Text('Home'),       // Judul di AppBar
        backgroundColor: Colors.blue,   // Warna latar AppBar biru
      ),
      drawer: Drawer(                    // Panel navigasi yang muncul dari kiri layar
        child: ListView(
          padding: EdgeInsets.zero,      // Menghilangkan padding default ListView agar DrawerHeader menempel ke atas
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue), // Header drawer dengan latar biru
              child: Text('Drawer Header'),                   // Teks judul header drawer
            ),
            ListTile(
              title: const Text('Home'),   // Item menu "Home"
              onTap: () {
                // Logika navigasi ke halaman Home (belum diimplementasikan)
              },
            ),
            ListTile(
              title: const Text('Profile'), // Item menu "Profile"
              onTap: () {
                // Logika navigasi ke halaman Profile (belum diimplementasikan)
              },
            ),
          ],
        ),
      ),
      body: const Center(child: BiggerText(teks: "Hello ULBI")), // Body menampilkan widget BiggerText di tengah
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int counter = 0; // Variabel lokal (tidak terhubung ke state, hanya demonstrasi)
          counter++;        // Operasi increment yang tidak berdampak ke UI karena bukan state
        },
        backgroundColor: Colors.blue,   // Warna tombol FAB biru
        shape: const CircleBorder(),     // Bentuk tombol lingkaran sempurna
        child: const Icon(Icons.add),    // Ikon "+" pada FAB
      ),
      bottomNavigationBar: BottomNavigationBar( // Navigasi bawah dengan dua item
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),         // Tab Home
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'), // Tab Settings
        ],
      ),
    );
  }
}
```

**Kelas `Heading` (StatelessWidget – Teks Judul):**
```dart
class Heading extends StatelessWidget {
  final String text;                               // Properti teks yang diterima dari parent
  const Heading({Key? key, required this.text}) : super(key: key); // Konstruktor dengan key opsional

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 28.0,              // Ukuran font 28 pixel
        fontWeight: FontWeight.bold, // Ketebalan font: tebal
      ),
    );
  }
}
```

**Kelas `BiggerText` (StatefulWidget – Teks Dinamis):**
```dart
class BiggerText extends StatefulWidget {
  final String teks;                                              // Properti teks yang diterima dari parent
  const BiggerText({Key? key, required this.teks}) : super(key: key);

  @override
  State<BiggerText> createState() => _BiggerTextState(); // Membuat objek State
}

class _BiggerTextState extends State<BiggerText> {
  double _textSize = 16.0; // State: ukuran font awal adalah 16.0 pixel

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Memusatkan children secara vertikal
      children: <Widget>[
        Text(widget.teks, style: TextStyle(fontSize: _textSize)), // Teks dengan ukuran dinamis dari state
        ElevatedButton(
          child: Text(_textSize == 16.0 ? "Perbesar" : "Perkecil"), // Label tombol berubah sesuai kondisi
          onPressed: () {
            setState(() {
              // Toggle ukuran font: jika 16 → jadi 32, jika 32 → jadi kembali 16
              _textSize = _textSize == 16.0 ? 32.0 : 16.0;
            });
          },
        ),
      ],
    );
  }
}
```

---

### `stateful.dart`

File ini merupakan contoh mandiri (standalone) penggunaan **StatefulWidget** untuk membangun UI yang reaktif terhadap interaksi pengguna.

```dart
import 'package:flutter/material.dart'; // Mengimpor library Material Design

void main() => runApp(const MyStateful()); // Entry point alternatif; menjalankan MyStateful langsung

class MyStateful extends StatefulWidget {
  const MyStateful({super.key}); // Konstruktor const

  @override
  State<MyStateful> createState() => _MyStatefulState(); // Membuat objek State terkait
}

class _MyStatefulState extends State<MyStateful> {
  int counter = 0; // State: variabel counter yang merespons aksi pengguna

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(), // Menggunakan tema gelap (dark mode)
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Column hanya sebesar ukuran child-nya (tidak melebar penuh)
            children: [
              Text('ARIF BANYAK BERDOA'), // Teks statis (tidak berubah)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    counter--; // Mengurangi counter sebesar 1; setState memicu rebuild UI
                  });
                },
                child: const Text('- 1 dosa'), // Label tombol pengurangan
              ),
              Text('ARIF BANYAK DOSA'), // Teks statis (tidak berubah)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    counter++; // Menambah counter sebesar 1; setState memicu rebuild UI
                  });
                },
                child: const Text('+ 1 dosa'), // Label tombol penambahan
              ),
              Text('Total dosa: $counter'), // Menampilkan nilai counter secara dinamis dengan string interpolation
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

File ini merupakan contoh implementasi **StatelessWidget** yang menunjukkan keterbatasannya: widget tidak dapat memperbarui UI karena tidak memiliki state internal.

```dart
import 'package:flutter/material.dart'; // Mengimpor library Material Design

class MyWidget extends StatelessWidget {
  const MyWidget({super.key}); // Konstruktor const; widget ini tidak menerima parameter tambahan

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',        // Judul aplikasi di task switcher OS
      home: Scaffold(
        body: Column(               // Menyusun widget secara vertikal
          children: [
            Center(
              child: Text('Arif banyak dosa'), // Teks yang ditampilkan di tengah secara horizontal
            ),
            ElevatedButton(
              onPressed: () {
                int counter = 0; // Variabel lokal (bukan state) – nilainya tidak tersimpan antar rebuild
                counter++;       // Operasi ini tidak berdampak ke UI karena widget tidak memiliki state
              },
              child: Text('+ 1 dosa'), // Label tombol
            ),
          ],
        ),
      ),
      theme: ThemeData.dark() // Menggunakan tema gelap (dark mode) untuk seluruh aplikasi
    );
  }
}
```

> **Catatan Penting:** Di `stateless.dart`, tombol "+ 1 dosa" tidak akan memperbarui tampilan apapun meskipun diklik. Hal ini karena `StatelessWidget` tidak memiliki mekanisme `setState()` untuk memberitahu Flutter agar merender ulang widget. Ini adalah demonstrasi nyata mengapa `StatefulWidget` diperlukan untuk UI yang reaktif.

---

## 🧩 Konsep Utama yang Dipelajari

| Konsep | Penjelasan |
|---|---|
| `StatelessWidget` | Widget yang tampilannya tetap/statis, tidak berubah setelah dibuat. Cocok untuk konten yang tidak bergantung pada data yang berubah. |
| `StatefulWidget` | Widget yang dapat memperbarui tampilannya secara dinamis menggunakan `setState()`. Cocok untuk konten interaktif. |
| `setState()` | Metode pada `State` yang memberi tahu Flutter bahwa data berubah, sehingga `build()` dipanggil ulang untuk merender UI terbaru. |
| `Scaffold` | Kerangka halaman Material Design yang menyediakan slot untuk AppBar, body, FAB, Drawer, dan BottomNavigationBar. |
| `Drawer` | Panel navigasi samping yang muncul dari tepi layar saat pengguna menggeser atau menekan ikon menu. |
| `BottomNavigationBar` | Bar navigasi di bagian bawah layar berisi item-item navigasi utama aplikasi. |
| `FloatingActionButton` | Tombol aksi melayang (FAB) yang biasanya digunakan untuk aksi utama suatu halaman. |

---

## 🚀 Cara Menjalankan

```bash
# Pastikan Flutter SDK sudah terinstal
flutter pub get      # Mengunduh semua dependensi
flutter run          # Menjalankan aplikasi di emulator/perangkat
```

---

## 📦 Dependensi

| Package | Versi | Keterangan |
|---|---|---|
| `flutter` | SDK | Framework utama |
| `cupertino_icons` | ^1.0.8 | Ikon gaya iOS |
| `flutter_lints` | ^6.0.0 | Aturan lint untuk kode yang bersih |

**Dart SDK:** `^3.13.5`
