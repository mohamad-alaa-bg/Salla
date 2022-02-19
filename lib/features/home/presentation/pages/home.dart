import 'package:flutter/material.dart';
import 'package:salla/core/data/local_data_source/shared_preferences.dart';
import 'package:salla/core/widgets/navigator.dart';
import 'package:salla/features/login/presentation/pages/login_page.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: ElevatedButton(child: const Text('Sign out'),onPressed: (){
                SharedPreferencesCache.removeValue(key: 'token').then((value) => navigateAndReplacementAll(context, const ShopLoginHome()));
        },),
      ),
    );
  }
}
