import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/core/data/local_data_source/shared_preferences.dart';
import 'package:salla/core/widgets/navigator.dart';
import 'package:salla/features/categories/presentation/pages/categories_page.dart';
import 'package:salla/features/favorites/presentation/pages/FavoriteScreen.dart';
import 'package:salla/features/home/data/models/home_model.dart';
import 'package:salla/features/home/data/repositories/home_page_repo_imp.dart';
import 'package:salla/features/home/presentation/pages/product_Screen.dart';
import 'package:salla/features/login/presentation/pages/login_page.dart';
import 'package:salla/features/settings/presentation/pages/settings_layout.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomePageRepoImp homePageRepoImp;

  HomeBloc({required this.homePageRepoImp}) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is ChangeBottomBarItemEvent) {
        bottomNavigatorIndex = event.index;
        emit(BottomNavigatorItemState());
      }
      if (event is GetHomePageDataEvent) {
        emit(HomePageDataIsLoading());
        try {
          homeData = await homePageRepoImp.getHomeData();
          for (var e in homeData!.data.products) {
          }
          emit(HomePageDataSuccess(homeData: homeData));
        } catch (error) {
          HomePageDataError();
        }
      }

      // TODO: implement event handler
    });
  }

  HomeModel? homeData;

  static HomeBloc get(context) => BlocProvider.of(context);
  int bottomNavigatorIndex = 0;

  AppBar getAppBar(BuildContext context , int index){
    List<AppBar> appBar = [AppBar(),AppBar(),AppBar(),AppBar(
      elevation: 0,
      toolbarHeight: 100,
      centerTitle: false,
      // systemOverlayStyle: const SystemUiOverlayStyle().copyWith(statusBarColor: Colors.blueAccent),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  const [
          Text(
            'Settings',
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

      actions: [
        IconButton(
          padding: const EdgeInsets.only(right: 10),
          onPressed: () {},
          icon: const Icon(Icons.edit),
          iconSize: 30,
        ),
        IconButton(
          padding: const EdgeInsets.only(right: 10),
          onPressed: () {
            SharedPreferencesCache.removeValue(key: 'token');
            navigateAndReplacementAll(context, const ShopLoginHome());
          },
          icon: const Icon(Icons.logout),
          iconSize: 30,
        ),
      ],
    )];
    return appBar[index];
  }
  List<BottomNavigationBarItem> bottomNavigatorItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];
  List<Widget> bottomNavigatorScreens = const [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
}
