# Pertemuan 04 – Praktikum 1: Aplikasi Wisata Bandung

**Mata Kuliah:** Pemrograman Mobile
**NIM:** 714240002
**Pertemuan:** 04
**Jenis:** Praktikum – Project (`p4_1_714240002`)

---

## 📋 Deskripsi Project

Project Flutter ini merupakan hasil **Praktikum 1 Pertemuan 04** yang membangun aplikasi daftar tempat wisata di Bandung. Aplikasi menampilkan 9 destinasi wisata dalam bentuk kartu scrollable, dan setiap item dapat diklik untuk membuka halaman detail yang memuat informasi lengkap: hari buka, jam operasional, harga tiket, deskripsi, serta galeri foto horizontal dari internet.

---

## ✨ Fitur Utama

- **Daftar Wisata**: 9 tempat wisata ditampilkan sebagai kartu scrollable vertikal dengan `ListView.builder`.
- **Navigasi ke Detail**: Mengetuk kartu membuka `DetailScreen` via `Navigator.push` + `MaterialPageRoute`.
- **Halaman Detail**: Foto hero 16:9, nama (font Staatliches), 3 info chip (hari/jam/tiket), deskripsi, galeri horizontal.
- **Custom Font**: Font **Staatliches** untuk judul dan label info di halaman detail.
- **Gambar Lokal & Network**: Gambar utama dari aset lokal (`images/`), galeri dari URL TripAdvisor CDN.
- **Graceful Fallback**: Jika gambar gagal dimuat, tampil ikon `broken_image` sebagai pengganti.
- **Tombol Kembali Custom**: `CircleAvatar` + `IconButton` di-overlay di atas foto hero.

---

## 🗂️ Struktur File

```
p4_1_714240002/
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

## 🔄 Alur Aplikasi

```
main() → runApp(MyApp)
    └─ MaterialApp → MainScreen
            └─ ListView.builder [9 kartu wisata]
                    └─ onTap → Navigator.push → DetailScreen(place)
                                    ├─ Foto hero + tombol back
                                    ├─ Nama (Staatliches font)
                                    ├─ Row: hari buka | jam | tiket
                                    ├─ Deskripsi
                                    └─ Galeri foto horizontal (network)
                                    └─ Navigator.pop ← tombol back
```

---

## 📄 Dokumentasi Per File

### `lib/main.dart`

Entry point aplikasi. Mendefinisikan `MyApp` sebagai root widget.

| Baris kunci | Keterangan |
|-------------|-----------|
| `runApp(const MyApp())` | Titik masuk; menyuntikkan widget root ke Flutter engine |
| `MaterialApp(title: 'Wisata Bandung')` | Menyediakan navigasi, tema, dan judul aplikasi |
| `useMaterial3: false` | Menggunakan desain Material 2 |
| `home: const MainScreen()` | Halaman pertama yang ditampilkan saat app dibuka |

---

### `lib/model/tourism_place.dart`

Mendefinisikan class `TourismPlace` dan daftar statis `tourismPlaceList`.

**Properti model `TourismPlace`:**

| Properti | Tipe | Keterangan |
|----------|------|-----------|
| `name` | `String` | Nama tempat wisata |
| `location` | `String` | Lokasi / kecamatan |
| `description` | `String` | Deskripsi panjang |
| `openDays` | `String` | Hari operasional |
| `openTime` | `String` | Jam operasional |
| `ticketPrice` | `String` | Harga tiket masuk |
| `imageAsset` | `String` | Path gambar lokal (e.g. `images/bosscha.jpg`) |
| `imageUrls` | `List<String>` | 3 URL foto tambahan untuk galeri |

**9 destinasi dalam `tourismPlaceList`:**

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

Halaman utama berisi daftar wisata.

**Pola layout satu kartu:**
```
InkWell (ripple effect)
└─ Card (clipBehavior: antiAlias)
    └─ Row
        ├─ Expanded(flex:1) → AspectRatio(16/9) → Image.asset   ← gambar (1/3 lebar)
        └─ Expanded(flex:2) → Padding → Column                   ← teks (2/3 lebar)
                                ├─ Text(place.name)  bold
                                └─ Row → Icon(location) + Text(place.location)
