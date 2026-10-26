const String studentName = 'Nadi Azzada Akbar';
const String studentNpm = '714240002';
const String profileImageAsset = 'images/profil.JPG';

const String aboutStudent =
    'Saya tertarik pada teknologi, pemrograman, dan pengembangan aplikasi. '
    'Di waktu luang, saya senang mempelajari hal baru, mengeksplorasi ide kreatif, '
    'dan melakukan aktivitas bersama teman.';

class ActivityPhoto {
  final String title;
  final String imageUrl;

  const ActivityPhoto({required this.title, required this.imageUrl});
}

const List<ActivityPhoto> activityPhotos = <ActivityPhoto>[
  ActivityPhoto(
    title: 'Belajar Teknologi',
    imageUrl: 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?auto=format&fit=crop&w=900&q=85',
  ),
  ActivityPhoto(
    title: 'Kolaborasi Tim',
    imageUrl: 'https://images.unsplash.com/photo-1521737711867-e3b97375f902?auto=format&fit=crop&w=900&q=85',
  ),
  ActivityPhoto(
    title: 'Kegiatan Kampus',
    imageUrl: 'https://images.unsplash.com/photo-1523580494863-6f3031224c94?auto=format&fit=crop&w=900&q=85',
  ),
];
