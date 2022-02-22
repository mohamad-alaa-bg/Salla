import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/features/home/presentation/bloc/home_bloc.dart';
import 'package:salla/features/home/presentation/widgets/carousel_slider.dart';
import 'package:salla/features/home/presentation/widgets/product_grid_view.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = HomeBloc.get(context);
    int indexC = 0;
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => current is HomePageDataSuccess,
      builder: (context, state) {
        return bloc.homeData == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                  children: [
                    CarouselSliderBuilder(homeDate: bloc.homeData),
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: productGridView(homeData: bloc.homeData),
                      ),
                    ),
                  ],
                ),
            );
      },
    );
  }
}
