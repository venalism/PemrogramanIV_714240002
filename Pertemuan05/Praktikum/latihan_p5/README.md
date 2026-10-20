# Latihan Pertemuan 5 — Flutter Navigation & Custom Font

> **Nama:** *(Nama Mahasiswa)*
> **NIM:** 714240002
> **Mata Kuliah:** Pemrograman Mobile IV
> **Pertemuan:** 5

---

## 📋 Deskripsi Project

Project ini merupakan aplikasi Flutter sederhana yang dibuat sebagai latihan pada Pertemuan 5. Aplikasi ini mendemonstrasikan dua konsep utama dalam pengembangan Flutter:

1. **Custom Font** — Penggunaan font lokal (*Oswald*) yang didaftarkan melalui `pubspec.yaml` dan diterapkan secara global ke seluruh teks dalam aplikasi.
2. **Navigasi Antar Screen** — Pengiriman data (pesan/`String`) dari `FirstScreen` ke `SecondScreen` menggunakan `Navigator.push()` dan `MaterialPageRoute`, serta kembali ke layar sebelumnya dengan `Navigator.pop()`.

---

## 🗂️ Struktur Project

```
latihan_p5/
├── lib/
│   └── main.dart          # Entry point & seluruh widget utama
├── fonts/
│   └── Oswald/
│       ├── Oswald-Light.ttf
│       ├── Oswald-Regular.ttf
│       ├── Oswald-Medium.ttf
│       ├── Oswald-SemiBold.ttf
│       └── Oswald-Bold.ttf
├── images/
│   └── ulbi.jpg           # Aset gambar (terdaftar di pubspec)
└── pubspec.yaml           # Konfigurasi project, dependensi, aset, dan font
```

---

## 🔄 Alur Aplikasi

```
[main()]
    └─► runApp(MyApp)
            └─► MaterialApp (tema global Oswald)
                    └─► FirstScreen (layar awal)
                            │  Tekan tombol "Pindah Screen"
                            │  Navigator.push() + kirim pesan
                            ▼
                        SecondScreen (menerima pesan, tampilkan teks)
                                │  Tekan tombol "Kembali"
                                │  Navigator.pop()
                                ▼
                        FirstScreen (kembali ke layar awal)
```

---

## 📄 Dokumentasi Kode — `lib/main.dart`

### 1. Import & Entry Point (Baris 1–5)

```dart
import 'package:flutter/material.dart';   // [1] Mengimpor library Material Design Flutter
                                           //     Menyediakan semua widget dasar (Text, Scaffold, dll.)

void main() {                              // [3] Fungsi utama — titik masuk aplikasi Dart
  runApp(const MyApp());                   // [4] Menjalankan aplikasi Flutter dengan widget root MyApp
}                                          //     `const` → MyApp dikompilasi sebagai konstanta (optimasi)
```

---

### 2. Kelas `MyApp` — Root Widget (Baris 7–21)

```dart
class MyApp extends StatelessWidget {       // [7]  Widget tanpa state (tampilan tidak berubah)
  const MyApp({super.key});                 // [8]  Constructor dengan key diteruskan ke superclass

  @override
  Widget build(BuildContext context) {      // [10] Method build dipanggil saat widget dirender
    return MaterialApp(                     // [11] Widget root yang mengatur navigasi & tema global
      title: 'Flutter Demo',               // [12] Judul aplikasi (muncul di app switcher OS)
      theme: ThemeData(                     // [13] Mendefinisikan tema visual global aplikasi
        primarySwatch: Colors.blue,         // [14] Warna utama (AppBar, tombol, dll.) = biru
        useMaterial3: false,               // [15] Menggunakan Material Design 2 (bukan Material 3)
        fontFamily: 'Oswald',              // [16] Menetapkan font Oswald sebagai font default
      ),                                   //      global untuk SEMUA Text widget di aplikasi
      home: const FirstScreen(),           // [18] Layar pertama yang ditampilkan saat app dibuka
    );
  }
}
```

> **Catatan `fontFamily: 'Oswald'`:** Dengan mendaftarkan font di level `ThemeData`, semua widget `Text` dalam aplikasi secara otomatis menggunakan Oswald tanpa perlu menuliskan `TextStyle(fontFamily: 'Oswald')` satu per satu.

---

### 3. Kelas `FirstScreen` — Layar Pertama (Baris 23–45)

```dart
class FirstScreen extends StatelessWidget {   // [23] Widget layar pertama tanpa state
  const FirstScreen({super.key});             // [24] Constructor dengan key

  final String message = 'Hello from First Screen!'; // [26] Data yang akan dikirim ke SecondScreen
                                                       //      Dideklarasikan sebagai field `final`

  @override
  Widget build(BuildContext context) {          // [29] Method build — mendeskripsikan tampilan UI
    return Scaffold(                            // [30] Kerangka halaman standar Material Design
      appBar: AppBar(                           // [31] Bilah atas layar
        title: const Text('First Screen')      //      Judul AppBar = "First Screen"
      ),
      body: Center(                             // [32] Memusatkan child secara horizontal & vertikal
        child: ElevatedButton(                  // [33] Tombol dengan efek elevasi (bayangan)
          child: const Text('Pindah Screen'),   // [34] Label tombol
          onPressed: () {                       // [35] Callback dipanggil saat tombol ditekan
            Navigator.push(                     // [36] Mendorong layar baru ke atas navigation stack
              context,                          // [37] BuildContext diperlukan untuk akses Navigator
              MaterialPageRoute(                // [38] Route dengan transisi slide standar Material
                builder: (context) =>
                  SecondScreen(message),        //      Membuat SecondScreen dan mengirim `message`
              ),
            );
          },
        ),
      ),
    );
  }
}
```

