import 'dart:io';
import 'package:flutter/material.dart';
import 'package:localmart/Day_20/Constants/database/data_produkkeranjang.dart';
import 'package:localmart/Day_20/Constants/database/db_helper_user.dart';
import 'package:localmart/Day_20/Constants/models/user_model.dart';
import 'package:localmart/Day_20/Constants/views/edit_profil.dart';
import 'package:localmart/Day_20/Constants/views/info_apk.dart';
import 'package:localmart/Day_20/Constants/views/keranjang.dart';
import 'package:localmart/Day_20/Constants/views/login.dart';
import 'package:localmart/Day_20/Constants/views/pesanan_saya.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF0025A5);
    const Color backgroundColor = Color.fromARGB(255, 249, 250, 250);

    // Ambil data user aktif dari database (null jika belum login)
    final UserModel? currentUser = UserDbHelper.currentUser;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Profil Saya',
          style: TextStyle(
            color: primaryColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Profile & Banner Section
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Banner Top
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF0025A5), Color(0xFF354184)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),

                // Avatar & User Info Card Overlay
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 80, 16, 0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0F002892),
                          blurRadius: 20,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // Avatar Profile Image
                            Builder(
                              builder: (context) {
                                final String? photoPath =
                                    currentUser?.photoPath;
                                final bool hasPhoto =
                                    photoPath != null &&
                                    photoPath.isNotEmpty &&
                                    File(photoPath).existsSync();

                                return Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primaryColor.withValues(alpha: 0.1),
                                    border: Border.all(
                                      color: primaryColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: hasPhoto
                                        ? Image.file(
                                            File(photoPath),
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.cover,
                                          )
                                        : const Icon(
                                            Icons.person,
                                            size: 40,
                                            color: primaryColor,
                                          ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 14),

                            // User Info Dinamis dari Database
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        currentUser?.name ?? 'Belum Masuk Akun',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1A1B24),
                                        ),
                                      ),
                                      if (currentUser != null) ...[
                                        const SizedBox(width: 4),
                                        Icon(
                                          Icons.verified,
                                          size: 18,
                                          color: primaryColor,
                                        ),
                                      ],
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    currentUser?.email ??
                                        'Silakan masuk ke akun Anda',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFDEE0FF),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      currentUser?.role ?? 'Tamu',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Action Buttons (Edit & Logout/Login)
                        Row(
                          children: [
                            if (currentUser != null) ...[
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () async {
                                    bool? updated = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const EditProfil(),
                                      ),
                                    );
                                    if (updated == true) {
                                      setState(() {});
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.edit_outlined,
                                    size: 16,
                                  ),
                                  label: const Text('Edit Profil'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: primaryColor,
                                    side: BorderSide(
                                      color: primaryColor.withValues(
                                        alpha: 0.5,
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  UserDbHelper.currentUser = null;
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  currentUser != null
                                      ? Icons.logout
                                      : Icons.login,
                                  size: 16,
                                ),
                                label: Text(
                                  currentUser != null
                                      ? 'Keluar'
                                      : 'Masuk / Login',
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    245,
                                    27,
                                    27,
                                  ),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Navigation Tabs (Info Akun, Fitur, Pengaturan)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTab = 0;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _selectedTab == 0
                              ? primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Informasi',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _selectedTab == 0
                                ? Colors.white
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTab = 1;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _selectedTab == 1
                              ? primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Menu Utama',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _selectedTab == 1
                                ? Colors.white
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Tab Content Dinamis
            if (_selectedTab == 0)
              _buildInfoTab(currentUser)
            else
              _buildMenuTab(context),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Widget Tab Informasi Dinamis
  Widget _buildInfoTab(UserModel? user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Rincian Akun Saya',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1B24),
                ),
              ),
              const SizedBox(height: 14),
              _buildInfoRow(
                Icons.email_outlined,
                'Email',
                user?.email ?? 'Belum ada email',
              ),
              const Divider(height: 20),
              _buildInfoRow(
                Icons.phone_outlined,
                'Nomor Telepon',
                user?.phone ?? 'Belum ada nomor telepon',
              ),
              const Divider(height: 20),
              _buildInfoRow(
                Icons.location_on_outlined,
                'Alamat Utama',
                user?.address ?? 'Belum ada alamat',
              ),
              const Divider(height: 20),
              _buildInfoRow(
                Icons.calendar_today_outlined,
                'Status Akun',
                user != null ? 'Terdaftar' : 'Tamu (Belum Login)',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF0025A5), size: 22),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1B24),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget Tab Menu Utama
  Widget _buildMenuTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Column(
          children: [
            _buildMenuItem(
              icon: Icons.receipt_long_outlined,
              title: 'Pesanan Saya',
              subtitle: 'Lihat status pesanan & riwayat transaksi',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PesananSaya()),
                );
              },
            ),
            const Divider(height: 1),
            _buildMenuItem(
              icon: Icons.shopping_cart_outlined,
              title: 'Keranjang Belanja',
              subtitle: 'Daftar produk yang ingin dibeli',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        KeranjangBelanja(keranjang: keranjangBelanjaData),
                  ),
                );
              },
            ),
            const Divider(height: 1),
            _buildMenuItem(
              icon: Icons.favorite_outline,
              title: 'Favorit Saya',
              subtitle: 'Daftar produk yang Anda sukai',
              onTap: () {},
            ),
            const Divider(height: 1),

            _buildMenuItem(
              icon: Icons.info_outline,
              title: 'Info Aplikasi',
              subtitle: 'Informasi versi & tentang aplikasi LocalMart',
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InfoApkPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F2FF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: const Color(0xFF0025A5)),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}
