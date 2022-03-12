import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/core/util/constants.dart';
import 'package:salla/core/util/enum.dart';
import 'package:salla/core/widgets/navigator.dart';
import 'package:salla/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:salla/features/categories/presentation/pages/category_details.dart';

class CategoriesListVerticalBuilder extends StatelessWidget {
  const CategoriesListVerticalBuilder({Key? key}) : super(key: key);

  void getCategoryDetails({
    required CategoriesBloc categoriesBloc,
    required int index,
    required BuildContext context,
  }) {
    categoriesBloc.add(GetCategoryDetailsEvent(
        id: categoriesBloc.categoriesData!.categories[index].id));
    navigateTo(context, const CategoryDetails());
  }

  @override
  Widget build(BuildContext context) {
    var categoriesBloc = CategoriesBloc.get(context);
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: categoriesBloc.categoriesData!.categories.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                getCategoryDetails(
                    categoriesBloc: categoriesBloc,
                    index: index,
                    context: context);
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: UserData.themeMode == ThemeModeSetting.light
                            ? Colors.black12
                            : Colors.white)),
                height: 140,
                width: double.infinity,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Image(
                        image: CachedNetworkImageProvider(categoriesBloc
                            .categoriesData!.categories[index].image),
                        fit: BoxFit.contain,
                        width: 120,
                        height: 120,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      categoriesBloc.categoriesData!.categories[index].name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          getCategoryDetails(
                              categoriesBloc: categoriesBloc,
                              index: index,
                              context: context);
                        },
                        icon: const Icon(Icons.arrow_forward_ios_outlined)),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
        );
      },
    );
  }
}
