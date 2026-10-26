# Pertemuan 05 – Praktikum 2: Mini Profile Card

**Mata Kuliah:** Pemrograman Mobile
**NIM:** 714240002
**Pertemuan:** 05
**Jenis:** Praktikum – Project (`p5_2_714240002`)

---

## 📋 Deskripsi Project

Project Flutter ini merupakan hasil **Praktikum 2 Pertemuan 05** yang membangun aplikasi **Mini Profile Card** – sebuah kartu profil mahasiswa yang interaktif. Aplikasi menampilkan foto, nama, dan NPM dalam tampilan kartu elegan bergradien, serta menyediakan halaman detail profil yang berisi deskripsi diri dan galeri aktivitas foto horizontal.

Fokus praktikum ini adalah pada **Navigator & Route** untuk navigasi dua arah antar halaman, serta penerapan desain UI premium menggunakan **Material 3**, custom font **Poppins**, gradien warna, dan layout card dengan `BorderRadius`.

---

## ✨ Fitur Utama

- **Home Screen (Kartu Profil)**: Kartu putih bergradien background menampilkan foto profil, nama, dan NPM mahasiswa.
- **Tombol "Lihat Detail Profil"**: `ElevatedButton.icon` yang melakukan `Navigator.push` ke `DetailScreen`.
- **Detail Screen**: Halaman detail dengan header gradien ungu, section "Tentang Saya", dan galeri aktivitas foto horizontal.
- **Galeri Aktivitas**: ListView horizontal berisi 3 foto aktivitas dari URL Unsplash dengan caption overlay.
- **Tombol Kembali**: `OutlinedButton.icon` yang memanggil `Navigator.pop` untuk kembali ke Home.
- **Custom Font Poppins**: Semua teks menggunakan font Poppins (16 varian weight tersedia).
- **Material 3**: Menggunakan `useMaterial3: true` dengan `ColorScheme.fromSeed`.
- **Responsive**: Layout terbatas `maxWidth: 390px` agar konsisten di berbagai ukuran layar.

---

## 🗂️ Struktur File

```
p5_2_714240002/
├── lib/
│   ├── main.dart          # Entry point, theme, & root app (MiniProfileApp)
│   ├── home_screen.dart   # Halaman kartu profil utama
│   ├── detail_screen.dart # Halaman detail profil & galeri aktivitas
│   └── profile_data.dart  # Data statis: nama, NPM, bio, foto aktivitas
├── images/
│   └── profil.JPG         # Foto profil mahasiswa (aset lokal)
├── fonts/
│   └── Poppins-*.ttf      # 16 varian font Poppins
├── test/
│   └── widget_test.dart   # Smoke test menggunakan MiniProfileApp
└── pubspec.yaml
```

---

## 🔄 Alur Navigasi

```
main() → runApp(MiniProfileApp)
    └─ MaterialApp (M3, tema ungu #5B5FEF, font Poppins)
            └─ HomeScreen                           ← Halaman 1
                    ├─ Foto profil (Image.asset)
                    ├─ Nama + NPM
                    └─ ElevatedButton "Lihat Detail Profil"
                            └─ Navigator.push(MaterialPageRoute)
                                    └─ DetailScreen(name, npm)  ← Halaman 2
                                            ├─ Header gradien + nama + NPM
                                            ├─ Tentang Saya (bio)
                                            ├─ Galeri Aktivitas (horizontal)
                                            └─ OutlinedButton "Kembali"
                                                    └─ Navigator.pop → HomeScreen
```

---

## 📄 Dokumentasi Per File

### `lib/profile_data.dart`

File data statis yang memisahkan konten dari UI. Berisi semua string dan daftar data yang digunakan oleh `HomeScreen` dan `DetailScreen`.

```dart
// Konstanta profil mahasiswa
const String studentName = 'Nadi Azzada Akbar';
const String studentNpm  = '714240002';
const String profileImageAsset = 'images/profil.JPG';

// Bio singkat untuk halaman detail
const String aboutStudent = 'Saya tertarik pada teknologi, pemrograman, ...';

// Model foto aktivitas
class ActivityPhoto {
  final String title;    // Caption foto
  final String imageUrl; // URL gambar dari Unsplash
}

// Daftar 3 foto aktivitas
const List<ActivityPhoto> activityPhotos = [
  ActivityPhoto(title: 'Belajar Teknologi', imageUrl: 'https://...'),
  ActivityPhoto(title: 'Kolaborasi Tim',    imageUrl: 'https://...'),
  ActivityPhoto(title: 'Kegiatan Kampus',   imageUrl: 'https://...'),
];
```

