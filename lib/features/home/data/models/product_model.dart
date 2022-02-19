class ProductModel {
  final int id;
  final int price;
  final int oldPrice;
  final int discount;
  final String image;
  final String name;
  final String description;
  final List<String> images;
  final bool inFavorites;
  final bool inCart;

  ProductModel({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
    required this.images,
    required this.inFavorites,
    required this.inCart,
  });

  factory ProductModel.fromJson({required Map<String, dynamic> product}) {
    return ProductModel(
      id: product['id'],
      price: product['price'],
      oldPrice: product['oldPrice'],
      discount: product['discount'],
      image: product['image'],
      name: product['name'],
      description: product['description'],
      images: product['images'],
      inFavorites: product['in_favorites'],
      inCart: product['in_cart'],
    );
  }
}