```

| Widget / Pola | Keterangan |
|--------------|-----------|
| `ListView.builder` | Membangun item secara lazy – hanya item yang terlihat yang dirender |
| `InkWell` | Memberikan efek ripple saat kartu ditekan |
| `Card(clipBehavior: Clip.antiAlias)` | Konten kartu terpotong rapi mengikuti sudut membulat |
| `Expanded(flex: 1)` vs `Expanded(flex: 2)` | Gambar mendapat 1/3 lebar, teks mendapat 2/3 |
| `AspectRatio(16/9)` | Mempertahankan proporsi gambar meski ukuran layar berbeda |
| `Navigator.push(MaterialPageRoute)` | Mendorong `DetailScreen` ke navigation stack dengan transisi slide |

---

### `lib/detail_screen.dart`

Halaman detail menerima satu `TourismPlace` via constructor. Seluruh konten dapat di-scroll secara vertikal menggunakan `SingleChildScrollView`.

**Layout dari atas ke bawah:**

| # | Bagian | Widget Utama | Detail |
|---|--------|-------------|--------|
| 1 | **Foto Hero** | `Stack` → `AspectRatio(16/9)` → `Image.asset` | Gambar penuh-lebar dari aset lokal |
| 2 | **Tombol Kembali** | `SafeArea` → `CircleAvatar` → `IconButton(Icons.arrow_back)` | Di-overlay di kiri atas foto; `Navigator.pop` saat ditekan |
| 3 | **Nama Wisata** | `Container` → `Text` | Font Staatliches ukuran 30, rata tengah |
| 4 | **Baris Info** | `Row` → 3× `Expanded(_InfoItem)` | Hari buka, jam operasional, harga tiket |
| 5 | **Deskripsi** | `Padding` → `Text(textAlign: justify)` | Font default, ukuran 16, line-height 1.5 |
| 6 | **Galeri Foto** | `SizedBox(h:150)` → `ListView.builder(horizontal)` | 3 foto URL, rasio 4:3, sudut 10px |

**Widget privat `_InfoItem`:**

Setiap kolom info (hari/jam/tiket) menggunakan widget `_InfoItem` yang menumpuk ikon di atas teks label:
```
Column
├─ Icon(icon)          ← ikon kalender / jam / uang
├─ SizedBox(height:8)
└─ Text(label)         ← teks info, font Staatliches, rata tengah
```

---

## 📦 Dependensi & Aset

| Item | Nilai |
|------|-------|
| Package | `p4_1_714240002` |
| Dart SDK | `^3.13.5` |
| Dependensi runtime | `flutter`, `cupertino_icons: ^1.0.8` |
| Dev dependensi | `flutter_test`, `flutter_lints: ^6.0.0` |
| Aset gambar | Folder `images/` (9 foto wisata lokal) |
| Custom font | `Staatliches-Regular.ttf` (family: `Staatliches`) |

---

## 🚀 Cara Menjalankan

```bash
cd Pertemuan04/Praktikum/p4_1_714240002
flutter pub get
flutter run
```

---

## 🧪 Testing

```bash
flutter test
```

---

## 📚 Konsep Flutter yang Dipelajari

| Konsep | Implementasi |
|--------|-------------|
| `StatelessWidget` | Semua screen (`MyApp`, `MainScreen`, `DetailScreen`, `_InfoItem`) |
| `ListView.builder` | Daftar wisata lazy-built |
| `Navigator.push / pop` | Navigasi antar halaman |
| `MaterialPageRoute` | Transisi halaman standar Material |
| `Stack` | Overlay tombol kembali di atas gambar hero |
| `SafeArea` | Hindari tumpang tindih dengan status bar / notch |
| `AspectRatio` | Proporsi gambar konsisten (16:9 dan 4:3) |
| Custom Font (`Staatliches`) | Didaftarkan di `pubspec.yaml`, digunakan via `TextStyle(fontFamily:)` |
| `Image.asset` | Gambar dari folder lokal `images/` |
| `Image.network` | Gambar galeri dari URL CDN |
| `errorBuilder` | Fallback widget jika gambar gagal dimuat |
