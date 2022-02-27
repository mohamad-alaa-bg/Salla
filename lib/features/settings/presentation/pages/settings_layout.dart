import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salla/core/data/local_data_source/shared_preferences.dart';
import 'package:salla/core/util/constants.dart';
import 'package:salla/core/widgets/navigator.dart';
import 'package:salla/features/login/presentation/pages/login_page.dart';
import 'package:salla/features/onBoarding/presentation/pages/onBoarding.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        centerTitle: false,
        // systemOverlayStyle: const SystemUiOverlayStyle().copyWith(statusBarColor: Colors.blueAccent),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Settings',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Account Information',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(color: Colors.black87),

        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 10),
              onPressed: () {
                SharedPreferencesCache.removeValue(key: 'token');
                navigateAndReplacementAll(context, const ShopLoginHome());
              },
              icon: const Icon(Icons.logout),iconSize: 30,)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Container(
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.grey),
                //   borderRadius: BorderRadius.circular(20),
                //   color: Colors.white,
                // ),
              ),
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            // Expanded(
            //   child: TextButton(
            //     style: ButtonStyle(
            //         overlayColor: MaterialStateProperty.all(
            //             Colors.red.withOpacity(0.1))),
            //     onPressed: () {
            //       SharedPreferencesCache.removeValue(key: 'token');
            //       navigateAndReplacementAll(
            //           context, const ShopLoginHome());
            //     },
            //     child: Row(
            //       mainAxisSize: MainAxisSize.min,
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: const [
            //         Icon(
            //           Icons.logout,
            //           color: Colors.redAccent,
            //           size: 30,
            //         ),
            //         SizedBox(
            //           width: 10,
            //         ),
            //         Text(
            //           'LogOut',
            //           style: TextStyle(
            //               color: Colors.redAccent, fontSize: 19),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
