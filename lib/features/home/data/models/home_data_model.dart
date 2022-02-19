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
    List<BannerModel> alaa;
    return HomeDataModel(
      banners: data['banners'].forEach(
        (element) {
          BannerModel.fromJson(banner: element);
        },
      ),
      products: data['product'].forEach(
        (element) {
          ProductModel.fromJson(product: element);
        },
      ),
    );
  }
}
