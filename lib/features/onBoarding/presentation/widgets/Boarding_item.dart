import 'package:flutter/material.dart';
import 'package:salla/features/onBoarding/domain/entities/boarding_item_module.dart';

Widget buildBoardingItem(BuildContext context,BoardingItemModule boardingItem ){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image.asset(boardingItem.image)),
      Text(boardingItem.title,style:  Theme.of(context).textTheme.headline3,),
      Text(boardingItem.body,style:  Theme.of(context).textTheme.headline6,),
    ],
  );
}