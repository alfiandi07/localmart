// Model data untuk Akun Pengguna / User Account

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String address;
  final String role;
  final String? photoPath;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    this.address = 'Jl. Melati No. 45, Bandung',
    this.role = 'Pelanggan',
    this.photoPath,
  });

  // Factory constructor konversi dari Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? 'Jl. Melati No. 45, Bandung',
      role: map['role'] ?? 'Pelanggan',
      photoPath: map['photoPath'],
    );
  }

  // Konversi UserModel ke Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'address': address,
      'role': role,
      'photoPath': photoPath,
    };
  }
}
