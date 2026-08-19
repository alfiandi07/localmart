import 'package:localmart/Day_20/Constants/database/db_helper_user.dart';

// Database Keranjang Belanja Berdasarkan Akun Pengguna
final Map<String, List<Map<String, dynamic>>> _userCartsDatabase = {
  // Akun bawaan (USR-001 - Alfin LocalMart) memiliki riwayat produk di keranjang
  'USR-001': [
    {
      'image': 'assets/images/jamtangan.jpg',
      'category': 'AKSESORIS',
      'name': 'Jam Tangan Pria',
      'price': 'Rp 250.000',
      'quantity': 1,
    },
    {
      'image': 'assets/images/sepatuadidas.jpg',
      'category': 'Olahraga',
      'name': 'Sepatu Adidas',
      'price': 'Rp 700.000',
      'quantity': 2,
    },
  ],
};

/// Getter dinamis untuk mengambil daftar keranjang milik pengguna yang sedang aktif login.
/// - Jika pengguna baru terdaftar / login pertama kali, keranjang bernilai kosong [].
/// - Jika pengguna memiliki riwayat barang di keranjang, barang tersebut akan otomatis ditampilkan.
List<Map<String, dynamic>> get keranjangBelanjaData {
  final currentUserId = UserDbHelper.currentUser?.id ?? 'GUEST';
  if (!_userCartsDatabase.containsKey(currentUserId)) {
    _userCartsDatabase[currentUserId] = [];
  }
  return _userCartsDatabase[currentUserId]!;
}
