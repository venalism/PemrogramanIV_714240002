# Pertemuan 04 – Tugas: Demonstrasi Layout Container dengan BoxDecoration

**Mata Kuliah:** Pemrograman Mobile  
**NIM:** 714240002  
**Pertemuan:** 04  
**Jenis:** Tugas (`p4_2_714240002`)  

---

## 📋 Deskripsi Project

Project Flutter ini merupakan hasil **tugas Pertemuan 04** yang mendemonstrasikan kemampuan pembuatan layout dengan widget `Container` dan dekorasi `BoxDecoration` secara mendalam. Project ini membangun tiga buah "kotak" (Box) dengan gaya visual yang berbeda-beda, disusun menggunakan `Column` dan `Row`, untuk memperlihatkan berbagai kemungkinan kustomisasi tampilan widget di Flutter.

---

## 🗂️ Struktur File

```
lib/
└── main.dart  # Satu-satunya file kode; berisi semua widget aplikasi
```

---

## 🖼️ Tampilan Aplikasi

Aplikasi menampilkan tiga kotak (Box) dengan karakteristik berbeda:

| Box | Warna | Arah | Gaya Border | Posisi Teks |
|---|---|---|---|---|
| **Box 1** | Biru | Horizontal (lebar) | Sudut membulat merata + shadow | Tengah |
| **Box 2** | Merah (outline) | Vertikal | Hanya border/garis tepi | Pojok kiri atas |
| **Box 3** | Hijau (solid) | Vertikal | Sudut asimetris (kiri atas & kanan bawah) | Pojok kanan bawah |

---

## 📄 Dokumentasi Kode

### `main.dart`

File tunggal yang berisi seluruh logika dan tampilan aplikasi.

---

#### Entry Point & Root Widget

```dart
import 'package:flutter/material.dart'; // Mengimpor library Material Design Flutter

void main() {
  runApp(const MyApp()); // Titik masuk program; menjalankan MyApp sebagai widget paling atas
}
```

---

#### Kelas `MyApp` (StatelessWidget – Root Aplikasi)

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Konstruktor const; super.key diteruskan ke parent untuk optimasi

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Pertemuan 4', // Judul aplikasi yang muncul di task switcher OS
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), // Skema warna dari seed color ungu
      ),
      home: const LayoutPage(), // Halaman utama yang akan ditampilkan pertama kali
    );
  }
}
```

---

#### Kelas `LayoutPage` (StatelessWidget – Halaman Utama)

Widget ini merupakan inti aplikasi yang membangun seluruh tampilan dengan tiga buah Container berdekorasi.

```dart
class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key}); // Konstruktor const

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang halaman berwarna putih bersih
      appBar: AppBar(
        backgroundColor: Colors.deepOrange, // Warna AppBar oranye gelap
        title: const Text(
          'Tugas Pertemuan 4',
          style: TextStyle(
            color: Colors.white,          // Warna teks judul AppBar: putih
            fontWeight: FontWeight.bold,  // Ketebalan teks: tebal
          ),
        ),
        centerTitle: true, // Judul AppBar diposisikan di tengah (bukan rata kiri)
      ),
