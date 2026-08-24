import 'package:localmart/Day_20/Constants/database/db_helper_user.dart';

// Database Keranjang Belanja Berdasarkan Akun Pengguna
final Map<String, List<Map<String, dynamic>>> _userCartsDatabase = {};

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
