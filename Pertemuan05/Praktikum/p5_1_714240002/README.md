# Pertemuan 05 – Praktikum 1: Aplikasi Wisata Bandung (Navigator & Route)

**Mata Kuliah:** Pemrograman Mobile
**NIM:** 714240002
**Pertemuan:** 05
**Jenis:** Praktikum – Project (`p5_1_714240002`)

---

## 📋 Deskripsi Project

Project Flutter ini merupakan hasil **Praktikum 1 Pertemuan 05**. Materi utama pertemuan ini adalah **Navigator dan Route** – yaitu sistem navigasi antar halaman dalam Flutter. Project ini melanjutkan aplikasi daftar wisata Bandung dari Pertemuan 04, dengan struktur kode yang identik karena fokus pembelajaran adalah memahami mekanisme navigasi `Navigator.push` / `Navigator.pop` dan `MaterialPageRoute` yang sudah diimplementasikan sebelumnya.

Aplikasi menampilkan 9 destinasi wisata Bandung dalam bentuk daftar kartu, dan tiap kartu dapat diklik untuk membuka halaman detail penuh.

---

## ✨ Fitur Utama

- **Daftar Wisata**: 9 tempat wisata Bandung dalam `ListView.builder` yang dapat di-scroll.
- **Navigasi Push/Pop**: Mengetuk kartu → `Navigator.push` ke `DetailScreen`; tombol back → `Navigator.pop`.
- **Halaman Detail**: Foto hero, nama, info hari/jam/tiket, deskripsi panjang, galeri foto horizontal.
- **Custom Font**: Font **Staatliches** untuk heading dan label info.
- **Gambar Lokal & Network**: Aset lokal untuk gambar utama; URL CDN untuk galeri.
- **Graceful Fallback**: Widget placeholder jika gambar gagal dimuat.

---

## 🗂️ Struktur File

```
p5_1_714240002/
├── lib/
│   ├── main.dart              # Entry point & konfigurasi MaterialApp
│   ├── main_screen.dart       # Halaman daftar wisata (ListView)
│   ├── detail_screen.dart     # Halaman detail tempat wisata
│   └── model/
│       └── tourism_place.dart # Model data & daftar statis 9 wisata
├── images/                    # Aset gambar lokal (9 foto destinasi)
├── fonts/
│   └── Staatliches/
│       └── Staatliches-Regular.ttf
└── pubspec.yaml
```

---

## 🔄 Alur Navigasi (Fokus Pembelajaran)

```
main() → runApp(MyApp)
    └─ MaterialApp (navigation stack root)
            └─ MainScreen                        ← Halaman 1 (stack: [MainScreen])
                    └─ onTap kartu wisata
                            └─ Navigator.push(MaterialPageRoute)
                                    └─ DetailScreen(place)      ← Halaman 2 (stack: [MainScreen, DetailScreen])
                                            └─ Navigator.pop(context)
                                                    └─ kembali ke MainScreen ← (stack: [MainScreen])
```

**Konsep Navigator yang diimplementasikan:**

| Operasi | Kode | Efek |
|---------|------|------|
| Buka halaman baru | `Navigator.push(context, MaterialPageRoute(...))` | Halaman baru ditambah ke stack |
| Kembali ke sebelumnya | `Navigator.pop(context)` | Halaman teratas dihapus dari stack |
| Membawa data ke halaman | `DetailScreen(place: place)` | Data diteruskan via constructor |

---

## 📄 Dokumentasi Per File

### `lib/main.dart`

Entry point aplikasi. Root widget `MyApp` mengkonfigurasi `MaterialApp`.

| Baris kunci | Keterangan |
|-------------|-----------|
| `runApp(const MyApp())` | Memulai aplikasi Flutter |
| `MaterialApp(title: 'Wisata Bandung')` | Konfigurasi app: nama, tema, halaman awal |
| `useMaterial3: false` | Material Design 2 |
| `home: const MainScreen()` | Halaman pertama dan dasar navigation stack |

> `MaterialApp` secara otomatis menyediakan `Navigator` sebagai ancestor sehingga semua widget di bawahnya dapat memanggil `Navigator.of(context)` atau `Navigator.push/pop`.

---

### `lib/model/tourism_place.dart`

Model data dan daftar statis 9 tempat wisata Bandung.

**Properti `TourismPlace`:**

| Properti | Tipe | Keterangan |
|----------|------|-----------|
| `name` | `String` | Nama tempat wisata |
| `location` | `String` | Kecamatan / kota |
| `description` | `String` | Deskripsi wisata |
| `openDays` | `String` | Hari operasional |
| `openTime` | `String` | Jam operasional |
| `ticketPrice` | `String` | Harga tiket |
| `imageAsset` | `String` | Path gambar lokal |
| `imageUrls` | `List<String>` | 3 URL foto galeri |

**Daftar 9 destinasi:**

