import 'package:get_it/get_it.dart';
import 'package:salla/features/categories/data/repositories/categories_repo_imp.dart';
import 'package:salla/features/categories/domain/repositories/categories_repo.dart';
import 'package:salla/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:salla/features/favorites/data/repositories/favorites_repo_impl.dart';
import 'package:salla/features/favorites/domain/repositories/favorite_repo.dart';
import 'package:salla/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:salla/features/home/data/repositories/home_page_repo_imp.dart';
import 'package:salla/features/home/domain/repositories/home_page_repo.dart';
import 'package:salla/features/home/presentation/bloc/home_bloc.dart';
import 'package:salla/features/login/data/repositories/shop_login_repo_imp.dart';
import 'package:salla/features/login/domain/repositories/shop_login_repo.dart';
import 'package:salla/features/login/presentation/bloc/shop_login_bloc.dart';
import 'package:salla/features/search/data/repositories/search_repo_impl.dart';
import 'package:salla/features/search/domain/repositories/search_repo.dart';
import 'package:salla/features/search/presentation/bloc/search_bloc.dart';
import 'package:salla/features/settings/data/repositories/settings_repo_imp.dart';
import 'package:salla/features/settings/domain/repositories/settings_repo.dart';
import 'package:salla/features/settings/presentation/bloc/settings_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Repositories
  sl.registerLazySingleton<ShopLoginRepo>(() => ShopLoginRepoImp());
  sl.registerLazySingleton<HomePageRepo>(() => HomePageRepoImp());
  sl.registerLazySingleton<CategoriesRepo>(() => CategoriesRepoImp());
  sl.registerLazySingleton<FavoritesRepo>(() => FavoritesRepoImp());
  sl.registerLazySingleton<SettingsRepo>(() => SettingsRepoImp());
  sl.registerLazySingleton<SearchRepo>(() => SearchRepoImpl());

  //UseCases

  //Blocs
  sl.registerFactory(() => ShopLoginBloc(shopLoginRepo: sl()));
  sl.registerFactory(() => HomeBloc(homePageRepo: sl()));
  sl.registerFactory(() => CategoriesBloc(categoriesRepo: sl()));
  sl.registerFactory(() => FavoritesBloc(favoritesRepo: sl()));
  sl.registerFactory(() => SettingsBloc(settingsRepo: sl()));
  sl.registerFactory(() => SearchBloc(searchRepo: sl()));
}
