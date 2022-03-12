import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:salla/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:salla/features/home/presentation/bloc/home_bloc.dart';
import 'package:salla/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:salla/injection.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = HomeBloc.get(context);
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        return BlocBuilder<HomeBloc, HomeState>(

          builder: (context, state) {
            return BlocConsumer<SettingsBloc, SettingsState>(
              listener: (context, state) {
                // if(state is ChangeLanguageSuccessState){
                //   bloc.add(GetHomePageDataEvent());
                // }
              },
              builder: (context, state) {
                return Scaffold(
                  appBar: bloc.getAppBar(context, bloc.bottomNavigatorIndex),
                  bottomNavigationBar: BottomNavigationBar(
                    onTap: (index) {
                      bloc.add(ChangeBottomBarItemEvent(index: index));
                    },
                    currentIndex: bloc.bottomNavigatorIndex,
                    items: bloc.getBottomNavigatorItems(),
                  ),
                  body: bloc.bottomNavigatorScreens[bloc.bottomNavigatorIndex],
                );
              },
            );
          },
        );
      },
    );
  }
}
