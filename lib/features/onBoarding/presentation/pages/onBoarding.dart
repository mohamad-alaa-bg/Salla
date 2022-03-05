import 'package:flutter/material.dart';
import 'package:salla/core/data/local_data_source/shared_preferences.dart';
import 'package:salla/core/util/constants.dart';
import 'package:salla/core/widgets/navigator.dart';
import 'package:salla/features/login/presentation/pages/login_page.dart';
import 'package:salla/features/onBoarding/domain/entities/boarding_item_module.dart';
import 'package:salla/features/onBoarding/presentation/widgets/Boarding_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatelessWidget {
  OnBoarding({Key? key}) : super(key: key);

  List<BoardingItemModule> onBoardingItems = [
    BoardingItemModule(
        image: 'assets/images/grocery-shopping.jpeg',
        title: 'Shopping Online',
        body: 'Make your shopping easy'),
    BoardingItemModule(
        image: 'assets/images/payment.jpeg',
        title: 'Payment',
        body: 'Payment Online'),
    BoardingItemModule(
        image: 'assets/images/delivery.jpg',
        title: 'Delivery',
        body: 'Door to Door Delivery'),
  ];

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    bool isLast = false;
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                SharedPreferencesCache.setValue(
                    key: 'onBoarding', value: false);
                UserData.onBoardingState =
                    SharedPreferencesCache.getValue(key: 'onBoarding') ?? true;

                navigateAndReplacementAll(context, const ShopLoginHome());
              },
              child: const Text('Skip')),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: pageController,
                itemCount: onBoardingItems.length,
                itemBuilder: (context, index) {
                  if (index == onBoardingItems.length - 1) {
                    isLast = true;
                  } else {
                    isLast = false;
                  }
                  return buildBoardingItem(context, onBoardingItems[index]);
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: onBoardingItems.length,
                  effect: const ExpandingDotsEffect(
                    dotWidth: 10,
                    dotHeight: 10,
                    spacing: 5,
                    expansionFactor: 4,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      navigateAndReplacementAll(context, const ShopLoginHome());
                      SharedPreferencesCache.setValue(
                          key: 'onBoarding', value: false);
                      UserData.onBoardingState =
                          SharedPreferencesCache.getValue(key: 'onBoarding') ??
                              true;
                    } else {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.fastOutSlowIn,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios_sharp),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