| No | Nama | Lokasi | Tiket |
|----|------|--------|-------|
| 1 | Observatorium Bosscha | Lembang | Rp 20.000 |
| 2 | Farm House Lembang | Lembang | Rp 25.000 |
| 3 | Floating Market | Lembang | Rp 20.000 |
| 4 | Jalan Asia Afrika | Kota Bandung | Gratis |
| 5 | Kawah Putih | Ciwidey | Rp 15.000 |
| 6 | Museum Geologi | Kota Bandung | Rp 3.000 |
| 7 | Ranca Upas | Ciwidey | Rp 20.000 |
| 8 | Stone Garden | Padalarang | Rp 3.000 |
| 9 | Taman Film Pasopati | Kota Bandung | Gratis |

---

### `lib/main_screen.dart`

Halaman pertama. Menampilkan daftar wisata dan men-trigger navigasi.

**Pola layout satu kartu:**
```
InkWell (ripple)
└─ Card (clip antiAlias)
    └─ Row
        ├─ Expanded(flex:1) → AspectRatio(16/9) → Image.asset  ← thumbnail (1/3 lebar)
        └─ Expanded(flex:2) → Column                            ← info (2/3 lebar)
                ├─ Text(name, bold, 16px)
                └─ Row → Icon(location_on) + Text(location)
```

**Navigasi (inti pembelajaran Pertemuan 05):**
```dart
onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (context) => DetailScreen(place: place), // bawa data via constructor
    ),
  );
},
```

| Bagian | Keterangan |
|--------|-----------|
| `Navigator.push` | Menambah rute baru ke atas navigation stack |
| `MaterialPageRoute` | Rute dengan transisi slide khas Material Design |
| `DetailScreen(place: place)` | Mengirimkan objek `TourismPlace` ke halaman detail |

---

### `lib/detail_screen.dart`

Halaman kedua. Menerima data dari `MainScreen` dan menampilkan info lengkap satu wisata.

```dart
class DetailScreen extends StatelessWidget {
  final TourismPlace place; // data diterima dari MainScreen via constructor
  const DetailScreen({super.key, required this.place});
}
```

**Layout dari atas ke bawah (dalam `SingleChildScrollView`):**

| # | Bagian | Widget | Detail |
|---|--------|--------|--------|
| 1 | **Foto Hero** | `Stack` → `Image.asset(16/9)` | Gambar utama lokal, lebar penuh |
| 2 | **Tombol Kembali** | `SafeArea` → `CircleAvatar` → `IconButton` | Overlay kiri atas; `Navigator.pop(context)` |
| 3 | **Nama Wisata** | `Text` | Staatliches, 30px, center |
| 4 | **Info Row** | `Row` → 3× `_InfoItem` | Hari buka · Jam · Tiket |
| 5 | **Deskripsi** | `Text(justify)` | 16px, line-height 1.5 |
| 6 | **Galeri** | `ListView.builder(horizontal)` | 3 foto network, h:150, rasio 4:3 |

**Navigasi kembali (inti pembelajaran):**
```dart
// Di tombol kembali (CircleAvatar)
onPressed: () => Navigator.pop(context),
// Efek: menghapus DetailScreen dari stack → kembali ke MainScreen
```

**Widget privat `_InfoItem`** (ikon + label, font Staatliches):
```
Column
├─ Icon(icon)
├─ SizedBox(h:8)
└─ Text(label, center, Staatliches)
```

---

## 📦 Dependensi & Aset

| Item | Nilai |
|------|-------|
| Package | `p5_1_714240002` |
| Dart SDK | `^3.13.5` |
| Dependencies | `flutter`, `cupertino_icons: ^1.0.8` |
| Dev deps | `flutter_test`, `flutter_lints: ^6.0.0` |
| Aset gambar | `images/` (9 foto wisata lokal) |
| Custom font | `Staatliches-Regular.ttf` |

---

## 🚀 Cara Menjalankan

```bash
cd Pertemuan05/Praktikum/p5_1_714240002
flutter pub get
flutter run
```

---

## 🧪 Testing

```bash
flutter test
```

---

## 📚 Konsep Flutter yang Dipelajari (Pertemuan 05)

| Konsep | Implementasi |
|--------|-------------|
| **Navigator.push** | Membuka `DetailScreen` dari `MainScreen` |
| **Navigator.pop** | Kembali ke `MainScreen` dari `DetailScreen` |
| **MaterialPageRoute** | Rute dengan transisi slide Material |
| **Passing data antar halaman** | `DetailScreen(place: place)` – data via constructor |
| **Navigation Stack** | `MaterialApp` menyediakan stack; push = tambah, pop = hapus |
| `SafeArea` | Mencegah konten tertutup status bar saat overlay tombol |
| `Stack` | Melapisi tombol kembali di atas gambar hero |
| `ListView.builder` | Daftar item lazy-render |
| `Image.asset` / `Image.network` | Gambar dari aset lokal dan URL |
