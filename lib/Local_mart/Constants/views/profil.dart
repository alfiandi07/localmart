import 'dart:io';
import 'package:flutter/material.dart';
import 'package:localmart/Local_mart/Constants/database/data_produkkeranjang.dart';
import 'package:localmart/Local_mart/Constants/database/db_helper_user.dart';
import 'package:localmart/Local_mart/Constants/models/user_model.dart';
import 'package:localmart/Local_mart/Constants/views/edit_profil.dart';
import 'package:localmart/Local_mart/Constants/views/ganti_kata_sandi.dart';
import 'package:localmart/Local_mart/Constants/views/info_apk.dart';
import 'package:localmart/Local_mart/Constants/views/keranjang.dart';
import 'package:localmart/Local_mart/Constants/views/login.dart';
import 'package:localmart/Local_mart/Constants/views/pesanan_saya.dart';
import 'package:localmart/Local_mart/Constants/database/db_helper_store.dart';
import 'package:localmart/Local_mart/Constants/views/store/daftar_toko.dart';
import 'package:localmart/Local_mart/Constants/views/store/kelola_toko.dart';
import 'package:localmart/main.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _checkUserStore();
  }

  Future<void> _checkUserStore() async {
    final currentUser = UserDbHelper.currentUser;
    if (currentUser != null) {
      await StoreDbHelper.getStoreByUserId(currentUser.id);
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    const Color primaryColor = Color(0xFF0025A5);
    final Color backgroundColor =
        isDark ? const Color(0xFF121212) : const Color.fromARGB(255, 249, 250, 250);
    final Color cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final Color textColor = isDark ? Colors.white : const Color(0xFF1A1B24);
    final Color subtextColor =
        isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    // Ambil data user aktif dari database (null jika belum login)
    final UserModel? currentUser = UserDbHelper.currentUser;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Profil Saya',
          style: TextStyle(
            color: primaryColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: cardBg,
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
                      color: cardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isDark ? Colors.black38 : const Color(0x0F002892),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
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
                                        : Icon(
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
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: textColor,
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
                                      color: subtextColor,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isDark ? const Color(0xFF2A2A3D) : const Color(0xFFDEE0FF),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      currentUser?.role ?? 'Tamu',
                                      style: TextStyle(
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

                        // Action Buttons (Edit Profil & Pengaturan)
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
                            // Tombol Pengaturan menggantikan posisi tombol keluar
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  _showPengaturanBottomSheet(
                                    context,
                                    currentUser,
                                  );
                                },
                                icon: const Icon(
                                  Icons.settings_outlined,
                                  size: 16,
                                ),
                                label: const Text('Pengaturan'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
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
            const SizedBox(height: 14),

            // -----------------------------------------------------------------
            // Card Status Toko Penjual / Banner Pendaftaran Toko
            // -----------------------------------------------------------------
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: isDark ? 1 : 2,
                color: cardBg,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: BorderSide(
                    color: primaryColor.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF2A2A3D)
                              : const Color(0xFFDEE0FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.storefront_rounded,
                          color: primaryColor,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              StoreDbHelper.currentStore != null
                                  ? StoreDbHelper.currentStore!.storeName
                                  : 'Buka Toko Gratis',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              StoreDbHelper.currentStore != null
                                  ? 'Kelola produk & pesanan toko Anda'
                                  : 'Mulai jualan produk Anda di LocalMart',
                              style: TextStyle(
                                fontSize: 12,
                                color: subtextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (currentUser == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Silakan login terlebih dahulu.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                          if (StoreDbHelper.currentStore != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => KelolaTokoPage(
                                  store: StoreDbHelper.currentStore!,
                                ),
                              ),
                            );
                          } else {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DaftarTokoPage(),
                              ),
                            );
                            setState(() {});
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          StoreDbHelper.currentStore != null
                              ? 'Toko Saya'
                              : 'Daftar',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Navigation Tabs (Info Akun, Fitur, Pengaturan)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                ),
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
                                : subtextColor,
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
                                : subtextColor,
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
              _buildInfoTab(currentUser, isDark, cardBg, textColor, subtextColor, primaryColor)
            else
              _buildMenuTab(context, isDark, cardBg, textColor, subtextColor, primaryColor),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Widget Tab Informasi Dinamis
  Widget _buildInfoTab(
    UserModel? user,
    bool isDark,
    Color cardBg,
    Color textColor,
    Color subtextColor,
    Color primaryColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: isDark ? 1 : 1,
        color: cardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rincian Akun Saya',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 14),
              _buildInfoRow(
                Icons.email_outlined,
                'Email',
                user?.email ?? 'Belum ada email',
                primaryColor,
                textColor,
                subtextColor,
              ),
              const Divider(height: 20),
              _buildInfoRow(
                Icons.phone_outlined,
                'Nomor Telepon',
                user?.phone ?? 'Belum ada nomor telepon',
                primaryColor,
                textColor,
                subtextColor,
              ),
              const Divider(height: 20),
              _buildInfoRow(
                Icons.location_on_outlined,
                'Alamat Utama',
                user?.address ?? 'Belum ada alamat',
                primaryColor,
                textColor,
                subtextColor,
              ),
              const Divider(height: 20),
              _buildInfoRow(
                Icons.calendar_today_outlined,
                'Status Akun',
                user != null ? 'Terdaftar' : 'Tamu (Belum Login)',
                primaryColor,
                textColor,
                subtextColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value,
    Color primaryColor,
    Color textColor,
    Color subtextColor,
  ) {
    return Row(
      children: [
        Icon(icon, color: primaryColor, size: 22),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: subtextColor),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget Tab Menu Utama
  Widget _buildMenuTab(
    BuildContext context,
    bool isDark,
    Color cardBg,
    Color textColor,
    Color subtextColor,
    Color primaryColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: isDark ? 1 : 1,
        color: cardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Column(
          children: [
            _buildMenuItem(
              icon: Icons.receipt_long_outlined,
              title: 'Pesanan Saya',
              subtitle: 'Lihat status pesanan & riwayat transaksi',
              isDark: isDark,
              textColor: textColor,
              subtextColor: subtextColor,
              primaryColor: primaryColor,
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
              isDark: isDark,
              textColor: textColor,
              subtextColor: subtextColor,
              primaryColor: primaryColor,
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
              isDark: isDark,
              textColor: textColor,
              subtextColor: subtextColor,
              primaryColor: primaryColor,
              onTap: () {},
            ),
            const Divider(height: 1),
            _buildMenuItem(
              icon: Icons.settings_outlined,
              title: 'Pengaturan Aplikasi',
              subtitle: 'Notifikasi, tema, bahasa & akun',
              isDark: isDark,
              textColor: textColor,
              subtextColor: subtextColor,
              primaryColor: primaryColor,
              onTap: () {
                _showPengaturanBottomSheet(context);
              },
            ),
            const Divider(height: 1),
            _buildMenuItem(
              icon: Icons.info_outline,
              title: 'Info Aplikasi',
              subtitle: 'Informasi versi & tentang aplikasi LocalMart',
              isDark: isDark,
              textColor: textColor,
              subtextColor: subtextColor,
              primaryColor: primaryColor,
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
    required bool isDark,
    required Color textColor,
    required Color subtextColor,
    required Color primaryColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF4F2FF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: primaryColor),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: textColor,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 12, color: subtextColor),
      ),
      trailing: Icon(Icons.chevron_right, color: subtextColor),
      onTap: onTap,
    );
  }

  void _showPengaturanBottomSheet(BuildContext context, [UserModel? user]) {
    bool notifikasi = true;
    final UserModel? currentUser = user ?? UserDbHelper.currentUser;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final bool isDark =
                MyApp.themeNotifier.value == ThemeMode.dark;
            const Color primaryColor = Color(0xFF0025A5);
            final Color cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
            final Color textColor = isDark ? Colors.white : const Color(0xFF1A1B24);
            final Color subtextColor =
                isDark ? Colors.grey.shade400 : Colors.grey.shade600;
            final Color iconColor = isDark ? primaryColor : primaryColor;

            return Container(
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.grey.shade700
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.settings, color: primaryColor),
                      const SizedBox(width: 10),
                      Text(
                        'Pengaturan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Divider(color: isDark ? Colors.grey.shade800 : Colors.grey.shade300),
                  SwitchListTile(
                    title: Text(
                      'Notifikasi Aplikasi',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    subtitle: Text(
                      'Dapatkan info promo & pesanan terbaru',
                      style: TextStyle(color: subtextColor),
                    ),
                    secondary: Icon(
                      Icons.notifications_outlined,
                      color: iconColor,
                    ),
                    value: notifikasi,
                    activeThumbColor: primaryColor,
                    onChanged: (val) {
                      setModalState(() {
                        notifikasi = val;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text(
                      'Mode Gelap',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    subtitle: Text(
                      'Aktifkan tampilan tema gelap',
                      style: TextStyle(color: subtextColor),
                    ),
                    secondary: Icon(
                      Icons.dark_mode_outlined,
                      color: iconColor,
                    ),
                    value: isDark,
                    activeThumbColor: primaryColor,
                    onChanged: (val) {
                      setModalState(() {
                        MyApp.themeNotifier.value =
                            val ? ThemeMode.dark : ThemeMode.light;
                      });
                      setState(() {});
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.language_outlined,
                      color: iconColor,
                    ),
                    title: Text(
                      'Bahasa Aplikasi',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    subtitle: Text(
                      'Bahasa Indonesia',
                      style: TextStyle(color: subtextColor),
                    ),
                    trailing: Icon(Icons.chevron_right, color: subtextColor),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.lock_outline,
                      color: iconColor,
                    ),
                    title: Text(
                      'Keamanan & Kata Sandi',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    subtitle: Text(
                      'Kelola kata sandi akun Anda',
                      style: TextStyle(color: subtextColor),
                    ),
                    trailing: Icon(Icons.chevron_right, color: subtextColor),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GantiKataSandiPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      currentUser != null ? Icons.logout : Icons.login,
                      color: currentUser != null
                          ? const Color.fromARGB(255, 245, 27, 27)
                          : primaryColor,
                    ),
                    title: Text(
                      currentUser != null ? 'Keluar' : 'Masuk / Login',
                      style: TextStyle(
                        color: currentUser != null
                            ? const Color.fromARGB(255, 245, 27, 27)
                            : primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      currentUser != null
                          ? 'Keluar dari akun Anda'
                          : 'Masuk ke akun Anda',
                      style: TextStyle(color: subtextColor),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: currentUser != null
                          ? const Color.fromARGB(255, 245, 27, 27)
                          : subtextColor,
                    ),
                    onTap: () {
                      if (currentUser != null) {
                        _showKonfirmasiKeluarDialog(context);
                      } else {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showKonfirmasiKeluarDialog(BuildContext context) {
    final bool isDark = MyApp.themeNotifier.value == ThemeMode.dark;
    final Color cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final Color textColor = isDark ? Colors.white : const Color(0xFF1A1B24);
    final Color subtextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: cardBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Konfirmasi',
            style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
          ),
          content: Text(
            'Anda yakin ingin keluar?',
            style: TextStyle(color: subtextColor),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text('Batal', style: TextStyle(color: subtextColor)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.pop(context);
                UserDbHelper.currentUser = null;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 245, 27, 27),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Iya'),
            ),
          ],
        );
      },
    );
  }
}
