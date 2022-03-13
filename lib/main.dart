import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/core/data/local_data_source/shared_preferences.dart';
import 'package:salla/core/data/remote_data_source.dart';
import 'package:salla/core/style/themes.dart';
import 'package:salla/core/util/bloc_observe.dart';
import 'package:salla/core/util/enum.dart';
import 'package:salla/features/categories/data/repositories/categories_repo_imp.dart';
import 'package:salla/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:salla/features/favorites/data/repositories/favorites_repo_impl.dart';
import 'package:salla/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:salla/features/home/data/models/home_model.dart';
import 'package:salla/features/home/data/repositories/home_page_repo_imp.dart';
import 'package:salla/features/home/presentation/bloc/home_bloc.dart';
import 'package:salla/features/home/presentation/pages/home_layout.dart';
import 'package:salla/features/login/data/repositories/shop_login_repo_imp.dart';
import 'package:salla/features/login/presentation/bloc/shop_login_bloc.dart';
import 'package:salla/features/login/presentation/pages/login_page.dart';
import 'package:salla/features/onBoarding/presentation/pages/onBoarding.dart';
import 'package:salla/features/search/data/repositories/search_repo_impl.dart';
import 'package:salla/features/search/presentation/bloc/search_bloc.dart';
import 'package:salla/features/settings/data/repositories/settings_repo_imp.dart';
import 'package:salla/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:salla/injection.dart';

import 'core/util/constants.dart';
import 'features/home/domain/repositories/home_page_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await DioHelper.init();
  await SharedPreferencesCache.init();

  Widget startingWidget;

  if (UserData.onBoardingState) {
    startingWidget = OnBoarding();
  } else {
    if (UserData.token.isNotEmpty) {
      startingWidget = const HomeLayout();
    } else {
      startingWidget = const ShopLoginHome();
    }
  }
  print(UserData.token);
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
        BlocProvider<ShopLoginBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => sl()..add(GetHomePageDataEvent()),
        ),
        BlocProvider<CategoriesBloc>(
          create: (context) => sl()..add(GetCategoriesEvent()),
        ),
        BlocProvider(
          create: (context) => sl<FavoritesBloc>()..add(GetFavoritesEvent()),
        ),
        BlocProvider(
          create: (context) => sl<SettingsBloc>()..add(GetSettingsEvent()),
        ),
        BlocProvider(
          create: (context) => SearchBloc(searchRepo: SearchRepoImpl()),
        ),



      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: UserData.themeMode == ThemeModeSetting.light
                ? lightTheme
                : darkTheme,
            home: Directionality(
                textDirection: UserData.language == Language.english
                    ? TextDirection.ltr
                    : TextDirection.rtl,
                child: startingWidget),
          );
        },
      ),
    );
  }
}
