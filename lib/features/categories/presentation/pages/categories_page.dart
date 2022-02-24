import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:salla/features/categories/presentation/widgets/categories_list_vertical.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var categoriesBloc = CategoriesBloc.get(context);
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        return categoriesBloc.categoriesData == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: CategoriesListVerticalBuilder(),
                ),
              );
      },
    );
  }
}
