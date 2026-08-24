import 'package:flutter/material.dart';
import 'package:localmart/Day_20/Constants/utils/format_rupiah.dart';

class KeranjangBelanja extends StatefulWidget {
  final List<Map<String, dynamic>> keranjang;

  const KeranjangBelanja({super.key, required this.keranjang});

  @override
  State<KeranjangBelanja> createState() => _KeranjangBelanjaState();
}

class _KeranjangBelanjaState extends State<KeranjangBelanja> {
  Set<Map<String, dynamic>>? _selectedItems;

  Set<Map<String, dynamic>> get selectedItems {
    _selectedItems ??= Set.from(widget.keranjang);
    return _selectedItems!;
  }

  @override
  void initState() {
    super.initState();
    _selectedItems = Set.from(widget.keranjang);
  }

  bool get _isAllSelected =>
      widget.keranjang.isNotEmpty &&
      selectedItems.length == widget.keranjang.length;

  void _toggleSelectAll(bool? value) {
    setState(() {
      if (value == true) {
        _selectedItems = Set.from(widget.keranjang);
      } else {
        selectedItems.clear();
      }
    });
  }

  void _toggleSelectItem(Map<String, dynamic> item, bool? value) {
    setState(() {
      if (value == true) {
        selectedItems.add(item);
      } else {
        selectedItems.remove(item);
      }
    });
  }

  void tambahJumlah(int index) {
    setState(() {
      widget.keranjang[index]['quantity'] =
          (widget.keranjang[index]['quantity'] ?? 1) + 1;
    });
  }

  void kurangiJumlah(int index) {
    setState(() {
      int currentQty = widget.keranjang[index]['quantity'] ?? 1;
      if (currentQty > 1) {
        widget.keranjang[index]['quantity'] = currentQty - 1;
      }
    });
  }

  int hitungSubtotal() {
    int subtotal = 0;
    for (var item in widget.keranjang) {
      if (selectedItems.contains(item)) {
        int harga = parseHarga(item['price']?.toString() ?? '0');
        int qty = item['quantity'] is int
            ? item['quantity']
            : (int.tryParse(item['quantity']?.toString() ?? '1') ?? 1);
        subtotal += harga * qty;
      }
    }
    return subtotal;
  }

  @override
  Widget build(BuildContext context) {
    int subtotal = hitungSubtotal();
    int biayaPengiriman = selectedItems.isNotEmpty ? 1000 : 0;
    int totalHarga = subtotal + biayaPengiriman;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Keranjang Belanja',
          style: TextStyle(color: Color(0xFF0025A5)),
        ),
      ),

      body: widget.keranjang.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Keranjang masih kosong',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // Option Pilih Semua
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Checkbox(
                        value: _isAllSelected,
                        activeColor: const Color(0xFF0025A5),
                        onChanged: _toggleSelectAll,
                      ),
                      Text(
                        'Pilih Semua (${selectedItems.length}/${widget.keranjang.length})',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),

                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: widget.keranjang.length,
                    itemBuilder: (context, index) {
                      final product = widget.keranjang[index];
                      int hargaSatuan = parseHarga(product['price'] ?? '0');
                      int qty = product['quantity'] ?? 1;
                      int totalProductPrice = hargaSatuan * qty;
                      bool isSelected = selectedItems.contains(product);

                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 8,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Checkbox Pilihan Produk
                              Checkbox(
                                value: isSelected,
                                activeColor: const Color(0xFF0025A5),
                                onChanged: (bool? val) {
                                  _toggleSelectItem(product, val);
                                },
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  product['image'],
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product['category'] ?? '',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      product['name'] ?? '',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      product['price'] ?? '',
                                      style: const TextStyle(
                                        color: Color(0xFF0025A5),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    if (qty > 1) ...[
                                      const SizedBox(height: 1),
                                      Text(
                                        'Subtotal Item: ${formatRupiah(totalProductPrice)}',
                                        style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey.shade300,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              IconButton(
                                                constraints:
                                                    const BoxConstraints(),
                                                padding: const EdgeInsets.all(
                                                  4,
                                                ),
                                                onPressed: () {
                                                  kurangiJumlah(index);
                                                },
                                                icon: const Icon(
                                                  Icons.remove,
                                                  size: 18,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                    ),
                                                child: Text(
                                                  '$qty',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                constraints:
                                                    const BoxConstraints(),
                                                padding: const EdgeInsets.all(
                                                  4,
                                                ),
                                                onPressed: () {
                                                  tambahJumlah(index);
                                                },
                                                icon: const Icon(
                                                  Icons.add,
                                                  size: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    final removed = widget.keranjang.removeAt(
                                      index,
                                    );
                                    selectedItems.remove(removed);
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Rincian Harga & Subtotal Section
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 5,
                        offset: const Offset(0, -5),
                      ),
                    ],
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(22),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Rincian Harga',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1B24),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal Produk (${selectedItems.length} item)',
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          Text(
                            formatRupiah(subtotal),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Biaya Pengiriman',
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          Text(
                            formatRupiah(biayaPengiriman),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Pembayaran',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            formatRupiah(totalHarga),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0025A5),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: selectedItems.isEmpty
                              ? null
                              : () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Proses Checkout ${selectedItems.length} Produk (Total: ${formatRupiah(totalHarga)})',
                                      ),
                                      backgroundColor: const Color(0xFF0025A5),
                                    ),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0025A5),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            selectedItems.isEmpty
                                ? 'Pilih Produk Terlebih Dahulu'
                                : 'Beli / Checkout (${selectedItems.length})',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