| Item | Keterangan |
|------|-----------|
| `studentName`, `studentNpm` | Konstanta string – dipakai oleh HomeScreen dan DetailScreen |
| `profileImageAsset` | Path aset lokal foto profil |
| `aboutStudent` | Teks bio multi-kalimat untuk section "Tentang Saya" |
| `ActivityPhoto` | Model data sederhana: title + imageUrl |
| `activityPhotos` | Daftar `const` berisi 3 objek `ActivityPhoto` |

---

### `lib/main.dart`

Entry point dan konfigurasi tema global aplikasi.

```dart
void main() {
  runApp(const MiniProfileApp());
}

class MiniProfileApp extends StatelessWidget {
  static const Color primaryColor = Color(0xFF5B5FEF); // Ungu utama

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Profile Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,                                    // Material 3
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        scaffoldBackgroundColor: const Color(0xFFF5F6FC),     // Abu-abu terang
        fontFamily: 'Poppins',                                 // Font global
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
```

| Baris kunci | Keterangan |
|-------------|-----------|
| `primaryColor = Color(0xFF5B5FEF)` | Warna ungu brand; digunakan di AppBar, button, dan aksen UI |
| `useMaterial3: true` | Mengaktifkan Material Design 3 (rounded corners, dynamic color) |
| `ColorScheme.fromSeed` | Generate color scheme harmonis dari satu seed color |
| `scaffoldBackgroundColor: 0xFFF5F6FC` | Background halaman abu-abu sangat terang |
| `fontFamily: 'Poppins'` | Font default untuk semua `Text` widget dalam app |
| `appBarTheme` | Konfigurasi AppBar global: putih di atas ungu, centered, no elevation |

---

### `lib/home_screen.dart`

Halaman utama menampilkan kartu profil mahasiswa.

**Hierarki widget:**
```
Scaffold
├─ AppBar('Tugas Pertemuan 5')
└─ body: Container (gradient background)
    └─ Center → SingleChildScrollView → ConstrainedBox(maxWidth:390)
        └─ Card (elevation:9, radius:28, shadow ungu)
            └─ Padding(28, 32, 28, 28) → Column
                ├─ Container (badge "STUDENT PROFILE", bg #EEEEFF, radius:30)
                ├─ SizedBox(h:24)
                ├─ ClipRRect(radius:26) → Image.asset(profil.JPG, 160×160)
                │   └─ errorBuilder: Icon(person_rounded) jika gagal load
                ├─ SizedBox(h:24)
                ├─ Text(studentName, Poppins Bold 25px)
                ├─ SizedBox(h:10)
                ├─ Container (badge NPM, bg #F3F4F9, radius:14)
                ├─ SizedBox(h:28)
                └─ ElevatedButton.icon("Lihat Detail Profil")
                    └─ onPressed: Navigator.push → DetailScreen
```

| Widget / Keputusan Desain | Keterangan |
|--------------------------|-----------|
| `LinearGradient` (background) | Gradien 3-warna biru-ungu sangat pucat sebagai background halaman |
| `ConstrainedBox(maxWidth: 390)` | Membatasi lebar kartu agar tampilan konsisten di tablet/desktop |
| `Card(elevation: 9, shadowColor: primaryColor.withValues(0.14))` | Kartu putih dengan bayangan ungu halus |
| `ClipRRect(radius:26)` + `Image.asset` | Foto profil kotak membulat (hampir persegi panjang membulat) |
| `ElevatedButton.icon` | Tombol dengan ikon badge + teks; background ungu, tinggi 54px |
| `Navigator.push(MaterialPageRoute)` | Navigasi ke `DetailScreen` dengan data name & npm |

---

### `lib/detail_screen.dart`

Halaman detail profil. Menerima `name` dan `npm` via constructor.

```dart
class DetailScreen extends StatelessWidget {
  final String name; // dari HomeScreen
  final String npm;  // dari HomeScreen

  const DetailScreen({super.key, required this.name, required this.npm});
}
```

**Layout dari atas ke bawah (dalam `SingleChildScrollView`):**

