import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:localmart/Local_mart/Constants/database/data_produk.dart';
import 'package:localmart/Local_mart/Constants/database/data_produkkeranjang.dart';
import 'package:localmart/Local_mart/Constants/views/detail_produk.dart';
import 'package:localmart/Local_mart/Constants/views/katalog.dart';
import 'package:localmart/Local_mart/Constants/views/keranjang.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  List<bool> isFavorite = List.generate(4, (index) => false);
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredProducts = [];

  @override
  void initState() {
    super.initState();

    filteredProducts = products;
  }

  final List<Map<String, dynamic>> products = katalogProdukDatabase;
  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    const Color primaryColor = Color(0xFF0025A5);
    final Color appBarBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Localmart',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: primaryColor,
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
            height: 1,
            color: isDark
                ? Colors.grey.shade800
                : const Color.fromARGB(155, 61, 61, 61),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
        child: Column(
          children: [
            carouselSlider(),
            const SizedBox(height: 20),
            pencarianProduk(isDark, primaryColor),
            const SizedBox(height: 10),
            bacaanKategori(primaryColor),
            const SizedBox(height: 20),
            kategori(isDark, primaryColor),
            bacaanRekomendasi(primaryColor),
            SizedBox(
              height: 320,
              child: rekomendasiProduk(isDark, primaryColor),
            ),
          ],
        ),
      ),
    );
  }

  Align bacaanKategori(Color primaryColor) => Align(
    alignment: Alignment.centerLeft,
    child: Text(
      'Kategori',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
    ),
  );

  TextField pencarianProduk(bool isDark, Color primaryColor) {
    return TextField(
      controller: searchController,
      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
      onChanged: (value) {
        setState(() {
          filteredProducts = products.where((product) {
            final nama = product['name'].toString().toLowerCase();
            final kategori = product['category'].toString().toLowerCase();

            return nama.contains(value.toLowerCase()) ||
                kategori.contains(value.toLowerCase());
          }).toList();
        });
      },
      decoration: InputDecoration(
        hintText: 'Cari produk LocalMart',
        hintStyle: TextStyle(
          color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
        ),
        prefixIcon: Icon(Icons.search, color: primaryColor),
        filled: true,
        fillColor: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF4F2FF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
      ),
    );
  }

  CarouselSlider carouselSlider() {
    return CarouselSlider(
      items: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/images/Jamtanganpria.jpg',
            width: double.infinity,
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/images/sepatuadidas.jpg',
            width: double.infinity,
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/images/Samsung s24.jpg',
            width: double.infinity,
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
      ],
      options: CarouselOptions(
        height: 180.0,
        aspectRatio: 16 / 9,
        autoPlay: true,
        viewportFraction: 0.9,
        enlargeCenterPage: true,
        autoPlayInterval: const Duration(seconds: 3),
      ),
    );
  }

  Row bacaanRekomendasi(Color primaryColor) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Rekomendasi Produk',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  ListView rekomendasiProduk(bool isDark, Color primaryColor) {
    final Color cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final Color textColor = isDark ? Colors.white : Colors.black87;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailProduk(
                  nama: product['name'] ?? '',
                  toko: product['toko'] ?? 'LocalMart Store',
                  kategori: product['category'] ?? '',
                  harga: product['price'] ?? '',
                  rating: product['rating'] ?? '',
                  gambar: product['image'] ?? '',
                  deskripsi: product['description'] ?? 'Deskripsi produk.',
                  keranjang: keranjangBelanjaData,
                ),
              ),
            );
          },
          child: Container(
            width: 150,
            margin: const EdgeInsets.only(right: 10),
            child: Card(
              elevation: isDark ? 1 : 2,
              color: cardBg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(8),
                        ),
                        child: Image.asset(
                          product['image'],
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: Container(
                          width: 30,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                isFavorite[index] = !isFavorite[index];
                              });
                            },
                            icon: Icon(
                              isFavorite[index]
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite[index]
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['category'],
                          style: TextStyle(color: primaryColor, fontSize: 10),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product['name'],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 13,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              product['rating'],
                              style: TextStyle(fontSize: 10, color: textColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          product['price'],
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Kategori
  GridView kategori(bool isDark, Color primaryColor) {
    final Color cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final Color textColor = isDark ? Colors.white : Colors.black87;
    final Color shadowColor = isDark ? Colors.black45 : Colors.grey.shade300;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 8,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final categories = [
          {'icon': Icons.checkroom, 'name': 'fashion'},
          {'icon': Icons.face, 'name': 'ibu & Bayi'},
          {'icon': Icons.phone_android, 'name': 'Elektronik'},
          {'icon': Icons.watch, 'name': 'Aksesoris'},
          {'icon': Icons.sports_baseball, 'name': 'Olahraga'},
          {'icon': Icons.camera_alt_outlined, 'name': 'Fotografi'},
          {'icon': Icons.games, 'name': 'hobi & game'},
          {'icon': Icons.all_inclusive_outlined, 'name': 'Semua'},
        ];

        return InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => KatalogProduct(
                  kategori: categories[index]['name'].toString(),
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: 5,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  categories[index]['icon'] as IconData,
                  size: 30,
                  color: primaryColor,
                ),
                const SizedBox(height: 8),
                Text(
                  categories[index]['name'] as String,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
