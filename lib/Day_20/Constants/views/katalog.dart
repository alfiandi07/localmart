import 'package:flutter/material.dart';
import 'package:localmart/Day_20/Constants/database/data_produk.dart';
import 'package:localmart/Day_20/Constants/database/data_produkkeranjang.dart';
import 'package:localmart/Day_20/Constants/views/detail_produk.dart';

class KatalogProduct extends StatefulWidget {
  final String kategori;
  const KatalogProduct({super.key, required this.kategori});

  @override
  State<KatalogProduct> createState() => _KatalogProductState();
}

class _KatalogProductState extends State<KatalogProduct> {
  List<bool> isFavorite = List.generate(4, (index) => false);
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredProducts = [];
  List<Map<String, dynamic>> keranjang = keranjangBelanjaData;

  @override
  void initState() {
    super.initState();

    if (widget.kategori.toLowerCase() == 'semua') {
      filteredProducts = products;
    } else {
      filteredProducts = products.where((product) {
        return product['category'].toString().toLowerCase() ==
            widget.kategori.toLowerCase();
      }).toList();
    }
  }

  final List<Map<String, dynamic>> products = katalogProdukDatabase;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Katalog Produk',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff0025a5),
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  filteredProducts = products.where((product) {
                    final nama = product['name'].toString().toLowerCase();
                    final kategori = product['category']
                        .toString()
                        .toLowerCase();

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
            ),
            SizedBox(height: 10),
            Align(alignment: Alignment.centerLeft),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),

              itemCount: filteredProducts.length,

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.53,
              ),

              itemBuilder: (context, index) {
                final product = filteredProducts[index];

                return GestureDetector(
                  onTap: () {
                    print('Produk: ${product['name']}');
                    print('Toko: ${product['toko']}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailProduk(
                          nama: product['name'] ?? '',
                          toko: product['toko'] ?? '',
                          kategori: product['category'] ?? '',
                          harga: product['price'] ?? '',
                          rating: product['rating'] ?? '',
                          gambar: product['image'] ?? '',
                          deskripsi: product['description'] ?? '',
                          keranjang: keranjang,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // GAMBAR
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),

                          child: Image.asset(
                            product['image'],
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.all(8),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['category'],
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),

                              SizedBox(height: 4),

                              Text(
                                product['name'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(height: 5),

                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 14,
                                  ),

                                  SizedBox(width: 3),

                                  Text(
                                    product['rating'],
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ],
                              ),

                              SizedBox(height: 5),

                              Text(
                                product['price'],
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
