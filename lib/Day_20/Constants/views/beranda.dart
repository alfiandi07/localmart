import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:localmart/Day_20/Constants/database/data_produk.dart';
import 'package:localmart/Day_20/Constants/database/data_produkkeranjang.dart';
import 'package:localmart/Day_20/Constants/views/detail_produk.dart';
import 'package:localmart/Day_20/Constants/views/katalog.dart';
import 'package:localmart/Day_20/Constants/views/keranjang.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Localmart',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff0025a5),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
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
            icon: Icon(Icons.shopping_cart, color: Color(0xff0025a5)),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            height: 1,
            color: const Color.fromARGB(155, 61, 61, 61),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(top: 30, left: 10, right: 10),
        child: Column(
          children: [
            carouselSlider(),
            SizedBox(height: 20),
            pencarianProduk(),
            SizedBox(height: 10),
            bacaanKategori(),
            SizedBox(height: 20),

            kategori(),
            bacaanRekomendasi(),
            SizedBox(
              height: 320,

              child: rekomendasiProduk(), // ListView.builder
            ), // SizedBox
          ],
        ),
      ),
    );
  }

  Align bacaanKategori() => Align(
    alignment: Alignment.centerLeft,
    child: Text(
      'Kategori',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xff0025a5),
      ),
    ),
  );

  TextField pencarianProduk() {
    return TextField(
      controller: searchController,
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
        prefixIcon: Icon(Icons.search),
        filled: true,
        fillColor: Color(0xfff4f2ff),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15),
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

  Row bacaanRekomendasi() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Rekomendasi Produk',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff0025a5),
              ),
            ),
          ],
        ),
      ],
    );
  }

  ListView rekomendasiProduk() {
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
            margin: EdgeInsets.only(right: 10),

            child: Card(
              elevation: 2,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ), // RoundedRectangleBorder

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(8),
                        ),
                        child: Image.asset(
                          product['image'],
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ), // ClipRRect
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
                              color: isFavorite[index] ? Colors.red : Colors.grey,
                            ),
                          ),
                        ), // Container
                      ), // Positioned
                    ],
                  ), // Stack
                  Padding(
                    padding: const EdgeInsets.all(7),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        // Kategori pada kartu produk
                        Text(
                          product['category'],
                          style: TextStyle(color: Colors.blue, fontSize: 10),
                        ),

                        SizedBox(height: 4),
                        // Nama Produk di bawah ini
                        Text(
                          product['name'],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 4),

                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.orange, size: 13),

                            SizedBox(width: 2),
                            // Rating Untuk Kartu Produk
                            Text(
                              product['rating'],
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ), // Row

                        SizedBox(height: 5),
                        // Harga Untuk Kartu Produk
                        Text(
                          product['price'],

                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ), // Column informasi
                  ), // Padding
                ],
              ), // Column
            ), // Card
          ),
        ); // Container
      },
    );
  }

  // Kategori
  GridView kategori() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      //jumlah kotak dalam satu baris
      itemCount: 8,

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  categories[index]['icon'] as IconData,
                  size: 30,
                  color: Color(0xff0025a5),
                ),
                SizedBox(height: 8),
                Text(
                  categories[index]['name'] as String,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