```

---

#### Body: Column Utama

```dart
      body: Center(                    // Memusatkan seluruh konten body di tengah layar
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,    // Memusatkan children secara vertikal
          crossAxisAlignment: CrossAxisAlignment.center,  // Memusatkan children secara horizontal
          children: [
```

---

#### Box 1 – Container Biru dengan Shadow dan Sudut Membulat Merata

```dart
            // ── BOX 1 (Biru): horizontal, rounded corner merata, shadow, teks di tengah ──
            Container(
              width: 280,   // Lebar kotak 280 pixel (horizontal/landscape)
              height: 80,   // Tinggi kotak 80 pixel
              decoration: BoxDecoration(
                color: Colors.blue,                 // Warna latar kotak: biru
                borderRadius: BorderRadius.circular(16), // Sudut membulat dengan radius 16 pixel di semua sudut
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25), // Warna bayangan hitam dengan opacity 25%
                    blurRadius: 8,                               // Radius blur bayangan (semakin besar, semakin difus)
                    offset: const Offset(0, 4),                  // Posisi bayangan: 0 pixel ke kanan, 4 pixel ke bawah
                  ),
                ],
              ),
              child: const Center(          // Memusatkan konten di dalam Container
                child: Text(
                  'Box 1',
                  style: TextStyle(
                    color: Colors.white,          // Warna teks: putih (kontras dengan latar biru)
                    fontSize: 18,                 // Ukuran font 18 pixel
                    fontWeight: FontWeight.bold,  // Ketebalan font: tebal
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20), // Spasi vertikal 20 pixel antara Box 1 dan baris Box 2 & 3
```

---

#### Baris Box 2 & Box 3 (Row Horizontal)

```dart
            // ── Baris Box 2 & Box 3 berjajar horizontal ──
            Row(
              mainAxisAlignment: MainAxisAlignment.center,     // Baris Box 2 & 3 diposisikan di tengah horizontal
              crossAxisAlignment: CrossAxisAlignment.start,    // Kedua box rata atas (top-aligned)
              children: [
```

---

#### Box 2 – Container Merah dengan Hanya Border (Outline)

```dart
                // ── BOX 2 (Merah): vertikal, hanya outline border, teks di pojok kiri atas ──
                Container(
                  width: 120,   // Lebar kotak 120 pixel
                  height: 160,  // Tinggi kotak 160 pixel (vertikal/portrait)
                  decoration: BoxDecoration(
                    color: Colors.transparent, // Latar transparan: tidak ada warna isian
                    border: Border.all(
                      color: Colors.red, // Warna garis border: merah
                      width: 4,          // Ketebalan garis border 4 pixel
                    ),
                    borderRadius: BorderRadius.circular(8), // Sudut membulat ringan dengan radius 8 pixel
                  ),
                  padding: const EdgeInsets.all(10), // Jarak dalam 10 pixel di semua sisi agar teks tidak menempel ke border
                  child: const Align(
                    alignment: Alignment.topLeft, // Teks diposisikan di pojok kiri atas Container
                    child: Text(
                      'Box 2',
                      style: TextStyle(
                        color: Colors.red,            // Warna teks merah (senada dengan border)
                        fontSize: 16,                 // Ukuran font 16 pixel
                        fontWeight: FontWeight.bold,  // Ketebalan font: tebal
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 20), // Spasi horizontal 20 pixel antara Box 2 dan Box 3
```

---

#### Box 3 – Container Hijau dengan Sudut Asimetris

```dart
                // ── BOX 3 (Hijau): vertikal, hijau penuh, sudut asimetris (kiri atas & kanan bawah tumpul), teks di pojok kanan bawah ──
                Container(
                  width: 120,   // Lebar kotak 120 pixel (sama dengan Box 2)
                  height: 160,  // Tinggi kotak 160 pixel (sama dengan Box 2)
                  decoration: const BoxDecoration(
                    color: Colors.green, // Warna latar kotak: hijau penuh (solid)
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),     // Sudut kiri atas membulat dengan radius 24 pixel
                      topRight: Radius.zero,             // Sudut kanan atas lancip (tidak membulat)
                      bottomLeft: Radius.zero,           // Sudut kiri bawah lancip (tidak membulat)
                      bottomRight: Radius.circular(24), // Sudut kanan bawah membulat dengan radius 24 pixel
                      // Efek: sudut membulat hanya diagonal (kiri atas ↔ kanan bawah) → bentuk asimetris
                    ),
                  ),
                  padding: const EdgeInsets.all(10), // Jarak dalam 10 pixel di semua sisi
                  child: const Align(
                    alignment: Alignment.bottomRight, // Teks diposisikan di pojok kanan bawah Container
                    child: Text(
                      'Box 3',
                      style: TextStyle(
                        color: Colors.white,           // Warna teks putih (kontras dengan latar hijau)
                        fontSize: 16,                  // Ukuran font 16 pixel
                        fontWeight: FontWeight.bold,   // Ketebalan font: tebal
                      ),
                    ),
                  ),
                ),
              ],
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

### `BoxDecoration` – Properti Dekorasi Container

| Properti | Penjelasan |
|---|---|
| `color` | Warna latar belakang Container. |
| `borderRadius` | Mengatur sudut Container agar membulat. |
| `BorderRadius.circular(r)` | Semua sudut membulat dengan radius yang sama. |
| `BorderRadius.only(...)` | Setiap sudut dapat diatur secara individual dengan radius berbeda. |
| `Radius.zero` | Sudut lancip (tidak membulat sama sekali). |
| `border` | Mengatur garis tepi (border) Container. |
| `Border.all(color, width)` | Membuat border di semua sisi dengan warna dan ketebalan yang ditentukan. |
| `boxShadow` | Daftar bayangan yang diaplikasikan di belakang Container. |
| `BoxShadow(color, blurRadius, offset)` | Mendefinisikan satu efek bayangan dengan warna, radius blur, dan posisi offset. |

### Widget Layout

| Widget | Penjelasan |
|---|---|
| `Container` | Widget serbaguna dengan kemampuan kustomisasi ukuran, warna, padding, margin, dan dekorasi. |
| `Align` | Memposisikan child di dalam parent sesuai `alignment` yang ditentukan. |
| `Alignment.topLeft` | Pojok kiri atas. |
| `Alignment.bottomRight` | Pojok kanan bawah. |
| `Offset(x, y)` | Mendefinisikan pergeseran 2D; `x` positif ke kanan, `y` positif ke bawah. |
| `Colors.black.withValues(alpha: 0.25)` | Membuat warna hitam dengan transparansi (opacity 25%). |

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
