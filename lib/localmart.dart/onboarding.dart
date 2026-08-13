import 'package:flutter/material.dart';
import 'package:localmart/localmart.dart/login.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingItem> _items = [
    OnboardingItem(
      title: 'Dukung ',
      highlightedTitle: 'Produk Lokal',
      description:
          'Jelajahi berbagai produk terbaik dari UMKM Indonesia dengan satu genggaman.',
      imagePath: 'assets/images/onboarding1.png',
      badgeIcon1: Icons.eco,
      badgeColor1: const Color(0xFF1B5E20),
      badgeBg1: const Color(0xFFE8F5E9),
      badgeIcon2: Icons.local_mall,
      badgeColor2: const Color(0xFF0025A5),
      badgeBg2: Colors.white,
      accentColor: const Color(0xFF1B5E20),
      isGreenTheme: true,
    ),
    OnboardingItem(
      title: 'Transaksi Aman ',
      highlightedTitle: '& Mudah',
      description:
          'Keamanan transaksi terjamin dengan berbagai pilihan metode pembayaran yang praktis. Nikmati kemudahan berbelanja tanpa rasa khawatir.',
      imagePath: 'assets/images/onboarding2.png',
      accentColor: const Color(0xFF0025A5),
      isGreenTheme: false,
    ),
    OnboardingItem(
      title: 'Pengiriman ',
      highlightedTitle: 'Cepat',
      description:
          'Temukan toko terdekat dan nikmati pengiriman instan langsung ke lokasi Anda. Kami memastikan kesegaran produk terjaga hingga ke tangan Anda.',
      imagePath: 'assets/images/onboarding3.png',
      badgeIcon1: Icons.electric_moped,
      badgeColor1: const Color(0xFF0025A5),
      badgeBg1: const Color(0xFFEEECF9),
      badgeLabel: 'Menuju Lokasi',
      accentColor: const Color(0xFF0025A5),
      isGreenTheme: false,
    ),
  ];

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HalamanLogin()),
    );
  }

  void _nextPage() {
    if (_currentPage < _items.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _navigateToLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = _items[_currentPage];

    return Scaffold(
      backgroundColor: const Color(0xFFFCF9F8),
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation (Header)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Brand Title
                  Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0025A5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.shopping_bag_outlined,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'LocalMart',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0025A5),
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                  // Skip Button
                  TextButton(
                    onPressed: _navigateToLogin,
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF444655),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Lewati',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Page View Content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _items.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildPage(_items[index]);
                },
              ),
            ),

            // Bottom Section (Card + Controls)
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36),
                  topRight: Radius.circular(36),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                    blurRadius: 30,
                    offset: Offset(0, -10),
                  ),
                ],
              ),
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Pagination Indicators (Dots)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _items.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 7,
                        width: _currentPage == index ? 28 : 7,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? currentItem.accentColor
                              : const Color(0xFFE2E1EE),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Title Text
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1B24),
                        height: 1.25,
                      ),
                      children: [
                        TextSpan(text: currentItem.title),
                        TextSpan(
                          text: currentItem.highlightedTitle,
                          style: TextStyle(color: currentItem.accentColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Subtitle / Description Text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      currentItem.description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF444655),
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: currentItem.accentColor,
                        foregroundColor: Colors.white,
                        elevation: 4,
                        shadowColor: currentItem.accentColor.withAlpha(80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _currentPage == _items.length - 1
                                ? 'Mulai Sekarang'
                                : 'Selanjutnya',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.2,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_rounded, size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background Ambient Glow
            Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                color: item.accentColor.withAlpha(20),
                shape: BoxShape.circle,
              ),
            ),

            // Main Image Container
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(20),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  item.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFEEECF9),
                      child: Icon(
                        Icons.image,
                        size: 64,
                        color: item.accentColor,
                      ),
                    );
                  },
                ),
              ),
            ),

            // Badge 1 (e.g. Eco icon or Moped badge)
            if (item.badgeIcon1 != null)
              Positioned(
                top: 10,
                right: 15,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: item.badgeBg1 ?? Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(25),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    item.badgeIcon1,
                    color: item.badgeColor1,
                    size: 24,
                  ),
                ),
              ),

            // Badge 2 (e.g. Shopping Mall icon)
            if (item.badgeIcon2 != null)
              Positioned(
                bottom: 20,
                left: 15,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: item.badgeBg2 ?? Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(25),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    item.badgeIcon2,
                    color: item.badgeColor2,
                    size: 24,
                  ),
                ),
              ),

            // Badge Label (e.g. "Status: Menuju Lokasi" on slide 3)
            if (item.badgeLabel != null)
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(30),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.electric_moped,
                        color: item.accentColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'STATUS',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade600,
                              letterSpacing: 1.0,
                            ),
                          ),
                          Text(
                            item.badgeLabel!,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: item.accentColor,
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
      ),
    );
  }
}

class OnboardingItem {
  final String title;
  final String highlightedTitle;
  final String description;
  final String imagePath;
  final IconData? badgeIcon1;
  final Color? badgeColor1;
  final Color? badgeBg1;
  final IconData? badgeIcon2;
  final Color? badgeColor2;
  final Color? badgeBg2;
  final String? badgeLabel;
  final Color accentColor;
  final bool isGreenTheme;

  OnboardingItem({
    required this.title,
    required this.highlightedTitle,
    required this.description,
    required this.imagePath,
    this.badgeIcon1,
    this.badgeColor1,
    this.badgeBg1,
    this.badgeIcon2,
    this.badgeColor2,
    this.badgeBg2,
    this.badgeLabel,
    required this.accentColor,
    required this.isGreenTheme,
  });
}
