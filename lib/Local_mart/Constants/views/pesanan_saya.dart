import 'package:flutter/material.dart';
import 'package:localmart/Local_mart/Constants/database/data_produkkeranjang.dart';
import 'package:localmart/Local_mart/Constants/views/keranjang.dart';

class PesananSaya extends StatefulWidget {
  const PesananSaya({super.key});

  @override
  State<PesananSaya> createState() => _PesananSayaState();
}

class _PesananSayaState extends State<PesananSaya> {
  int selectedIndex = 1;

  final List<String> statusPesanan = [
    'Belum Dibayar',
    'Diproses',
    'Dikirim',
    'Selesai',
    'Dibatalkan',
  ];

  List<Map<String, dynamic>> pesanan = [];
  @override
  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    const Color primaryColor = Color(0xFF364CB2);
    final Color appBarBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final Color unselectedChipBg = isDark
        ? const Color(0xFF1E1E1E)
        : const Color.fromARGB(10, 5, 0, 0);
    final Color unselectedTextColor = isDark ? Colors.white70 : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pesanan Saya',
          style: TextStyle(
            color: primaryColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: appBarBg,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      KeranjangBelanja(keranjang: keranjangBelanjaData),
                ),
              );
            },
            icon: Icon(Icons.shopping_cart, color: primaryColor),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 2,
            color: isDark ? Colors.grey.shade800 : const Color(0xfff4f2ff),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 1,
            color: isDark ? Colors.grey.shade800 : const Color(0xfff6f3f2),
          ),
          SizedBox(
            height: 65,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 14),
                  for (int i = 0; i < statusPesanan.length; i++) ...[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = i;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          color: selectedIndex == i
                              ? primaryColor
                              : unselectedChipBg,
                          borderRadius: BorderRadius.circular(10),
                          border: isDark && selectedIndex != i
                              ? Border.all(color: Colors.grey.shade800)
                              : null,
                        ),
                        child: Text(
                          statusPesanan[i],
                          style: TextStyle(
                            color: selectedIndex == i
                                ? Colors.white
                                : unselectedTextColor,
                            fontSize: 11,
                            fontWeight: selectedIndex == i
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Expanded(
            child: pesanan.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        'Belum ada pesanan yang dibuat, silakan belanja terlebih dahulu',
                        style: TextStyle(
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: pesanan.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        child: ListTile(
                          title: Text(
                            pesanan[index]['nama'],
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          subtitle: Text(
                            pesanan[index]['harga'],
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
