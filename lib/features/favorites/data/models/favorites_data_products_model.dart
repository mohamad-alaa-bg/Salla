import 'package:salla/features/home/data/models/product_model.dart';

class FavoritesProductsModel extends ProductModel {
  final int id;
  final dynamic price;
  final dynamic oldPrice;
  final int discount;
  final String image;
  final String name;
  final String description;

  FavoritesProductsModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.description,
  }) : super(
            id: id,
            name: name,
            price: price,
            oldPrice: oldPrice,
            discount: discount,
            description: description,
            image: '',
            images: [],
            inCart: false,
            inFavorites: true);

  factory FavoritesProductsModel.fromJson(Map<String, dynamic> product) {
    return FavoritesProductsModel(
      id: product['product']['id'],
      name: product['product']['name'],
      image: product['product']['image'],
      price: product['product']['price'],
      oldPrice: product['product']['old_price'],
      discount: product['product']['discount'],
      description: product['product']['description'],
    );
  }
}
