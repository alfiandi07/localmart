import 'package:flutter/material.dart';
import 'package:localmart/Local_mart/Constants/utils/format_rupiah.dart';

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
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    const Color primaryColor = Color(0xFF0025A5);
    final Color cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final Color textColor = isDark ? Colors.white : const Color(0xFF1A1B24);
    final Color subtextColor = isDark
        ? Colors.grey.shade400
        : Colors.grey.shade700;

    int subtotal = hitungSubtotal();
    int biayaPengiriman = selectedItems.isNotEmpty ? 1000 : 0;
    int totalHarga = subtotal + biayaPengiriman;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Keranjang Belanja',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: cardBg,
        iconTheme: IconThemeData(color: primaryColor),
      ),
      body: widget.keranjang.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: isDark ? Colors.grey.shade600 : Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Keranjang masih kosong',
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark ? Colors.grey.shade400 : Colors.grey,
                    ),
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
                  color: cardBg,
                  child: Row(
                    children: [
                      Checkbox(
                        value: _isAllSelected,
                        activeColor: primaryColor,
                        onChanged: _toggleSelectAll,
                      ),
                      Text(
                        'Pilih Semua (${selectedItems.length}/${widget.keranjang.length})',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
                ),

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
                        elevation: isDark ? 1 : 2,
                        color: cardBg,
                        margin: const EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: isDark
                              ? BorderSide(color: Colors.grey.shade800)
                              : BorderSide.none,
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
                                activeColor: primaryColor,
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
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      product['name'] ?? '',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      product['price'] ?? '',
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    if (qty > 1) ...[
                                      const SizedBox(height: 1),
                                      Text(
                                        'Subtotal Item: ${formatRupiah(totalProductPrice)}',
                                        style: TextStyle(
                                          color: subtextColor,
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
                                              color: isDark
                                                  ? Colors.grey.shade700
                                                  : Colors.grey.shade300,
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
                                                icon: Icon(
                                                  Icons.remove,
                                                  size: 18,
                                                  color: textColor,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                    ),
                                                child: Text(
                                                  '$qty',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: textColor,
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
                                                icon: Icon(
                                                  Icons.add,
                                                  size: 18,
                                                  color: textColor,
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
                                  _showKonfirmasiHapusDialog(context, index);
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
                    color: cardBg,
                    boxShadow: [
                      BoxShadow(
                        color: isDark ? Colors.black54 : Colors.grey.shade300,
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
                      Text(
                        'Rincian Harga',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal Produk (${selectedItems.length} item)',
                            style: TextStyle(color: subtextColor),
                          ),
                          Text(
                            formatRupiah(subtotal),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Biaya Pengiriman',
                            style: TextStyle(color: subtextColor),
                          ),
                          Text(
                            formatRupiah(biayaPengiriman),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Divider(
                          color: isDark
                              ? Colors.grey.shade800
                              : Colors.grey.shade300,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Pembayaran',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          Text(
                            formatRupiah(totalHarga),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
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
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      backgroundColor: primaryColor,
                                    ),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
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

  void _showKonfirmasiHapusDialog(BuildContext context, int index) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final Color textColor = isDark ? Colors.white : const Color(0xFF1A1B24);
    final Color subtextColor = isDark
        ? Colors.grey.shade400
        : Colors.grey.shade600;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: cardBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Konfirmasi Hapus',
            style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
          ),
          content: Text(
            'Apakah anda yakin ingin menghapus produk?',
            style: TextStyle(color: subtextColor),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text('Batal', style: TextStyle(color: subtextColor)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                setState(() {
                  final removed = widget.keranjang.removeAt(index);
                  selectedItems.remove(removed);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'Produk berhasil dihapus dari keranjang.',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: isDark ? const Color(0xFF0025A5) : null,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }
}
