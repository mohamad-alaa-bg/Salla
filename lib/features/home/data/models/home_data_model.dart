import 'package:salla/features/home/data/models/banners_model.dart';
import 'package:salla/features/home/data/models/product_model.dart';

class HomeDataModel {
  final List<BannerModel> banners;
  final List<ProductModel> products;

  HomeDataModel({
    required this.banners,
    required this.products,
  });

  factory HomeDataModel.fromJson({required Map<String, dynamic> data}) {
    List<dynamic> bannersList = data['banners'];
    List<dynamic> productsList = data['products'];
    List<BannerModel> banners = [];
    List<ProductModel> products = [];
    for (var element in bannersList) {
       banners.add(BannerModel.fromJson(banner: element)) ;
      }
    for (var element in productsList) {
       products.add(ProductModel.fromJson(product: element)) ;
      }
    return HomeDataModel(
      banners: banners,
      products: products,
    );
  }
}
