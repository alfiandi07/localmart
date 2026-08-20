import 'package:flutter/material.dart';
import 'package:localmart/Day_20/Constants/widgets/localmart_logo.dart';

/// Halaman Informasi Aplikasi LocalMart (About LocalMart)
/// Dapat dipanggil / dipush langsung dari menu Profil.
class InfoApkPage extends StatelessWidget {
  const InfoApkPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF0025A5);
    const Color secondaryColor = Color(0xFF354184);
    const Color backgroundColor = Color(0xFFFCF9F8);
    const Color textColor = Color(0xFF1A1B24);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Tentang LocalMart',
          style: TextStyle(
            color: primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: primaryColor),
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
                      colors: [primaryColor, secondaryColor],
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
            const Text(
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
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFDEE0FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.verified_rounded, size: 15, color: primaryColor),
                  SizedBox(width: 6),
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
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.info_outline_rounded, color: primaryColor),
                          SizedBox(width: 10),
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
                          color: Colors.grey.shade700,
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
                  const Padding(
                    padding: EdgeInsets.only(left: 4, bottom: 10),
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
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildFeatureCard(
                          icon: Icons.shield_outlined,
                          title: 'Berkualitas',
                          subtitle: 'Produk lokal berkualitas ',
                          primaryColor: primaryColor,
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
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildFeatureCard(
                          icon: Icons.headset_mic_outlined,
                          title: 'Layanan 24/7',
                          subtitle: 'Tim dukungan siap melayani Anda',
                          primaryColor: primaryColor,
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
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '© 2026 LocalMart Indonesia. All Rights Reserved.',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
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
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05002892),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F2FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: primaryColor, size: 22),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xFF1A1B24),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
              height: 1.3,
            ),
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
