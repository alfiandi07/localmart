import 'package:flutter/material.dart';
import 'package:localmart/Day_20/Constants/database/data_produkkeranjang.dart';
import 'package:localmart/Day_20/Constants/views/keranjang.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pesanan Saya',
          style: TextStyle(
            color: Color(0xff364cb2),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KeranjangBelanja(keranjang: keranjangBelanjaData),
                ),
              );
            },
            icon: Icon(Icons.shopping_cart, color: Color(0xff364cb2)),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(height: 2, color: Color(0xfff4f2ff)),
        ),
      ),
      body: Column(
        children: [
          Container(height: 1, color: Color(0xfff6f3f2)),
          SizedBox(
            height: 65,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 14),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: selectedIndex == 0
                            ? Color(0xff364cb2)
                            : const Color.fromARGB(10, 5, 0, 0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Belum Dibayar',
                        style: TextStyle(
                          color: selectedIndex == 0
                              ? Colors.white
                              : Colors.black,
                          fontSize: 11,
                          fontWeight: selectedIndex == 0
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: selectedIndex == 1
                            ? Color(0xff364cb2)
                            : const Color.fromARGB(10, 5, 0, 0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Diproses',
                        style: TextStyle(
                          color: selectedIndex == 1
                              ? Colors.white
                              : Colors.black,
                          fontSize: 11,
                          fontWeight: selectedIndex == 1
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 2;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: selectedIndex == 2
                            ? Color(0xff364cb2)
                            : const Color.fromARGB(10, 5, 0, 0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Dikirim',
                        style: TextStyle(
                          color: selectedIndex == 2
                              ? Colors.white
                              : Colors.black,
                          fontSize: 11,
                          fontWeight: selectedIndex == 2
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 3;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: selectedIndex == 3
                            ? Color(0xff364cb2)
                            : const Color.fromARGB(10, 5, 0, 0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Selesai',
                        style: TextStyle(
                          color: selectedIndex == 3
                              ? Colors.white
                              : Colors.black,
                          fontSize: 11,
                          fontWeight: selectedIndex == 3
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 4;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: selectedIndex == 4
                            ? Color(0xff364cb2)
                            : const Color.fromARGB(10, 5, 0, 0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Dibatalkan',
                        style: TextStyle(
                          color: selectedIndex == 4
                              ? Colors.white
                              : Colors.black,
                          fontSize: 11,
                          fontWeight: selectedIndex == 4
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: pesanan.isEmpty
                ? Center(
                    child: Text(
                      'Belum ada pesanan yang di buat, silahkan belanja terlebih dahulu',
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(pesanan[index]['nama']),
                          subtitle: Text(pesanan[index]['harga']),
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
