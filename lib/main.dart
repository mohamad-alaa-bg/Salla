import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/core/data/remote_data_source.dart';
import 'package:salla/core/style/themes.dart';
import 'package:salla/core/util/bloc_observe.dart';
import 'package:salla/features/login/data/repositories/shop_login_repo_imp.dart';
import 'package:salla/features/login/domain/repositories/shop_login_repo.dart';
import 'package:salla/features/login/presentation/bloc/shop_login_bloc.dart';
import 'package:salla/features/onBoarding/presentation/pages/onBoarding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  BlocOverrides.runZoned(() {
    runApp(const MyApp());
  },
      blocObserver: MyBlocObserver(),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginBloc(shopLoginRepoImp: ShopLoginRepoImp()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: OnBoarding(),
      ),
    );
  }
}
