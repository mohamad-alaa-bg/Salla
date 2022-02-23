import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salla/features/categories/data/models/categories_model.dart';

Widget categoriesListVerticalBuilder({CategoriesModel? categoriesData}) {
  return ListView.separated(
    scrollDirection: Axis.vertical,
    itemCount: categoriesData!.categories.length,
    itemBuilder: (context, index) => Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black12)),
      height: 120,
      width: double.infinity,
      child: Row(
        children: [
          Image(
            image: NetworkImage(
                categoriesData.categories[index].image),
            fit: BoxFit.contain,
            width: 120,
            height: 120,
          ),
          const SizedBox(width: 10,),
          Text(
            categoriesData.categories[index].name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_forward_ios_outlined)),
        ],
      ),
    ),
    separatorBuilder: (context, index) => const SizedBox(
      height: 10,
    ),
  );
}
