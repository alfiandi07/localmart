import 'package:localmart/Day_20/Constants/models/user_model.dart';

// Database Helper & Dynamic User Data Store LocalMart
class UserDbHelper {
  UserDbHelper._();

  // List Database Akun Pengguna Terdaftar
  static final List<UserModel> _userDatabase = [];

  // User Aktif yang Sedang Login (Default null saat aplikasi belum login)
  static UserModel? currentUser;

  // Mendapatkan semua daftar akun terdaftar
  static List<UserModel> getUsers() {
    return List.unmodifiable(_userDatabase);
  }

  // Pendaftaran Akun Baru (Register)
  static bool registerUser({
    required String name,
    required String email,
    required String phone,
    required String password,
    String address = 'Jl. Melati No. 45, Bandung',
  }) {
    // Cek apakah email sudah terdaftar
    bool isExist = _userDatabase.any(
      (user) => user.email.toLowerCase() == email.toLowerCase(),
    );
    if (isExist) {
      return false; // Gagal, email sudah terdaftar
    }

    String newId = 'USR-00${_userDatabase.length + 1}';
    UserModel newUser = UserModel(
      id: newId,
      name: name,
      email: email,
      phone: phone,
      password: password,
      address: address,
      role: 'Member Baru',
    );

    _userDatabase.add(newUser);
    currentUser = newUser; // Set sebagai user aktif yang baru mendaftar
    return true; // Berhasil mendaftar
  }

  // Autentikasi Login Akun (Hanya akun terdaftar yang berhasil masuk)
  static UserModel? loginUser({
    required String emailOrPhone,
    required String password,
  }) {
    try {
      UserModel matchedUser = _userDatabase.firstWhere(
        (user) =>
            (user.email.toLowerCase() == emailOrPhone.toLowerCase() ||
                user.phone == emailOrPhone) &&
            user.password == password,
      );
      currentUser = matchedUser; // Set user aktif jika akun terdaftar
      return matchedUser;
    } catch (_) {
      currentUser = null; // Akun tidak terdaftar / password salah -> tetap null
      return null;
    }
  }

  // Perbarui Data Profil User Aktif
  static void updateCurrentUser({
    required String name,
    required String email,
    required String phone,
    required String address,
  }) {
    if (currentUser == null) return;

    int index = _userDatabase.indexWhere((u) => u.id == currentUser!.id);
    UserModel updatedUser = UserModel(
      id: currentUser!.id,
      name: name,
      email: email,
      phone: phone,
      password: currentUser!.password,
      address: address,
      role: currentUser!.role,
    );

    if (index != -1) {
      _userDatabase[index] = updatedUser;
    }
    currentUser = updatedUser;
  }

  // Hapus Akun
  static bool deleteUser(String id) {
    int initialLength = _userDatabase.length;
    _userDatabase.removeWhere((user) => user.id == id);
    if (currentUser?.id == id) {
      currentUser = null;
    }
    return _userDatabase.length < initialLength;
  }
}
