import 'package:flutter/material.dart';
import 'package:localmart/Day_20/Constants/views/beranda.dart';
import 'package:localmart/Day_20/Constants/views/katalog.dart';
import 'package:localmart/Day_20/Constants/views/pesanan_saya.dart';
import 'package:localmart/Day_20/Constants/views/profil.dart';

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

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, color: Color(0xff0025a5)),
            label: 'Beranda',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Color(0xff0025a5)),
            label: 'Search',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined, color: Color(0xff0025a5)),
            label: 'Pesanan Saya',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined, color: Color(0xff0025a5)),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
