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
      name: 'Mug Keramik Biru Kobalt',
      category: 'Aksesoris',
      origin: 'Bandung',
      badge: '-25%',
      price: 145000,
      originalPrice: 195000,
      rating: 4.9,
      soldCount: '1.2rb+',
      imagePath: 'assets/images/onboarding1.png',
      description:
          'Mug keramik buatan tangan perajin lokal Bandung dengan sentuhan glasir biru kobalt organik. Tahan panas, aman untuk microwave dan pemakaian sehari-hari.',
      isFavorite: true,
    ),
    Product(
      id: 'p2',
      name: 'Madu Hutan Sumbawa Murni',
      category: 'Kecantikan',
      origin: 'Sumbawa',
      badge: 'LOKAL',
      price: 89000,
      rating: 4.8,
      soldCount: '850+',
      imagePath: 'assets/images/onboarding2.png',
      description:
          'Madu hutan liar murni dipanen dari pepohonan lebat Sumbawa secara alami tanpa campuran bahan kimia. Kaya antioksidan dan nutrisi harian.',
    ),
    Product(
      id: 'p3',
      name: 'Tas Anyaman Serat Alam',
      category: 'Tas Pria',
      origin: 'Jogja',
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
      name: 'Biji Kopi Gayo Arabika 250g',
      category: 'Elektronik',
      origin: 'Aceh',
      badge: '-15%',
      price: 115000,
      originalPrice: 135000,
      rating: 4.9,
      soldCount: '2.5rb+',
      imagePath: 'assets/images/onboarding3.png',
      description:
          'Biji kopi Arabika Gayo kualitas ekspor dari dataran tinggi Aceh. Memiliki aroma floral khas, rasa seimbang dengan keasaman lembut.',
    ),
    Product(
      id: 'p5',
      name: 'Tas Kulit Wanita Premium',
      category: 'Atasan Wanita',
      origin: 'Garut',
      badge: 'BESTSELLER',
      price: 345000,
      originalPrice: 420000,
      rating: 4.8,
      soldCount: '530+',
      imagePath: 'assets/images/TasWanita.jpg',
      description:
          'Tas selempang wanita buatan perajin Garut berbahan kulit asli berkualitas tinggi. Jahitan rapi, tahan lama dan berpenampilan elegan.',
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
      badge: 'FASHION',
      price: 265000,
      rating: 4.9,
      soldCount: '920+',
      imagePath: 'assets/images/Old money dressing.jpg',
      description:
          'Kemeja pria bermotif modern minimalis berbahan katun primissima super halus dan adem dipakai seharian.',
    ),
  ];
}
