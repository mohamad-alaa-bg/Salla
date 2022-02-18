import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/core/data/local_data_source/shared_preferences.dart';
import 'package:salla/core/data/remote_data_source.dart';
import 'package:salla/core/style/themes.dart';
import 'package:salla/core/util/bloc_observe.dart';
import 'package:salla/features/login/data/repositories/shop_login_repo_imp.dart';
import 'package:salla/features/login/presentation/bloc/shop_login_bloc.dart';
import 'package:salla/features/login/presentation/pages/login_page.dart';
import 'package:salla/features/onBoarding/presentation/pages/onBoarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await SharedPreferencesCache.init();
  final bool onBoardingState =
      await SharedPreferencesCache.getValue(key: 'onBoarding');
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(onBoardingState: onBoardingState));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.onBoardingState}) : super(key: key);
  final bool onBoardingState;

  @override
  Widget build(BuildContext context) {
    print(onBoardingState);
    return BlocProvider(
      create: (context) => ShopLoginBloc(shopLoginRepoImp: ShopLoginRepoImp()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: onBoardingState ? OnBoarding() : const ShopLoginHome(),
      ),
    );
  }
}