| # | Bagian | Widget Utama | Detail |
|---|--------|-------------|--------|
| 1 | **Header Kartu Gradien** | `Container(gradient: #5B5FEF → #777BFF, radius:26)` | Ikon pin lokasi, label "PROFIL MAHASISWA", nama besar, NPM |
| 2 | **Section "Tentang Saya"** | `Padding` → `Text(bold 18px)` + `Text(justify)` | Bio dari `aboutStudent` di `profile_data.dart` |
| 3 | **Section "Galeri Aktivitas"** | `Row(judul + hint "Geser")` + `ListView.builder(horizontal)` | 3 foto Unsplash, h:190, w:250, radius:20, caption overlay |
| 4 | **Tombol Kembali** | `OutlinedButton.icon(Icons.arrow_back_rounded)` | Border ungu, tinggi 52px, `Navigator.pop` |

**Detail galeri aktivitas:**
```
SizedBox(height: 190)
└─ ListView.builder(horizontal, padding:24, separator:14px)
    └─ itemBuilder → SizedBox(width: 250)
        └─ ClipRRect(radius:20)
            └─ Stack(fit: expand)
                ├─ Image.network(photo.imageUrl, cover)
                │   └─ errorBuilder: Icon(image_not_supported, ungu)
                └─ Align(bottomLeft) → Container(overlay hitam 52%)
                    └─ Text(photo.title, Poppins SemiBold 12px, putih)
```

| Widget / Keputusan Desain | Keterangan |
|--------------------------|-----------|
| `SafeArea` | Konten tidak tertutup status bar |
| Header gradient `#5B5FEF → #777BFF` | Gradien ungu diagonal, radius 26px |
| `Flexible` di baris NPM | Teks NPM tidak overflow pada nama panjang |
| `ListView.builder(horizontal)` | Galeri foto dapat digeser ke kanan |
| `Stack` + `Align(bottomLeft)` | Overlay caption di bagian bawah setiap foto |
| `Colors.black.withValues(alpha: 0.52)` | Semi-transparan agar foto tetap terlihat |
| `OutlinedButton.icon` | Tombol outline (bukan filled) untuk variasi visual dari tombol di HomeScreen |

---

## 📦 Dependensi & Aset

| Item | Nilai |
|------|-------|
| Package | `p5_2_714240002` |
| Dart SDK | `^3.13.5` |
| Dependencies | `flutter`, `cupertino_icons: ^1.0.8` |
| Dev deps | `flutter_test`, `flutter_lints: ^6.0.0` |
| Aset gambar | `images/profil.JPG` |
| Custom font | Poppins (16 varian: Regular, Medium, SemiBold, Bold, Light, ExtraBold, Black + Italic) |

---

## 🚀 Cara Menjalankan

```bash
cd Pertemuan05/Praktikum/p5_2_714240002
flutter pub get
flutter run
```

---

## 🧪 Testing

```bash
flutter test
```

File `test/widget_test.dart` berisi smoke test sederhana:
```dart
await tester.pumpWidget(const MiniProfileApp()); // gunakan nama class yang benar
expect(find.byType(MiniProfileApp), findsOneWidget);
```

---

## 📚 Konsep Flutter yang Dipelajari (Pertemuan 05)

| Konsep | Implementasi |
|--------|-------------|
| **Navigator.push** | `ElevatedButton` di HomeScreen membuka DetailScreen |
| **Navigator.pop** | `OutlinedButton` di DetailScreen kembali ke HomeScreen |
| **MaterialPageRoute** | Transisi slide standar Material antar halaman |
| **Passing data antar halaman** | `DetailScreen(name: studentName, npm: studentNpm)` |
| **Material 3** | `useMaterial3: true` + `ColorScheme.fromSeed` |
| **Custom Font (Poppins)** | Didaftarkan di `pubspec.yaml`, dipakai via `fontFamily: 'Poppins'` |
| **LinearGradient** | Background halaman dan header kartu detail |
| **Card dengan shadow warna** | `shadowColor: primaryColor.withValues(alpha: 0.14)` |
| **ListView horizontal** | Galeri foto yang bisa digeser |
| **Stack + Align** | Caption overlay di bawah foto galeri |
| **ConstrainedBox** | Membatasi lebar maksimal layout kartu |
| **SafeArea** | Proteksi dari status bar / notch |
| **Image.asset** | Foto profil dari aset lokal |
| **Image.network** | Foto galeri dari URL Unsplash |
| **errorBuilder** | Placeholder jika gambar gagal dimuat |
| **Separation of concerns** | Data dipisahkan ke `profile_data.dart`, UI di screen files |
