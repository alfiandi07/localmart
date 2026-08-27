import 'package:flutter/material.dart';
import 'package:localmart/Local_mart/Constants/models/store_model.dart';

class KelolaTokoPage extends StatelessWidget {
  final StoreModel store;

  const KelolaTokoPage({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    const Color primaryColor = Color(0xFF0025A5);
    final Color backgroundColor =
        isDark ? const Color(0xFF121212) : const Color(0xFFFCF9F8);
    final Color cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final Color textColor = isDark ? Colors.white : const Color(0xFF1A1B24);
    final Color subtextColor =
        isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Dashboard Toko Saya',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: cardBg,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -----------------------------------------------------------------
            // Header Info Toko Card
            // -----------------------------------------------------------------
            Card(
              elevation: isDark ? 1 : 2,
              color: cardBg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: isDark
                    ? BorderSide(color: Colors.grey.shade800)
                    : BorderSide.none,
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF2A2A3D)
                                : const Color(0xFFDEE0FF),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.storefront_rounded,
                            color: primaryColor,
                            size: 38,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      store.storeName,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE8F5E9),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Row(
                                      children: [
                                        Icon(Icons.verified,
                                            size: 12, color: Colors.green),
                                        SizedBox(width: 4),
                                        Text(
                                          'Toko Aktif',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                store.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: subtextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),

                    // Detail Kontak & Payout Bank Toko
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined,
                            size: 16, color: primaryColor),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            store.address,
                            style: TextStyle(fontSize: 12, color: subtextColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.phone_outlined,
                            size: 16, color: primaryColor),
                        const SizedBox(width: 6),
                        Text(
                          store.phone,
                          style: TextStyle(fontSize: 12, color: subtextColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.account_balance_outlined,
                            size: 16, color: primaryColor),
                        const SizedBox(width: 6),
                        Text(
                          'Pencarian: ${store.bankName} (${store.bankAccount})',
                          style: TextStyle(fontSize: 12, color: subtextColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // -----------------------------------------------------------------
            // Ringkasan Performa Toko Grid (Kritikal Penjual)
            // -----------------------------------------------------------------
            Text(
              'RINGKASAN PERFORMA TOKO',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    title: 'Total Produk',
                    value: '12',
                    icon: Icons.inventory_2_outlined,
                    primaryColor: primaryColor,
                    isDark: isDark,
                    cardBg: cardBg,
                    textColor: textColor,
                    subtextColor: subtextColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    title: 'Pesanan Masuk',
                    value: '5 Baru',
                    icon: Icons.shopping_bag_outlined,
                    primaryColor: primaryColor,
                    isDark: isDark,
                    cardBg: cardBg,
                    textColor: textColor,
                    subtextColor: subtextColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // -----------------------------------------------------------------
            // Menu Fitur Pengelolaan Toko
            // -----------------------------------------------------------------
            Text(
              'MENU PENGELOLAAN',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: isDark ? 1 : 1,
              color: cardBg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: isDark
                    ? BorderSide(color: Colors.grey.shade800)
                    : BorderSide.none,
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF2A2A2A)
                            : const Color(0xFFF4F2FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child:
                          const Icon(Icons.add_box_outlined, color: primaryColor),
                    ),
                    title: Text(
                      'Tambah Produk Baru',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    subtitle: Text(
                      'Upload produk baru ke katalog Toko Anda',
                      style: TextStyle(fontSize: 11, color: subtextColor),
                    ),
                    trailing: Icon(Icons.chevron_right, color: subtextColor),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fitur Tambah Produk Toko dipilih.'),
                          backgroundColor: primaryColor,
                        ),
                      );
                    },
                  ),
                  Divider(
                      height: 1,
                      color:
                          isDark ? Colors.grey.shade800 : Colors.grey.shade200),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF2A2A2A)
                            : const Color(0xFFF4F2FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.receipt_long_outlined,
                          color: primaryColor),
                    ),
                    title: Text(
                      'Pesanan Masuk Toko',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    subtitle: Text(
                      'Proses pesanan barang dari pembeli',
                      style: TextStyle(fontSize: 11, color: subtextColor),
                    ),
                    trailing: Icon(Icons.chevron_right, color: subtextColor),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fitur Pesanan Masuk Toko dipilih.'),
                          backgroundColor: primaryColor,
                        ),
                      );
                    },
                  ),
                  Divider(
                      height: 1,
                      color:
                          isDark ? Colors.grey.shade800 : Colors.grey.shade200),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF2A2A2A)
                            : const Color(0xFFF4F2FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.settings_outlined,
                          color: primaryColor),
                    ),
                    title: Text(
                      'Pengaturan Informas Toko',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    subtitle: Text(
                      'Ubah alamat, WhatsApp, atau nama toko',
                      style: TextStyle(fontSize: 11, color: subtextColor),
                    ),
                    trailing: Icon(Icons.chevron_right, color: subtextColor),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fitur Pengaturan Toko dipilih.'),
                          backgroundColor: primaryColor,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color primaryColor,
    required bool isDark,
    required Color cardBg,
    required Color textColor,
    required Color subtextColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF4F2FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: primaryColor, size: 24),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 11, color: subtextColor),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
