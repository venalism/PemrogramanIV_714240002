# Asesmen Tengah Semester Pemrograman IV: Aplikasi Daftar Kontak

**Universitas:** Universitas Logistik dan Bisnis Internasional (ULBI)
**Program Studi:** D4 Teknik Informatika, Semester 5
**Mata Kuliah:** Pemrograman IV (Pemrograman Mobile)
**Dosen:** Indra Riksa Herlambang, M.Kom., SFPC.
**Nama:** Nadi Azzada Akbar
**NPM:** 714240002
**Jenis:** Asesmen Tengah Semester (proyek individu, materi praktikum pertemuan 1-7)

---

## Deskripsi Proyek

Proyek ini berupa aplikasi Flutter dengan dua halaman, yaitu **Home** dan **Daftar Kontak**. Halaman Home menampilkan identitas mahasiswa dalam tampilan kartu. Halaman Daftar Kontak menyediakan formulir untuk menambah, mengubah, dan menghapus kontak. Setiap kontak memuat nama, nomor telepon, tanggal, warna, dan berkas.

Data kontak tersimpan di memori aplikasi (state) selama sesi berjalan dan tetap tersedia saat pengguna berpindah antara kedua halaman. Penyimpanan permanen, database, dan API tidak digunakan sesuai ketentuan soal.

---

## Fitur Utama

| Fitur | Keterangan |
|---|---|
| Navigasi dua halaman | `BottomNavigationBar` dengan tab Home dan Daftar Kontak, ditambah tombol pintasan di Home |
| Tambah kontak | Data berasal dari formulir dan masuk ke daftar saat seluruh input valid |
| Ubah kontak | Nilai kontak terpilih tampil kembali pada formulir, tombol berubah menjadi "Update", dan perubahan menimpa kontak yang sama tanpa membuat kontak baru |
| Hapus kontak | Dialog konfirmasi tampil sebelum kontak dihapus |
| Date Picker | `showDatePicker` melalui `TextFormField` dengan `readOnly: true`, format tampilan `dd-MM-yyyy` |
| Color Picker | `BlockPicker` di dalam `AlertDialog`, warna baru berlaku setelah tombol Simpan ditekan |
| File Picker | Berkas apa pun dapat dipilih, pratinjau gambar tampil untuk JPG, JPEG, dan PNG |
| Validasi | Validator pada setiap isian, SnackBar tampil saat ada isian wajib yang kosong atau tidak valid |
| Persistensi sesi | Daftar kontak berada di state `AppShell`, sehingga data bertahan saat berpindah halaman |

---

## Struktur Berkas

```
uts_pemrogramanIV_714240002/
├── lib/
│   ├── main.dart            # Titik masuk, tema, AppShell (pemilik state daftar kontak)
│   ├── home_screen.dart     # Halaman Home: kartu identitas dan tombol menuju Daftar Kontak
│   ├── contact_screen.dart  # Halaman Daftar Kontak: formulir, validasi, picker, dan daftar
│   └── models/
│       └── contact.dart     # Model data Contact
├── pubspec.yaml             # Dependensi
└── README.md
```

---

## Alur Aplikasi

```
main() -> runApp(MyApp)
    └─ MaterialApp (useMaterial3: false)
            └─ AppShell (StatefulWidget, pemilik List<Contact>)
                    ├─ IndexedStack
                    │     ├─ [0] HomeScreen(contactCount, onOpenContacts)
                    │     └─ [1] ContactScreen(contacts, onAdd, onUpdate, onDelete)
                    └─ BottomNavigationBar (Home | Daftar Kontak)
```

Kendali data bersifat satu arah. `ContactScreen` memanggil callback `onAdd`, `onUpdate`, dan `onDelete`. `AppShell` mengubah daftar di dalam `setState`, lalu kedua halaman menerima daftar terbaru.

---

## Dokumentasi Per Berkas

### `lib/models/contact.dart`

Model data yang tidak dapat diubah (semua field `final`).

| Field | Tipe | Fungsi |
|---|---|---|
| `name` | `String` | Nama lengkap kontak |
| `phone` | `String` | Nomor telepon berawalan 62 |
| `date` | `DateTime` | Tanggal terpilih |
| `color` | `Color` | Warna penanda kontak |
| `fileName` | `String` | Nama berkas terpilih |
| `fileBytes` | `Uint8List?` | Isi berkas dalam byte, dipakai untuk pratinjau gambar |

Getter `isImage` mengubah ekstensi berkas menjadi huruf kecil dengan `toLowerCase()`, lalu memeriksa apakah nilainya `jpg`, `jpeg`, atau `png`. Berkas `.PNG` dan `.png` sama-sama dikenali.

