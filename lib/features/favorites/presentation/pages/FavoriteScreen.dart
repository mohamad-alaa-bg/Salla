import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:salla/core/data/remote_data_source.dart';
import 'package:salla/core/util/constants.dart';
import 'package:salla/features/favorites/data/models/favorite_model.dart';
import 'package:salla/features/favorites/data/models/favorites_data_products_model.dart';
import 'package:salla/features/home/presentation/widgets/product_grid_view.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<FavoritesProductsModel>? products;

  @override
  void initState() {
    Response response;
    DioHelper.getData(url: EndPoints.favorite,token: UserData.token).then((value) {
      print(value);
      setState(() {
        products = FavoritesModel.fromJson(value).products;

      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProductGridView(products: products ?? [],physics: const BouncingScrollPhysics(),);
  }
}
