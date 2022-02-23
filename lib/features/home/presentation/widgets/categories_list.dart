import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salla/features/categories/data/models/categories_model.dart';

Widget categoriesListBuilder({required CategoriesModel? categoriesData}) {
  return SizedBox(
    height: 148,
    child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black12)),
              child: Column(
                // alignment: AlignmentDirectional.bottomStart,

                children: [
                  Image(
                    image:
                        NetworkImage(categoriesData!.categories[index].image),
                    width: 125,
                    height: 125,
                    fit: BoxFit.contain,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black12),
                      color: Colors.black.withOpacity(0.6),
                    ),
                    width: 125,
                    child: Text(
                      categoriesData.categories[index].name,
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
        separatorBuilder: (context, index) => const SizedBox(
              width: 5,
            ),
        itemCount: categoriesData!.categories.length),
  );
}
