import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/core/util/constants.dart';
import 'package:salla/core/util/enum.dart';
import 'package:salla/core/widgets/navigator.dart';
import 'package:salla/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:salla/features/home/presentation/pages/home_layout.dart';
import 'package:salla/features/home/presentation/widgets/product_grid_view.dart';

class CategoryDetails extends StatelessWidget {
  const CategoryDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var categoriesBloc = CategoriesBloc.get(context);
    return Scaffold(
      appBar: AppBar(
          // leading: IconButton(
          //   onPressed: (){
          //     navigateAndReplacementAll(context, const HomeLayout());
          //   },
          //   icon: const Icon(Icons.arrow_back_ios_outlined),
          // ),
          ),
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          return state is CategoryDetailsIsLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ProductGridView(
                      products: UserData.language == Language.english
                          ? categoriesBloc.categoryDetailsEn!.products
                          : categoriesBloc.categoryDetailsAr!.products,
                      physics: const BouncingScrollPhysics()),
                );
        },
      ),
    );
  }
}
