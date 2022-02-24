import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:salla/features/home/presentation/bloc/home_bloc.dart';
import 'package:salla/features/home/presentation/widgets/carousel_slider.dart';
import 'package:salla/features/home/presentation/widgets/categories_list.dart';
import 'package:salla/features/home/presentation/widgets/product_grid_view.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var categoriesBloc = CategoriesBloc.get(context);
    var bloc = HomeBloc.get(context);
    int indexC = 0;
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => current is HomePageDataSuccess,
      builder: (context, state) {
        return (bloc.homeData == null) && (categoriesBloc.categoriesData == null)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSliderBuilder(homeDate: bloc.homeData),
                    const SizedBox(
                      height: 10,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Categories',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CategoriesListBuilder(
                              categoriesData: categoriesBloc.categoriesData),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'New Products',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: productGridView(products: bloc.homeData!.data.products),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