### `lib/main.dart`

- `MyApp` menyiapkan `MaterialApp` dengan `useMaterial3: false` sesuai praktikum.
- `AppShell` adalah `StatefulWidget` yang menyimpan `_index` (tab aktif) dan `_contacts` (daftar kontak).
- `IndexedStack` mempertahankan kedua halaman di dalam pohon widget. Isi formulir dan posisi gulir `ContactScreen` tidak hilang saat pengguna membuka Home.

### `lib/home_screen.dart`

`StatelessWidget` yang menampilkan `Card` di tengah layar. Isinya berupa avatar, nama, NPM, program studi, jumlah kontak tersimpan, dan tombol "Buka Daftar Kontak". Konstanta `nama` dan `npm` berada di bagian atas kelas dan mudah diganti.

### `lib/contact_screen.dart`

`StatefulWidget` utama aplikasi. Seluruh isian berada di dalam satu `Form` dengan `GlobalKey<FormState>`.

**State yang dikelola:**

| Variabel | Fungsi |
|---|---|
| `_nameCtrl`, `_phoneCtrl`, `_dateCtrl`, `_fileCtrl` | `TextEditingController`, dilepas di `dispose()` |
| `_date` | `DateTime?` bernilai asli tanggal terpilih, terpisah dari teks pada controller |
| `_color` | Warna terpilih, bawaan `Colors.blue` |
| `_fileName`, `_fileBytes` | Berkas terpilih |
| `_editIndex` | `int?`. Nilai `null` berarti mode tambah, nilai angka berarti mode ubah pada indeks tersebut |

**Method utama:**

| Method | Fungsi |
|---|---|
| `_pickDate()` | Menampilkan Date Picker. Jika dialog dibatalkan, method keluar tanpa mengubah state |
| `_pickColor()` | Menyimpan warna sementara (`temp`) dan memindahkannya ke `_color` hanya saat tombol Simpan ditekan |
| `_pickFile()` | Memanggil `FilePicker.platform.pickFiles` secara asinkron. Jika hasil `null`, pilihan lama dipertahankan |
| `_submit()` | Menjalankan `validate()`. Jika gagal, SnackBar tampil dan data tidak disimpan. Jika lolos, memanggil `onAdd` atau `onUpdate` sesuai mode |
| `_startEdit(i)` | Mengisi formulir dengan data kontak ke-`i` dan mengaktifkan mode ubah |
| `_confirmDelete(i)` | Menampilkan `AlertDialog` konfirmasi sebelum memanggil `onDelete` |
| `_clearForm()` | Mengosongkan formulir dan mengembalikan mode ke tambah |

Daftar kontak ditampilkan dengan `List.generate` di dalam satu `ListView` bersama formulir. Setiap item memuat avatar berwarna, nama, nomor telepon, tanggal `dd-MM-yyyy`, nama berkas, tombol ubah dan hapus, serta pratinjau `Image.memory` untuk gambar.

---

## Aturan Validasi

| Isian | Aturan | Contoh valid | Contoh ditolak |
|---|---|---|---|
| Nama | Minimal dua kata, hanya huruf dan spasi, setiap kata diawali huruf kapital, spasi di awal dan akhir diabaikan | `Budi Santoso` | `budi santoso`, `Budi`, `Budi123` |
| Nomor telepon | Hanya digit 0-9, diawali `62` tanpa tanda `+`, total 8-13 digit | `628123456789` | `08123456789`, `+628123456789`, `62812` |
| Tanggal | Wajib berasal dari Date Picker | `05-11-2026` | Kosong |
| Berkas | Wajib sudah dipilih | `foto.png` | Kosong |
| Warna | Bawaan biru, dapat diganti melalui Color Picker | Warna bawaan atau pilihan | Tidak berlaku |

Pembatalan dialog tanggal, warna, atau berkas tidak menimbulkan galat dan tidak menghapus pilihan sebelumnya.

---

## Dependensi

| Paket | Fungsi |
|---|---|
| `intl` | Memformat `DateTime` menjadi `dd-MM-yyyy` melalui `DateFormat` |
| `flutter_colorpicker` | Menyediakan `BlockPicker` untuk memilih warna |
| `file_picker` (`^10.3.3`) | Memilih berkas dari perangkat melalui `FilePicker.platform.pickFiles` |

Paket `open_file` tidak dipakai karena pembukaan berkas melalui aplikasi lain bersifat opsional dan tidak didukung pada web.

---

## Cara Menjalankan

```bash
flutter pub get
flutter run -d chrome --web-browser-flag "--disable-web-security"
```

