import 'package:flutter/material.dart';
import 'package:localmart/Local_mart/Constants/widgets/localmart_logo.dart';

/// Halaman Informasi Aplikasi LocalMart (About LocalMart)
/// Dapat dipanggil / dipush langsung dari menu Profil.
class InfoApkPage extends StatelessWidget {
  const InfoApkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    const Color primaryColor = Color(0xFF0025A5);
    const Color secondaryColor = Color(0xFF354184);
    final Color backgroundColor = isDark
        ? const Color(0xFF121212)
        : const Color(0xFFFCF9F8);
    final Color cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final Color textColor = isDark ? Colors.white : const Color(0xFF1A1B24);
    final Color subtextColor = isDark
        ? Colors.grey.shade400
        : Colors.grey.shade600;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Tentang LocalMart',
          style: TextStyle(
            color: primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: cardBg,
        elevation: 0.5,
        iconTheme: IconThemeData(color: primaryColor),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // -----------------------------------------------------------------
            // 1. Header Banner & Logo App
            // -----------------------------------------------------------------
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  height: 160,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF0025A5), secondaryColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                Positioned(
                  top: 85,
                  child: LocalMartLogoWidget(
                    size: 96,
                    backgroundColor: primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 55),

            // App Name, Tagline & Version Badge
            Text(
              'LocalMart',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: textColor,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Pasar Lokal dalam Genggaman Anda',
              style: TextStyle(
                fontSize: 14,
                color: subtextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF2A2A3D)
                    : const Color(0xFFDEE0FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.verified_rounded, size: 15, color: primaryColor),
                  const SizedBox(width: 6),
                  Text(
                    'Versi 1.0.0 (Terbaru)',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // -----------------------------------------------------------------
            // 2. Deskripsi & Visi Misi Card
            // -----------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: isDark ? 1 : 1,
                color: cardBg,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline_rounded, color: primaryColor),
                          const SizedBox(width: 10),
                          Text(
                            'Tentang Aplikasi',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'LocalMart adalah platform e-commerce lokal yang membantu para pedagang pasar dan pelaku UMKM untuk mendapatkan pasar yang lebih luas dan pelanggan yang berpotensial. Kami berkomitmen menyajikan pengalaman belanja produk yang berkualitas dan terpercaya.',
                        style: TextStyle(
                          fontSize: 13,
                          color: subtextColor,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // -----------------------------------------------------------------
            // 3. Fitur Unggulan (Grid 2x2)
            // -----------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 10),
                    child: Text(
                      'Keunggulan LocalMart',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildFeatureCard(
                          icon: Icons.local_shipping_outlined,
                          title: 'Pengiriman Cepat',
                          subtitle: 'Pesanan diantar langsung ke rumah Anda',
                          primaryColor: primaryColor,
                          isDark: isDark,
                          cardBg: cardBg,
                          textColor: textColor,
                          subtextColor: subtextColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildFeatureCard(
                          icon: Icons.shield_outlined,
                          title: 'Berkualitas',
                          subtitle: 'Produk lokal berkualitas ',
                          primaryColor: primaryColor,
                          isDark: isDark,
                          cardBg: cardBg,
                          textColor: textColor,
                          subtextColor: subtextColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildFeatureCard(
                          icon: Icons.price_check_outlined,
                          title: 'Harga Murah',
                          subtitle: 'Langsung dari tangan pertama UMKM',
                          primaryColor: primaryColor,
                          isDark: isDark,
                          cardBg: cardBg,
                          textColor: textColor,
                          subtextColor: subtextColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildFeatureCard(
                          icon: Icons.headset_mic_outlined,
                          title: 'Layanan 24/7',
                          subtitle: 'Tim dukungan siap melayani Anda',
                          primaryColor: primaryColor,
                          isDark: isDark,
                          cardBg: cardBg,
                          textColor: textColor,
                          subtextColor: subtextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const SizedBox(height: 20),
            Text(
              'Dibuat dengan bangga untuk UMKM Indonesia',
              style: TextStyle(
                fontSize: 12,
                color: subtextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '© 2026 LocalMart Indonesia. All Rights Reserved.',
              style: TextStyle(
                fontSize: 11,
                color: isDark ? Colors.grey.shade500 : Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Helper Widget Feature Card
  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color primaryColor,
    required bool isDark,
    required Color cardBg,
    required Color textColor,
    required Color subtextColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : const Color(0x05002892),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF4F2FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: primaryColor, size: 22),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(fontSize: 11, color: subtextColor, height: 1.3),
          ),
        ],
      ),
    );
  }
}

/// Alias class name jika dipanggil sebagai `AboutLocalMartPage`
class AboutLocalMartPage extends InfoApkPage {
  const AboutLocalMartPage({super.key});
}
