import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/core/data/local_data_source/shared_preferences.dart';
import 'package:salla/core/data/remote_data_source.dart';
import 'package:salla/core/style/themes.dart';
import 'package:salla/core/util/bloc_observe.dart';
import 'package:salla/features/home/presentation/bloc/home_bloc.dart';
import 'package:salla/features/home/presentation/pages/home.dart';
import 'package:salla/features/login/data/repositories/shop_login_repo_imp.dart';
import 'package:salla/features/login/presentation/bloc/shop_login_bloc.dart';
import 'package:salla/features/login/presentation/pages/login_page.dart';
import 'package:salla/features/onBoarding/presentation/pages/onBoarding.dart';

import 'core/util/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await SharedPreferencesCache.init();

  Widget startingWidget;

  if (UserData.onBoardingState) {
    startingWidget = OnBoarding();
  } else {
    if (UserData.token.isNotEmpty) {
      startingWidget = const Home();
    } else {
      startingWidget = const ShopLoginHome();
    }
  }
  BlocOverrides.runZoned(
        () {
      runApp(
        MyApp(startingWidget: startingWidget),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.startingWidget}) : super(key: key);
  final Widget startingWidget;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ShopLoginBloc(shopLoginRepoImp: ShopLoginRepoImp()),
        ),
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: startingWidget,
      ),
    );
  }
}
