import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:salla/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:salla/features/home/presentation/widgets/product_grid_view.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var favoritesBloc = FavoritesBloc.get(context);
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        return favoritesBloc.favoritesProduceList == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ProductGridView(products: favoritesBloc.favoritesProduceList??[],physics: const BouncingScrollPhysics(),),
              ),
            );
      },
    );
  }
}
