import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/core/util/constants.dart';
import 'package:salla/core/util/enum.dart';
import 'package:salla/core/widgets/flutter_toast.dart';
import 'package:salla/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:salla/features/home/data/models/product_model.dart';
import 'package:salla/features/home/presentation/bloc/home_bloc.dart';

class ProductGridView extends StatelessWidget {
  final List<ProductModel> products;
  final ScrollPhysics? physics;

  const ProductGridView({Key? key, required this.products, this.physics})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeBloc = HomeBloc.get(context);
    var favoritesBloc = FavoritesBloc.get(context);
    return BlocConsumer<FavoritesBloc, FavoritesState>(
      listener: (context, state) {
        if (state is FavoriteChangeWarning) {
          showToast(message: state.message, toastColor: ToastColor.warning);
        }
      },
      builder: (context, state) {
        print('bloc');
        return GridView.count(
          shrinkWrap: true,
          physics: physics ?? const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 1 / 1.5,
          children: List.generate(
            products.length,
            (index) {
              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: UserData.themeMode == ThemeModeSetting.light
                            ? Colors.black12
                            : Colors.white)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          Image(
                            image: NetworkImage(products[index].image),
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                          if (products[index].discount > 0)
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: const Text(
                                'Discount',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.red,
                            ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                products[index].name,
                                maxLines: 2,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color:
                                    UserData.themeMode == ThemeModeSetting.light
                                        ? Colors.grey.withOpacity(0.1)
                                        : Colors.grey.withOpacity(0.5),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    products[index].price.round().toString(),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  if (products[index].discount > 0)
                                    Text(
                                      products[index]
                                          .oldPrice
                                          .round()
                                          .toString(),
                                      style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      favoritesBloc.add(
                                          ChangeProductFavoriteState(
                                              productId: products[index].id,
                                              productModel: products[index]));
                                    },
                                    icon: favoritesBloc
                                                .favorite[products[index].id] ??
                                            false
                                        ? const Icon(Icons.favorite,
                                            color: Colors.red)
                                        : const Icon(Icons.favorite_border),
                                    padding: EdgeInsets.zero,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
