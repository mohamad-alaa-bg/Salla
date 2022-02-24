import 'package:flutter/material.dart';
import 'package:salla/features/home/data/models/home_model.dart';
import 'package:salla/features/home/data/models/product_model.dart';

Widget productGridView({required List<ProductModel> products,ScrollPhysics? physics}) {
  return GridView.count(
    shrinkWrap: true,
    physics: physics??const NeverScrollableScrollPhysics(),
    crossAxisCount: 2,
    crossAxisSpacing: 5,
    mainAxisSpacing: 5,
    childAspectRatio: 1 / 1.5,
    children: List.generate(
      products.length,
          (index) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: NetworkImage(products[index].image),
                      height: 250,
                      width: double.infinity,
                    ),
                    if (products[index].discount > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: const Text(
                          'Discount',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.red,
                      ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Expanded(
                  child: Text(
                  products[index].name,
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    color: Colors.grey.withOpacity(0.1),

                  ),
                child: Row(
                  children: [
                    Text(
                      products[index].price
                          .round()
                          .toString(),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (products[index].discount > 0)
                      Text(
                        products[index].oldPrice
                            .round()
                            .toString(),
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),)
        ,
        ]
        ,
        )
        ,
        );
      },
    ),
  );
}
