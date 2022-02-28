import 'package:flutter/material.dart';
import 'package:salla/core/util/constants.dart';
import 'package:salla/core/util/enum.dart';
import 'package:salla/core/widgets/navigator.dart';
import 'package:salla/features/categories/data/models/categories_model.dart';
import 'package:salla/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:salla/features/categories/presentation/pages/category_details.dart';

class CategoriesListBuilder extends StatelessWidget {
  final CategoriesModel? categoriesData;

  const CategoriesListBuilder({Key? key, this.categoriesData})
      : super(key: key);

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
    return SizedBox(
      height: 160,
      child: ListView.separated(
        physics:const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => InkWell(
            onTap: (){
              getCategoryDetails(categoriesBloc: categoriesBloc, index: index, context: context);
            },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: UserData.themeMode == ThemeModeSetting.light ?Colors.black12:Colors.white)),
                  child: Column(
                    // alignment: AlignmentDirectional.bottomStart,

                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5,left: 5,right: 5,bottom: 1),
                        child: Image(
                          image: NetworkImage(
                              categoriesData!.categories[index].image),
                          width: 120,
                          height: 120,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black12),
                          color: Colors.black.withOpacity(0.6),
                        ),
                        width: 125,
                        child: Text(
                          categoriesData!.categories[index].name,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          separatorBuilder: (context, index) => const SizedBox(
                width: 5,
              ),
          itemCount: categoriesData!.categories.length),
    );
  }
}
