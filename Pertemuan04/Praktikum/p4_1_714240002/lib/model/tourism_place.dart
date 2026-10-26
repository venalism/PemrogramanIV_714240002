class TourismPlace {
  final String name;
  final String location;
  final String description;
  final String openDays;
  final String openTime;
  final String ticketPrice;
  final String imageAsset;
  final List<String> imageUrls;

  const TourismPlace({
    required this.name,
    required this.location,
    required this.description,
    required this.openDays,
    required this.openTime,
    required this.ticketPrice,
    required this.imageAsset,
    required this.imageUrls,
  });
}

/// Data statis tempat wisata mengikuti contoh yang ditautkan pada modul praktikum.
/// Nilai jam dan tiket adalah data contoh untuk tugas; cek kembali sebelum digunakan
/// sebagai informasi perjalanan aktual.
final List<TourismPlace> tourismPlaceList = <TourismPlace>[
  const TourismPlace(
    name: 'Observatorium Bosscha',
    location: 'Lembang',
    description: '''Observatorium Bosscha memiliki beberapa teleskop, antara lain Refraktor Ganda Zeiss, Schmidt Bimasakti, Refraktor Bamberg, Cassegrain GOTO, dan Teleskop Surya. Refraktor Ganda Zeiss merupakan teleskop besar untuk meneropong bintang. Kunjungan ke observatorium mengikuti jadwal dan ketentuan yang berlaku; pengamatan menggunakan teleskop perlu didaftarkan terlebih dahulu.''',
    openDays: 'Open Tuesday - Saturday',
    openTime: '09:00 - 14:30',
    ticketPrice: 'Rp 20.000',
    imageAsset: 'images/bosscha.jpg',
    imageUrls: <String>[
      'https://media-cdn.tripadvisor.com/media/photo-o/12/6b/63/0b/bosscha-observatory.jpg',
      'https://media-cdn.tripadvisor.com/media/photo-p/0d/6a/88/9b/photo3jpg.jpg',
      'https://media-cdn.tripadvisor.com/media/photo-o/11/3f/04/39/p-20171111-110220-largejpg.jpg',
    ],
  ),
  const TourismPlace(
    name: 'Farm House Lembang',
    location: 'Lembang',
    description: '''Berada di jalur utama Bandung-Lembang, Farm House menawarkan suasana wisata khas Eropa dengan bangunan tematik dan banyak spot swafoto. Pengunjung juga dapat menikmati area rekreasi keluarga serta melihat hewan.''',
    openDays: 'Open Everyday',
    openTime: '09:00 - 20:00',
    ticketPrice: 'Rp 25.000',
    imageAsset: 'images/farm-house.jpg',
    imageUrls: <String>[
      'https://media-cdn.tripadvisor.com/media/photo-s/0d/7c/59/70/farmhouse-lembang.jpg',
      'https://media-cdn.tripadvisor.com/media/photo-w/13/f0/22/f6/photo3jpg.jpg',
      'https://media-cdn.tripadvisor.com/media/photo-m/1280/16/a9/33/43/liburan-di-farmhouse.jpg',
    ],
  ),
  const TourismPlace(
    name: 'Floating Market',
    location: 'Lembang',
    description: '''Floating Market Lembang merupakan tempat rekreasi keluarga dengan kawasan yang tertata dan suasana alami. Salah satu daya tariknya adalah jajanan dan makanan yang dijual dari perahu, selain berbagai wahana dan area tematik.''',
    openDays: 'Open Everyday',
    openTime: '09:00 - 17:00',
    ticketPrice: 'Rp 20.000',
    imageAsset: 'images/floating-market.png',
    imageUrls: <String>[
      'https://media-cdn.tripadvisor.com/media/photo-o/17/f9/ff/f8/floating-market-bandung.jpg',
      'https://media-cdn.tripadvisor.com/media/photo-p/1a/86/d3/cd/20200103-125059-largejpg.jpg',
      'https://media-cdn.tripadvisor.com/media/photo-p/19/ce/b4/9b/img20181224120857-largejpg.jpg',
    ],
  ),
  const TourismPlace(
    name: 'Jalan Asia Afrika',
    location: 'Kota Bandung',
    description: '''Jalan Asia Afrika merupakan kawasan bersejarah di pusat Kota Bandung. Di sekitarnya terdapat bangunan bergaya kolonial dan penanda Bandung Kilometer Nol yang berkaitan dengan sejarah perkembangan kota.''',
    openDays: 'Open Everyday',
    openTime: '24 hours',
    ticketPrice: 'Free',
    imageAsset: 'images/jalan-asia-afrika.jpg',
    imageUrls: <String>[
      'https://media-cdn.tripadvisor.com/media/photo-o/0d/c2/e7/e6/quotes-kota-bandung.jpg',
      'https://media-cdn.tripadvisor.com/media/photo-w/17/f4/44/01/jalan-asia-afrika.jpg',
      'https://media-cdn.tripadvisor.com/media/photo-s/0a/ef/36/e2/jalan-asia-afrika.jpg',
    ],
  ),
  const TourismPlace(
    name: 'Kawah Putih',
    location: 'Ciwidey',
    description: '''Kawah Putih adalah danau kawah yang terbentuk akibat aktivitas vulkanik Gunung Patuha. Kawasan ini terkenal dengan air danau berwarna terang dan tanah putih akibat kandungan belerang, serta pemandangan alam dataran tinggi.''',
    openDays: 'Open Everyday',
    openTime: '07:00 - 17:00',
    ticketPrice: 'Rp 15.000',
    imageAsset: 'images/kawah-putih.jpg',
    imageUrls: <String>[
      'https://media-cdn.tripadvisor.com/media/photo-o/0b/6e/7c/ce/rocks-sticking-out-of.jpg',
      'https://media-cdn.tripadvisor.com/media/photo-p/0b/35/30/14/white-crater.jpg',
      'https://media-cdn.tripadvisor.com/media/photo-o/0a/8b/9a/79/2945-t00572-www-initempatwisat.jpg',
    ],
  ),
  const TourismPlace(
    name: 'Museum Geologi',
    location: 'Kota Bandung',
    description: '''Museum Geologi menyimpan dan mengelola koleksi geologi seperti fosil, batuan, dan mineral yang dikumpulkan dari kegiatan penelitian lapangan. Museum ini juga merupakan salah satu bangunan bersejarah dan sarana edukasi ilmu kebumian di Bandung.''',
    openDays: 'Open Saturday - Thursday',
    openTime: '09:00 - 15:30',
    ticketPrice: 'Rp 3.000',
    imageAsset: 'images/museum-geologi.jpg',
    imageUrls: <String>[
      'https://media-cdn.tripadvisor.com/media/photo-w/19/1c/8e/f7/geology-museum.jpg',
      'https://media-cdn.tripadvisor.com/media/photo-o/11/a7/35/b7/geology-museum.jpg',
      'https://media-cdn.tripadvisor.com/media/photo-s/1a/55/e0/dc/geology-museum.jpg',
    ],
  ),
  const TourismPlace(
    name: 'Ranca Upas',
    location: 'Ciwidey',
    description: '''Ranca Upas Ciwidey adalah kawasan bumi perkemahan di Bandung Selatan. Pengunjung dapat menikmati suasana alam, berkemah, berinteraksi dengan rusa, serta mengunjungi fasilitas rekreasi dan pemandian air panas di kawasan sekitarnya.''',
    openDays: 'Open Everyday',
    openTime: '24 hours',
    ticketPrice: 'Rp 20.000',
    imageAsset: 'images/ranca-upas.jpg',
    imageUrls: <String>[
      'https://media-cdn.tripadvisor.com/media/photo-o/1a/e0/7f/9c/kampung-cai-ranca-upas.jpg',
      'https://media-cdn.tripadvisor.com/media/photo-w/13/ee/2f/87/ranca-upas.jpg',
      'https://media-cdn.tripadvisor.com/media/photo-w/13/ee/27/0a/ranca-upas.jpg',
    ],
  ),
  const TourismPlace(
    name: 'Stone Garden',
    location: 'Padalarang',
    description: '''Stone Garden di Padalarang dikenal dengan hamparan batu kapur yang memiliki formasi unik. Dari kawasan ini, pengunjung dapat menikmati pemandangan perbukitan dan bentang alam yang berbeda dari pusat Kota Bandung.''',
    openDays: 'Open Everyday',
    openTime: '06:00 - 17:00',
    ticketPrice: 'Rp 3.000',
    imageAsset: 'images/stone-garden.jpg',
    imageUrls: <String>[
      'https://media-cdn.tripadvisor.com/media/photo-o/15/01/d7/4b/p-20180510-153310-01.jpg',
      'https://media-cdn.tripadvisor.com/media/photo-w/15/68/00/32/stone-garden-citatah.jpg',
      'https://media-cdn.tripadvisor.com/media/photo-o/0d/a2/cb/05/stone-garden-citatah.jpg',
    ],
  ),
  const TourismPlace(
    name: 'Taman Film Pasopati',
    location: 'Kota Bandung',
    description: '''Taman Film Pasopati merupakan ruang terbuka publik di kawasan bawah Jalan Layang Pasupati. Taman ini dikenal dengan area duduk bertingkat dan layar besar yang pernah digunakan untuk pemutaran film serta kegiatan bersama.''',
    openDays: 'Open Everyday',
    openTime: '24 hours',
    ticketPrice: 'Free',
    imageAsset: 'images/taman-film.jpg',
    imageUrls: <String>[
      'https://media-cdn.tripadvisor.com/media/photo-o/08/8b/87/50/bandung-movie-park.jpg',
      'https://media-cdn.tripadvisor.com/media/photo-o/17/67/d5/53/img-20190505-114509-largejpg.jpg',
      'https://media-cdn.tripadvisor.com/media/photo-w/09/73/33/05/taman-film-pasopati.jpg',
    ],
  ),
];