> **Catatan `Navigator.push()`:** Navigator bekerja seperti *stack* (tumpukan). `push()` menambahkan layar baru di atas layar saat ini. Layar lama tidak dihancurkan, hanya tertutup di bawah.

---

### 4. Kelas `SecondScreen` — Layar Kedua (Baris 47–71)

```dart
class SecondScreen extends StatelessWidget {  // [47] Widget layar kedua tanpa state
  final String message;                        // [48] Field untuk menerima data dari FirstScreen
  const SecondScreen(this.message, {super.key}); // [49] Constructor positional: `message` wajib diisi
                                                   //      `{super.key}` → named optional parameter

  @override
  Widget build(BuildContext context) {          // [52] Method build
    return Scaffold(                            // [53] Kerangka halaman standar
      appBar: AppBar(                           // [54] AppBar dengan judul "Second Screen"
        title: const Text('Second Screen')
      ),
      body: Center(                             // [55] Pusatkan konten
        child: Column(                          // [56] Susun widget secara vertikal
          mainAxisAlignment: MainAxisAlignment.center, // [57] Tengahkan secara vertikal
          children: [
            Text(message),                      // [59] Menampilkan pesan yang diterima dari FirstScreen
                                                //      Menggunakan font Oswald (dari tema global)
            OutlinedButton(                     // [60] Tombol dengan gaya outline (tidak ada fill)
              child: const Text('Kembali'),     // [61] Label tombol
              onPressed: () {                   // [62] Callback saat tombol ditekan
                Navigator.pop(context);         // [63] Mengeluarkan SecondScreen dari navigation stack
              },                               //      Kembali ke layar sebelumnya (FirstScreen)
            ),
          ],
        ),
      ),
    );
  }
}
```

> **Catatan `Navigator.pop()`:** Kebalikan dari `push()`. `pop()` mengeluarkan layar terkini dari stack sehingga layar sebelumnya (FirstScreen) kembali terlihat. Selain tombol "Kembali", tombol back bawaan Android/iOS juga memanggil `pop()` secara otomatis.

---

## ⚙️ Konfigurasi `pubspec.yaml` — Aset & Font

### Registrasi Aset Gambar
```yaml
flutter:
  assets:
    - images/    # Mendaftarkan SELURUH isi folder images/ sebagai aset
                 # Gambar dapat diakses dengan: Image.asset('images/ulbi.jpg')
```

### Registrasi Font Lokal
```yaml
  fonts:
    - family: Oswald          # Nama font yang digunakan di kode (fontFamily: 'Oswald')
      fonts:
        - asset: fonts/Oswald/Oswald-Regular.ttf    # Weight normal (400)
        - asset: fonts/Oswald/Oswald-Light.ttf      # Weight tipis (300)
        - asset: fonts/Oswald/Oswald-Medium.ttf     # Weight sedang (500)
        - asset: fonts/Oswald/Oswald-SemiBold.ttf   # Weight semi-tebal (600)
        - asset: fonts/Oswald/Oswald-Bold.ttf       # Weight tebal (700)
```

> **Penting:** File `.ttf` harus benar-benar ada di folder `fonts/Oswald/`. Jika tidak, build akan gagal dengan error `unable to locate asset entry`.

---

## 🧩 Konsep Flutter yang Dipelajari

| Konsep | Widget/Method | Penjelasan |
|---|---|---|
| **Root Widget** | `MaterialApp` | Mengatur tema, navigasi, dan layar awal aplikasi |
| **Tema Global** | `ThemeData` | Mengatur tampilan visual secara konsisten di seluruh app |
| **Custom Font** | `fontFamily` di `ThemeData` | Font Oswald diterapkan ke semua Text secara otomatis |
| **Navigasi Push** | `Navigator.push()` | Membuka layar baru dan menambahnya ke navigation stack |
| **Navigasi Pop** | `Navigator.pop()` | Menutup layar saat ini dan kembali ke layar sebelumnya |
| **Kirim Data** | Constructor parameter | Data dikirim ke layar baru melalui parameter konstruktor |
| **Route** | `MaterialPageRoute` | Mendefinisikan transisi dan widget untuk layar baru |
| **Layout** | `Scaffold`, `Center`, `Column` | Menyusun struktur dan tata letak halaman |
| **Tombol** | `ElevatedButton`, `OutlinedButton` | Dua varian tombol Material Design |

---

## ▶️ Cara Menjalankan

```bash
# Install dependensi
flutter pub get

# Jalankan di emulator/device
flutter run

# Jalankan di browser (web)
flutter run -d chrome
```

---

## 📦 Dependensi

| Package | Versi | Keterangan |
|---|---|---|
| `flutter` | SDK | Framework utama |
| `cupertino_icons` | ^1.0.8 | Ikon gaya iOS |
| `flutter_lints` | ^6.0.0 | Aturan linting kode Dart |
