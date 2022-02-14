import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salla/core/data/remote_data_source.dart';
import 'package:salla/core/style/themes.dart';
import 'package:salla/features/login/data/repositories/shop_login_repo_imp.dart';
import 'package:salla/features/login/domain/repositories/shop_login_repo.dart';
import 'package:salla/features/onBoarding/presentation/pages/onBoarding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ShopLoginRepoImp shopLoginRepo =ShopLoginRepoImp();
  DioHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: OnBoarding());
  }
}
