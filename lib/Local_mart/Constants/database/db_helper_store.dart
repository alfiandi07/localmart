import 'package:localmart/Local_mart/Constants/models/store_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Database Helper khusus Data Toko / Seller LocalMart
class StoreDbHelper {
  StoreDbHelper._();

  static Database? _database;

  // Toko milik user yang sedang aktif login
  static StoreModel? currentStore;

  // Inisialisasi SQLite Database Toko
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'localmart_stores.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE stores (
            id TEXT PRIMARY KEY,
            userId TEXT NOT NULL UNIQUE,
            storeName TEXT NOT NULL,
            description TEXT NOT NULL,
            address TEXT NOT NULL,
            phone TEXT NOT NULL,
            bankName TEXT NOT NULL,
            bankAccount TEXT NOT NULL,
            logoPath TEXT,
            createdAt TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // Mendapatkan data toko berdasarkan ID Pengguna (User ID)
  static Future<StoreModel?> getStoreByUserId(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'stores',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      StoreModel store = StoreModel.fromMap(maps.first);
      currentStore = store;
      return store;
    } else {
      currentStore = null;
      return null;
    }
  }

  // Pendaftaran Toko Baru (Register Store)
  static Future<bool> registerStore({
    required String userId,
    required String storeName,
    required String description,
    required String address,
    required String phone,
    required String bankName,
    required String bankAccount,
  }) async {
    final db = await database;

    // Cek apakah user sudah punya toko
    StoreModel? existing = await getStoreByUserId(userId);
    if (existing != null) {
      return false; // Sudah punya toko
    }

    String newStoreId = 'STR-${DateTime.now().millisecondsSinceEpoch}';
    StoreModel newStore = StoreModel(
      id: newStoreId,
      userId: userId,
      storeName: storeName,
      description: description,
      address: address,
      phone: phone,
      bankName: bankName,
      bankAccount: bankAccount,
      createdAt: DateTime.now().toString(),
    );

    await db.insert('stores', newStore.toMap());
    currentStore = newStore;
    return true;
  }

  // Perbarui Data Toko
  static Future<bool> updateStore(StoreModel store) async {
    final db = await database;
    int count = await db.update(
      'stores',
      store.toMap(),
      where: 'id = ?',
      whereArgs: [store.id],
    );

    if (count > 0) {
      currentStore = store;
      return true;
    }
    return false;
  }
}
