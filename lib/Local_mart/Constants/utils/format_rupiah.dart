// Utility helper untuk parsing dan formatting harga Rupiah

int parseHarga(String hargaStr) {
  String cleanStr = hargaStr.replaceAll(RegExp(r'[^\d]'), '');
  return int.tryParse(cleanStr) ?? 0;
}

String formatRupiah(int number) {
  String str = number.toString();
  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String result = str.replaceAllMapped(reg, (Match m) => '${m[1]}.');
  return 'Rp $result';
}
