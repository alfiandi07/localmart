import 'package:flutter/material.dart';
import 'package:localmart/Local_mart/Constants/database/db_helper_store.dart';
import 'package:localmart/Local_mart/Constants/database/db_helper_user.dart';
import 'package:localmart/Local_mart/Constants/models/user_model.dart';
import 'package:localmart/Local_mart/Constants/views/store/kelola_toko.dart';

class DaftarTokoPage extends StatefulWidget {
  const DaftarTokoPage({super.key});

  @override
  State<DaftarTokoPage> createState() => _DaftarTokoPageState();
}

class _DaftarTokoPageState extends State<DaftarTokoPage> {
  final _formKey = GlobalKey<FormState>();

  final _namaTokoController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _alamatTokoController = TextEditingController();
  final _phoneTokoController = TextEditingController();
  final _bankAccountController = TextEditingController();

  String _selectedBank = 'Bank BCA';
  bool _isLoading = false;

  final List<String> _bankOptions = [
    'Bank BCA',
    'Bank Mandiri',
    'Bank BRI',
    'Bank BNI',
    'Bank Syariah Indonesia (BSI)',
  ];

  @override
  void initState() {
    super.initState();
    // Prefill data telepon dari user jika ada
    final currentUser = UserDbHelper.currentUser;
    if (currentUser != null) {
      _phoneTokoController.text = currentUser.phone;
      _alamatTokoController.text = currentUser.address;
    }
  }

  @override
  void dispose() {
    _namaTokoController.dispose();
    _deskripsiController.dispose();
    _alamatTokoController.dispose();
    _phoneTokoController.dispose();
    _bankAccountController.dispose();
    super.dispose();
  }

  Future<void> _prosesDaftarToko() async {
    if (!_formKey.currentState!.validate()) return;

    final UserModel? currentUser = UserDbHelper.currentUser;
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Anda harus login terlebih dahulu untuk mendaftar toko!',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    bool success = await StoreDbHelper.registerStore(
      userId: currentUser.id,
      storeName: _namaTokoController.text.trim(),
      description: _deskripsiController.text.trim(),
      address: _alamatTokoController.text.trim(),
      phone: _phoneTokoController.text.trim(),
      bankName: _selectedBank,
      bankAccount: _bankAccountController.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Selamat! Toko Anda berhasil terdaftar.',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color(0xFF0025A5),
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Pindah ke Dashboard Kelola Toko
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => KelolaTokoPage(
            store: StoreDbHelper.currentStore!,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Gagal mendaftarkan toko atau akun Anda sudah memiliki toko.',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    const Color primaryColor = Color(0xFF0025A5);
    final Color backgroundColor =
        isDark ? const Color(0xFF121212) : const Color(0xFFFCF9F8);
    final Color cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final Color textColor = isDark ? Colors.white : const Color(0xFF1A1B24);
    final Color subtextColor =
        isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final Color fieldFill =
        isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF4F2FF);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Pendaftaran Toko',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: cardBg,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Banner Promosi Pendaftaran Toko
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0025A5), Color(0xFF354184)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.storefront_rounded,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Buka Toko Gratis!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Jangkau ribuan pembeli lokal di platform LocalMart.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ---------------------------------------------------------------
              // SECTION 1: INFORMASI TOKO
              // ---------------------------------------------------------------
              Text(
                'INFORMASI TOKO',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 12),

              // Field Nama Toko
              TextFormField(
                controller: _namaTokoController,
                style: TextStyle(color: textColor),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Nama toko wajib diisi!';
                  }
                  if (val.trim().length < 3) {
                    return 'Nama toko minimal 3 karakter!';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Nama Toko',
                  hintText: 'Contoh: Toko Berkah Jaya',
                  prefixIcon: const Icon(Icons.store, color: primaryColor),
                  filled: true,
                  fillColor: fieldFill,
                  labelStyle: TextStyle(color: subtextColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Field Deskripsi Toko
              TextFormField(
                controller: _deskripsiController,
                maxLines: 3,
                style: TextStyle(color: textColor),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Deskripsi toko wajib diisi!';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Deskripsi / Slogan Toko',
                  hintText: 'Menyediakan produk lokal berkualitas...',
                  prefixIcon:
                      const Icon(Icons.description, color: primaryColor),
                  filled: true,
                  fillColor: fieldFill,
                  labelStyle: TextStyle(color: subtextColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Field Alamat Toko
              TextFormField(
                controller: _alamatTokoController,
                maxLines: 2,
                style: TextStyle(color: textColor),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Alamat toko wajib diisi!';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Alamat Operasional Toko',
                  prefixIcon:
                      const Icon(Icons.location_on, color: primaryColor),
                  filled: true,
                  fillColor: fieldFill,
                  labelStyle: TextStyle(color: subtextColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Field No. Telepon / WhatsApp Toko
              TextFormField(
                controller: _phoneTokoController,
                keyboardType: TextInputType.phone,
                style: TextStyle(color: textColor),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Nomor HP/WhatsApp toko wajib diisi!';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'No. WhatsApp Toko',
                  hintText: '08xxxxxxxxxx',
                  prefixIcon: const Icon(Icons.phone, color: primaryColor),
                  filled: true,
                  fillColor: fieldFill,
                  labelStyle: TextStyle(color: subtextColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ---------------------------------------------------------------
              // SECTION 2: INFORMASI REKENING PENCAIRAN
              // ---------------------------------------------------------------
              Text(
                'REKENING PENCAIRAN DANA',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 12),

              // Dropdown Nama Bank
              DropdownButtonFormField<String>(
                value: _selectedBank,
                dropdownColor: cardBg,
                style: TextStyle(color: textColor, fontSize: 14),
                decoration: InputDecoration(
                  labelText: 'Pilih Bank',
                  prefixIcon: const Icon(Icons.account_balance,
                      color: primaryColor),
                  filled: true,
                  fillColor: fieldFill,
                  labelStyle: TextStyle(color: subtextColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: _bankOptions.map((bank) {
                  return DropdownMenuItem<String>(
                    value: bank,
                    child: Text(bank),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _selectedBank = val;
                    });
                  }
                },
              ),
              const SizedBox(height: 14),

              // Field Nomor Rekening
              TextFormField(
                controller: _bankAccountController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: textColor),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Nomor rekening bank wajib diisi!';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Nomor Rekening Bank',
                  hintText: 'Contoh: 1234567890',
                  prefixIcon:
                      const Icon(Icons.credit_card, color: primaryColor),
                  filled: true,
                  fillColor: fieldFill,
                  labelStyle: TextStyle(color: subtextColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Tombol Submit Pendaftaran Toko
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _prosesDaftarToko,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Daftar Toko Sekarang',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