Untuk Android, gunakan `flutter run` dengan emulator atau perangkat terhubung. Verifikasi kompilasi Android tanpa emulator dapat dilakukan dengan:

```bash
flutter build apk --debug
```

Sebelum pengumpulan:

```bash
flutter clean
```

Kemudian kompres seluruh folder proyek menjadi `UTS_PemrogramanIV_714240002_NadiAzzadaAkbar.zip`.

---

## Justifikasi Penggunaan Web Browser

Pengembangan dan pengujian proyek ini dilakukan pada peramban web (Brave, berbasis Chromium) dengan target `chrome`. Alasannya terletak pada keterbatasan perangkat pribadi.

**1. Keterbatasan penyimpanan laptop.**
Emulator Android memerlukan Android SDK, system image, dan berkas AVD. Gabungannya memakan belasan gigabita dan terus bertambah seiring pembaruan serta cache Gradle. Ruang penyimpanan laptop yang tersedia tidak mencukupi untuk beban tersebut. Target web hanya memerlukan peramban yang sudah terpasang.

**2. Performa ponsel pribadi yang kurang memadai.**
Debugging langsung pada ponsel membutuhkan proses build APK berulang, instalasi, dan sesi debug yang aktif. Spesifikasi ponsel pribadi menyebabkan proses tersebut lambat dan tidak stabil, sehingga siklus uji coba memakan waktu jauh lebih lama.

**3. Siklus pengembangan yang cepat.**
Hot reload dan hot restart pada target web memberi umpan balik cepat. Hal ini memungkinkan seluruh skenario uji, seperti validasi, mode ubah, dan konfirmasi hapus, dijalankan berulang kali dalam waktu singkat.

**4. Kode berjalan lintas platform.**
Pada web, `dart:io` dan `File.path` tidak tersedia. Kode ini menyimpan isi berkas sebagai `Uint8List` melalui `withData: true` dan menampilkannya dengan `Image.memory`. Pendekatan yang sama berfungsi di Android, sehingga satu basis kode melayani kedua platform.

**5. Penjelasan flag `--disable-web-security`.**
Flag ini diteruskan ke peramban sebagai bagian dari perintah menjalankan proyek. Aplikasi tidak mengakses jaringan, sehingga seluruh fungsi tetap bekerja tanpa flag tersebut.

**Batasan yang diketahui:**
- Dialog pemilih berkas pada web membuka penyimpanan komputer, bukan penyimpanan perangkat Android.
- Pembukaan berkas melalui aplikasi lain (opsional pada soal) tidak diimplementasikan.
- Tampilan pada web dapat berbeda sedikit dari Android, terutama pada dialog dan ukuran layar.
- Ketentuan soal menyebut perangkat atau emulator Android. Perintah `flutter build apk --debug` menjadi cara memverifikasi bahwa proyek terkompilasi untuk Android.

---

## Konsep Flutter yang Diterapkan

| Pertemuan | Konsep | Implementasi |
|---|---|---|
| 3 | StatelessWidget dan StatefulWidget | `HomeScreen`, `AppShell`, `ContactScreen` |
| 3 | `setState` | Memperbarui tampilan setelah data berubah |
| 4 | Layout `Column`, `Row`, `Card`, `Padding`, `SizedBox` | Kartu Home, formulir, dan item daftar |
| 5 | `Navigator` dan `BottomNavigationBar` | Perpindahan antarhalaman |
| 5 | `ListView`, `ClipRRect`, `Image` | Daftar kontak dan pratinjau gambar |
| 6 | `Form`, `TextFormField`, `validator`, `GlobalKey<FormState>` | Validasi nama, telepon, tanggal, berkas |
| 6 | `TextEditingController` dan `dispose()` | Pembacaan teks dan pencegahan kebocoran memori |
| 6 | `AlertDialog` dan `SnackBar` | Konfirmasi hapus dan umpan balik validasi |
| 7 | `showDatePicker`, `BlockPicker`, `FilePicker` | Date Picker, Color Picker, File Picker |
| 7 | `Future`, `async`, `await`, `mounted` | Proses pemilihan berkas yang asinkron |

---

## Penggunaan AI dan Sumber

Sesuai ketentuan asesmen, AI digunakan untuk membantu menyusun contoh kode awal dan menelusuri galat (misalnya perbedaan API `file_picker` dan kompatibilitas web). Seluruh kode telah diperiksa, disesuaikan, dan diuji oleh pemilik proyek, yang bertanggung jawab atas isinya. Paket pihak ketiga yang dipakai adalah `intl`, `flutter_colorpicker`, dan `file_picker`, seluruhnya bersumber dari pub.dev.