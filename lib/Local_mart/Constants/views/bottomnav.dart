import 'package:flutter/material.dart';
import 'package:localmart/Local_mart/Constants/views/beranda.dart';
import 'package:localmart/Local_mart/Constants/views/katalog.dart';
import 'package:localmart/Local_mart/Constants/views/pesanan_saya.dart';
import 'package:localmart/Local_mart/Constants/views/profil.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;

  final List<Widget> Pages = [
    const Beranda(),
    const KatalogProduct(kategori: 'semua'),
    const PesananSaya(),
    const ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    const Color activeColor = Color(0xFF0025A5);
    final Color inactiveColor =
        isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final Color navBgColor =
        isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return Scaffold(
      body: Pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: navBgColor,
        selectedItemColor: activeColor,
        unselectedItemColor: inactiveColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, color: currentIndex == 0 ? activeColor : inactiveColor),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: currentIndex == 1 ? activeColor : inactiveColor),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined, color: currentIndex == 2 ? activeColor : inactiveColor),
            label: 'Pesanan Saya',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined, color: currentIndex == 3 ? activeColor : inactiveColor),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
