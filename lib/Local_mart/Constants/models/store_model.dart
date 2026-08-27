// Model data untuk Toko / Seller Account

class StoreModel {
  final String id;
  final String userId;
  final String storeName;
  final String description;
  final String address;
  final String phone;
  final String bankName;
  final String bankAccount;
  final String? logoPath;
  final String createdAt;

  StoreModel({
    required this.id,
    required this.userId,
    required this.storeName,
    required this.description,
    required this.address,
    required this.phone,
    required this.bankName,
    required this.bankAccount,
    this.logoPath,
    required this.createdAt,
  });

  // Factory constructor dari Map
  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
      id: map['id']?.toString() ?? '',
      userId: map['userId']?.toString() ?? '',
      storeName: map['storeName'] ?? '',
      description: map['description'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
      bankName: map['bankName'] ?? '',
      bankAccount: map['bankAccount'] ?? '',
      logoPath: map['logoPath'],
      createdAt: map['createdAt'] ?? '',
    );
  }

  // Konversi StoreModel ke Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'storeName': storeName,
      'description': description,
      'address': address,
      'phone': phone,
      'bankName': bankName,
      'bankAccount': bankAccount,
      'logoPath': logoPath,
      'createdAt': createdAt,
    };
  }
}
