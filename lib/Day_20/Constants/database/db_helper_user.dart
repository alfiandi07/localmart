import 'package:localmart/Day_20/Constants/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Database Helper & Dynamic User Data Store LocalMart menggunakan SQLite
class UserDbHelper {
  UserDbHelper._();

  static Database? _database;

  // User Aktif yang Sedang Login (Default null saat aplikasi belum login)
  static UserModel? currentUser;

  // Inisialisasi / Ambil instance Database SQLite
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'localmart_users.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            email TEXT NOT NULL UNIQUE,
            phone TEXT NOT NULL,
            password TEXT NOT NULL,
            address TEXT NOT NULL,
            role TEXT NOT NULL,
            photoPath TEXT
          )
        ''');
      },
    );
  }

  // Mendapatkan semua daftar akun terdaftar dari SQLite
  static Future<List<UserModel>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return maps.map((map) => UserModel.fromMap(map)).toList();
  }

  // Pendaftaran Akun Baru (Register) ke SQLite
  static Future<bool> registerUser({
    required String name,
    required String email,
    required String phone,
    required String password,
    String address = 'Jl. Melati No. 45, Bandung',
  }) async {
    final db = await database;

    // Cek apakah email sudah terdaftar
    final List<Map<String, dynamic>> existing = await db.query(
      'users',
      where: 'LOWER(email) = ?',
      whereArgs: [email.toLowerCase()],
    );

    if (existing.isNotEmpty) {
      return false; // Gagal, email sudah terdaftar
    }

    final allUsers = await getUsers();
    String newId = 'USR-00${allUsers.length + 1}';
    UserModel newUser = UserModel(
      id: newId,
      name: name,
      email: email,
      phone: phone,
      password: password,
      address: address,
      role: 'Member Baru',
    );

    await db.insert('users', newUser.toMap());
    currentUser = newUser; // Set sebagai user aktif yang baru mendaftar
    return true; // Berhasil mendaftar
  }

  // Autentikasi Login Akun dari SQLite
  static Future<UserModel?> loginUser({
    required String emailOrPhone,
    required String password,
  }) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: '(LOWER(email) = ? OR phone = ?) AND password = ?',
      whereArgs: [emailOrPhone.toLowerCase(), emailOrPhone, password],
    );

    if (maps.isNotEmpty) {
      UserModel matchedUser = UserModel.fromMap(maps.first);
      currentUser = matchedUser; // Set user aktif jika akun terdaftar
      return matchedUser;
    } else {
      currentUser = null;
      return null;
    }
  }

  // Perbarui Data Profil User Aktif di SQLite
  static Future<void> updateCurrentUser({
    required String name,
    required String email,
    required String phone,
    required String address,
    String? photoPath,
    bool isClearPhoto = false,
  }) async {
    if (currentUser == null) return;

    final db = await database;
    UserModel updatedUser = UserModel(
      id: currentUser!.id,
      name: name,
      email: email,
      phone: phone,
      password: currentUser!.password,
      address: address,
      role: currentUser!.role,
      photoPath: isClearPhoto ? null : (photoPath ?? currentUser!.photoPath),
    );

    await db.update(
      'users',
      updatedUser.toMap(),
      where: 'id = ?',
      whereArgs: [currentUser!.id],
    );

    currentUser = updatedUser;
  }

  // Hapus Akun dari SQLite
  static Future<bool> deleteUser(String id) async {
    final db = await database;
    int count = await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (currentUser?.id == id) {
      currentUser = null;
    }
    return count > 0;
  }
}
