class Product {
  final String id;
  final String name;
  final String category;
  final String origin;
  final String? badge;
  final double price;
  final double? originalPrice;
  final double rating;
  final String soldCount;
  final String imagePath;
  final String description;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.origin,
    this.badge,
    required this.price,
    this.originalPrice,
    required this.rating,
    required this.soldCount,
    required this.imagePath,
    required this.description,
    this.isFavorite = false,
  });
}

class ProductRepository {
  static final List<Product> sampleProducts = [
    Product(
      id: 'p1',
      name: 'Jam Tangan Pria',
      category: 'Aksesoris',
      origin: 'Bandung',
      badge: 'LOKAL',
      price: 145000,
      originalPrice: 250000,
      rating: 4.9,
      soldCount: '1.2rb+',
      imagePath: 'assets/images/jamtangan.jpg',
      description:
          'Jam tangan pria dengan desain minimalis dan paduan warna yang membuat jam tangan ini terlihat lebih elegan',
      isFavorite: true,
    ),
    Product(
      id: 'p2',
      name: 'Facial wash ',
      category: 'Kecantikan',
      origin: 'Indonesia',
      badge: 'LOKAL',
      price: 89000,
      rating: 4.8,
      soldCount: '10rb+',
      imagePath: 'assets/images/facial wash.jpg',
      description:
          'Facial wash ini sangat bagus untuk membersihkan wajah dan mengangkat sel kulit mati secara alami, tanpa campuran bahan kimia.',
    ),
    Product(
      id: 'p3',
      name: 'Tas Ransel Perempuan',
      category: 'Tas Wanita',
      origin: 'Bandung',
      badge: 'BARU',
      price: 210000,
      rating: 5.0,
      soldCount: '210+',
      imagePath: 'assets/images/tasperempuan.jpg',
      description:
          'Tas anyaman wanita berbahan dasar serat alam ramah lingkungan khas Yogyakarta. Didesain modern, kokoh, serta cocok untuk gaya etnik kasual.',
    ),
    Product(
      id: 'p4',
      name: 'Samsung a15',
      category: 'Elektronik',
      origin: 'Indonesia',
      badge: '-15%',
      price: 2400000,
      originalPrice: 2500000,
      rating: 4.9,
      soldCount: '2.5rb+',
      imagePath: 'assets/images/Samsung Galaxy A15.jpg',
      description:
          'Samsung Galaxy A15 adalah pilihan cerdas bagi kamu yang menginginkan performa andal dan fitur modern tanpa menguras kantong. Ditenagai chipset MediaTek Helio G99 yang responsif, ia mampu menjalankan aplikasi harian serta game favorit dengan lancar, tampilan warna yang cerah dengan layar Super AMOLED 6,5 inci.',
    ),
    Product(
      id: 'p5',
      name: 'Tas Kulit Wanita Premium',
      category: 'Atasan Wanita',
      origin: 'Bandung',
      badge: 'BESTSELLER',
      price: 275000,
      originalPrice: 325000,
      rating: 4.7,
      soldCount: '3.2rb+',
      imagePath: 'assets/images/kemeja wanita.jpg',
      description:
          'Kemeja wanita buatan perajin Bandung bahan katun premium berkualitas tinggi. Jahitan rapi, tahan lama dan berpenampilan elegan.',
      isFavorite: true,
    ),
    Product(
      id: 'p6',
      name: 'The Five Step Skincare Kit',
      category: 'Kecantikan',
      origin: 'Bali',
      badge: 'ORGANIK',
      price: 275000,
      rating: 4.9,
      soldCount: '1.8rb+',
      imagePath: 'assets/images/The Five Step Essentials Skincare Kit.jpg',
      description:
          'Paket perawatan kulit wajah lengkap berbahan ekstrak tumbuhan herbal Bali. Menjaga kelembapan, mencerahkan dan menyegarkan kulit secara alami.',
    ),
    Product(
      id: 'p7',
      name: 'Ransel Kulit Biznes Executive',
      category: 'Tas Pria',
      origin: 'Bandung',
      badge: 'PREMIUM',
      price: 499000,
      rating: 4.7,
      soldCount: '340+',
      imagePath: 'assets/images/Skórzany plecak na spotkanie biznesowe.jpg',
      description:
          'Ransel kulit serbaguna untuk kebutuhan bisnis dan laptop hingga 15 inci. Kompartemen luas dan bantalan bahu yang nyaman.',
    ),
    Product(
      id: 'p8',
      name: 'Kemeja Style Modern Classic',
      category: 'Pakaian Pria',
      origin: 'Solo',
      badge: '-27%',
      price: 195000,
      originalPrice: 265000,
      rating: 4.9,
      soldCount: '920+',
      imagePath: 'assets/images/kemeja.jpg',
      description:
          'Kemeja pria bermotif modern minimalis berbahan katun primissima super halus dan adem dipakai seharian.',
      isFavorite: true,
    ),
  ];
}
