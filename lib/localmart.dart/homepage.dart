import 'package:flutter/material.dart';
import 'package:localmart/localmart.dart/auth_service.dart';
import 'package:localmart/localmart.dart/detail_produk.dart';
import 'package:localmart/localmart.dart/katalog_produk.dart';
import 'package:localmart/localmart.dart/product_model.dart';
import 'package:localmart/localmart.dart/profile.dart';
import 'package:carousel_slider/carousel_slider.dart';

const Color _primaryColor = Color(0xFF0025A5);

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int _selectedIndex = 0;

  // Sample Cart Items state for Keranjang tab
  final List<Map<String, dynamic>> _cartItems = [
    {'product': ProductRepository.sampleProducts[0], 'quantity': 1},
    {'product': ProductRepository.sampleProducts[1], 'quantity': 2},
  ];

  String _formatPrice(double price) {
    return 'Rp${price.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeTab(context),
          _buildSearchTab(context),
          _buildRiwayatTab(context),
          _buildKeranjangTab(context),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: _primaryColor,
        unselectedItemColor: const Color(0xFF747687),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 11,
        ),
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Pencarian',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    String title = "LocalMart";
    if (_selectedIndex == 1) {
      title = "Pencarian Produk";
    } else if (_selectedIndex == 2) {
      title = "Riwayat Pesanan";
    } else if (_selectedIndex == 3) {
      title = "Keranjang Belanja";
    }

    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.storefront, color: Colors.white),
        tooltip: 'Katalog Produk',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const KatalogProdukPage()),
          );
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.text_rotation_angleup_outlined,
            color: Colors.white,
          ),
          tooltip: 'Profil Saya',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HalamanProfilUser(),
              ),
            );
          },
        ),
        const SizedBox(width: 4),
      ],
      centerTitle: true,
      backgroundColor: _primaryColor,
      elevation: 0,
    );
  }

  Widget _buildHomeTab(BuildContext context) {
    final currentUser = AuthService.instance.currentUser;
    final featuredProducts = ProductRepository.sampleProducts;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Greeting Header Card
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HalamanProfilUser(),
                ),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFEEECF9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: _primaryColor,
                    radius: 18,
                    child: Text(
                      currentUser.fullName.isNotEmpty
                          ? currentUser.fullName[0].toUpperCase()
                          : 'U',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Halo, ${currentUser.fullName} 👋',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1B24),
                          ),
                        ),
                        Text(
                          currentUser.email,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF747687),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: _primaryColor),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Search Bar -> Switches to Search Tab
          TextField(
            readOnly: true,
            onTap: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              hintText: 'Cari produk di Katalog LocalMart...',
              prefixIcon: const Icon(Icons.search, color: _primaryColor),
              filled: true,
              fillColor: const Color(0xFFEEECF9),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
          const SizedBox(height: 20),

          // Banner Carousel Slider -> Navigates to Detail Produk
          CarouselSlider(
            options: CarouselOptions(
              height: 180.0,
              aspectRatio: 16 / 9,
              autoPlay: true,
              viewportFraction: 0.9,
              enlargeCenterPage: true,
              autoPlayInterval: const Duration(seconds: 3),
            ),
            items: List.generate(5, (index) {
              final product = featuredProducts[index % featuredProducts.length];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HalamanDetailProduk(product: product),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(15),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          product.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: const Color(0xFFEEECF9),
                              child: const Icon(
                                Icons.image,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.black87, Colors.transparent],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          child: Text(
                            product.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 28),

          // Category Grid Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Kategori Produk',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1B24),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KatalogProdukPage(),
                    ),
                  );
                },
                child: const Text(
                  'Lihat Semua',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: _primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Category Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
              childAspectRatio: 0.78,
            ),
            itemCount: 8,
            itemBuilder: (context, index) {
              final kategori = [
                {'icon': Icons.phone_android, 'text': 'Elektronik'},
                {'icon': Icons.checkroom, 'text': 'Pakaian Pria'},
                {'icon': Icons.watch, 'text': 'Aksesoris'},
                {'icon': Icons.toys, 'text': 'Tas Wanita'},
                {'icon': Icons.face, 'text': 'Kecantikan'},
                {'icon': Icons.woman, 'text': 'Atasan Wanita'},
                {'icon': Icons.backpack, 'text': 'Tas Pria'},
                {'icon': Icons.all_inclusive, 'text': 'Semua'},
              ];

              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      if (index == 7) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const KatalogProdukPage(),
                          ),
                        );
                      } else {
                        final categoryName = kategori[index]['text'] as String;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KatalogProdukPage(
                              initialCategory: categoryName,
                            ),
                          ),
                        );
                      }
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEECF9),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        kategori[index]['icon'] as IconData,
                        color: _primaryColor,
                        size: 26,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    kategori[index]['text'] as String,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 28),

          // Featured Products Catalog Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Katalog Produk Unggulan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1B24),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KatalogProdukPage(),
                    ),
                  );
                },
                child: const Text(
                  'Lihat Katalog',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: _primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Horizontal Featured Products Slider
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: featuredProducts.length,
              itemBuilder: (context, index) {
                final product = featuredProducts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            HalamanDetailProduk(product: product),
                      ),
                    );
                  },
                  child: Container(
                    width: 150,
                    margin: const EdgeInsets.only(right: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFEEECF9)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(10),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.asset(
                                  product.imagePath,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: const Color(0xFFEEECF9),
                                      child: const Icon(
                                        Icons.image,
                                        color: _primaryColor,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              if (product.badge != null)
                                Positioned(
                                  top: 6,
                                  left: 6,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _primaryColor,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      product.badge!,
                                      style: const TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1A1B24),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _formatPrice(product.price),
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: _primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSearchTab(BuildContext context) {
    return const KatalogProdukPage();
  }

  Widget _buildRiwayatTab(BuildContext context) {
    final sampleOrders = [
      {
        'id': 'LM-20260815-001',
        'date': '15 Ags 2026, 10:30 WIB',
        'status': 'Selesai',
        'statusColor': Colors.green,
        'product': ProductRepository.sampleProducts[0],
        'qty': 1,
        'total': 18500000.0,
      },
      {
        'id': 'LM-20260812-004',
        'date': '12 Ags 2026, 14:15 WIB',
        'status': 'Dalam Pengiriman',
        'statusColor': Colors.orange,
        'product': ProductRepository.sampleProducts[1],
        'qty': 2,
        'total': 700000.0,
      },
      {
        'id': 'LM-20260805-012',
        'date': '05 Ags 2026, 09:00 WIB',
        'status': 'Selesai',
        'statusColor': Colors.green,
        'product': ProductRepository.sampleProducts[2],
        'qty': 1,
        'total': 850000.0,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sampleOrders.length,
      itemBuilder: (context, index) {
        final order = sampleOrders[index];
        final prod = order['product'] as Product;
        final statusColor = order['statusColor'] as Color;

        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order['id'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xFF1A1B24),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        order['status'] as String,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  order['date'] as String,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF747687),
                  ),
                ),
                const Divider(height: 20),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        prod.imagePath,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 50,
                          height: 50,
                          color: const Color(0xFFEEECF9),
                          child: const Icon(Icons.image, color: _primaryColor),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            prod.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            '${order['qty']} barang x ${_formatPrice(prod.price)}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF747687),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Belanja',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF747687),
                          ),
                        ),
                        Text(
                          _formatPrice(order['total'] as double),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: _primaryColor,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HalamanDetailProduk(product: prod),
                          ),
                        );
                      },
                      child: const Text(
                        'Beli Lagi',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildKeranjangTab(BuildContext context) {
    if (_cartItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            const Text(
              'Keranjang Belanja Anda Kosong',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1B24),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Yuk, temukan produk lokal impianmu!',
              style: TextStyle(color: Color(0xFF747687)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
              child: const Text(
                'Mulai Belanja',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }

    double totalPrice = 0;
    for (var item in _cartItems) {
      final prod = item['product'] as Product;
      final qty = item['quantity'] as int;
      totalPrice += prod.price * qty;
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _cartItems.length,
            itemBuilder: (context, index) {
              final item = _cartItems[index];
              final prod = item['product'] as Product;
              final qty = item['quantity'] as int;

              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          prod.imagePath,
                          width: 65,
                          height: 65,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                width: 65,
                                height: 65,
                                color: const Color(0xFFEEECF9),
                                child: const Icon(
                                  Icons.image,
                                  color: _primaryColor,
                                ),
                              ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              prod.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _formatPrice(prod.price),
                              style: const TextStyle(
                                color: _primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.remove_circle_outline,
                              color: _primaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                if (qty > 1) {
                                  _cartItems[index]['quantity'] = qty - 1;
                                } else {
                                  _cartItems.removeAt(index);
                                }
                              });
                            },
                          ),
                          Text(
                            '$qty',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.add_circle_outline,
                              color: _primaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _cartItems[index]['quantity'] = qty + 1;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(15),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Total Pembayaran',
                      style: TextStyle(fontSize: 12, color: Color(0xFF747687)),
                    ),
                    Text(
                      _formatPrice(totalPrice),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _primaryColor,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Melanjutkan ke Pembayaran...'),
                        backgroundColor: _primaryColor,
                      ),
                    );
                  },
                  child: const Text(
                    'Beli Sekarang',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
