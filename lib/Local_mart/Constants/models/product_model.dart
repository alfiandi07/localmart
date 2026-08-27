class ProductModel {
  final String name;
  final String category;
  final String price;
  final String image;
  final String toko;
  final String rating;
  final String description;
  int quantity;
  bool isFavorite;

  ProductModel({
    required this.name,
    required this.category,
    required this.price,
    required this.image,
    this.toko = 'LocalMart Official',
    this.rating = '5.0',
    this.description = '',
    this.quantity = 1,
    this.isFavorite = false,
  });

  // Factory constructor dari Map
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      price: map['price'] ?? '',
      image: map['image'] ?? '',
      toko: map['toko'] ?? 'LocalMart Official',
      rating: map['rating'] ?? '5.0',
      description: map['description'] ?? '',
      quantity: map['quantity'] is int
          ? map['quantity']
          : (int.tryParse(map['quantity']?.toString() ?? '1') ?? 1),
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  // Convert ProductModel ke Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'price': price,
      'image': image,
      'toko': toko,
      'rating': rating,
      'description': description,
      'quantity': quantity,
      'isFavorite': isFavorite,
    };
  }
}
