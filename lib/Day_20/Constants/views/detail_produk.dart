import 'package:flutter/material.dart';
import 'package:localmart/Day_20/Constants/views/keranjang.dart';

class DetailProduk extends StatefulWidget {
  final String nama;
  final String toko;
  final String kategori;
  final String harga;
  final String rating;
  final String gambar;
  final String deskripsi;

  final List<Map<String, dynamic>> keranjang;

  const DetailProduk({
    super.key,
    required this.nama,
    required this.toko,
    required this.kategori,
    required this.harga,
    required this.gambar,
    required this.deskripsi,
    required this.rating,
    required this.keranjang,
  });

  @override
  State<DetailProduk> createState() => _DetailProdukState();
}

class _DetailProdukState extends State<DetailProduk> {
  int quantity = 1;

  void tambahKeKeranjang() {
    int indexProduk = widget.keranjang.indexWhere(
      (item) => item['name'] == widget.nama,
    );
    if (indexProduk != -1) {
      widget.keranjang[indexProduk]['quantity'] =
          (widget.keranjang[indexProduk]['quantity'] ?? 1) + quantity;
    } else {
      widget.keranjang.add({
        'image': widget.gambar,
        'category': widget.kategori,
        'name': widget.nama,
        'price': widget.harga,
        'quantity': quantity,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LocalMart', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Color(0xff364cb2),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              widget.gambar,
              width: double.infinity,
              height: 350,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.kategori,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),

                  SizedBox(height: 5),

                  Text(
                    widget.nama,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade200,
                          ),
                          child: Icon(Icons.store, color: Colors.blue),
                        ),

                        SizedBox(width: 10),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.toko,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                        Spacer(),

                        OutlinedButton(
                          onPressed: () {},
                          child: Text('Kunjungi Toko'),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 8),
                  Text(
                    widget.harga,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff364cb2),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 18),
                      Text(
                        widget.rating,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff364cb2),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  Text(
                    'Deskripsi Produk',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 5),

                  Text(widget.deskripsi, style: TextStyle(fontSize: 14)),
                  SizedBox(height: 5),

                  SizedBox(height: 100),
                  Row(
                    children: [
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (quantity > 1) {
                                  setState(() {
                                    quantity--;
                                  });
                                }
                              },
                              icon: Icon(Icons.remove),
                            ),
                            Text(
                              '$quantity',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: () {
                                if (quantity < 10) {
                                  setState(() {
                                    quantity++;
                                  });
                                }
                              },
                              icon: Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          tambahKeKeranjang();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  KeranjangBelanja(keranjang: widget.keranjang),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Color(0xff0025a5),
                          elevation: 0,
                          side: BorderSide(color: Color(0xff0025a5)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text('Beli'),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          tambahKeKeranjang();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  KeranjangBelanja(keranjang: widget.keranjang),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(50, 40),
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          backgroundColor: Color(0xff0025a5),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Icon(Icons.shopping_cart),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
