import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:salla/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:salla/features/home/presentation/bloc/home_bloc.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = HomeBloc.get(context);
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        return BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: bloc.getAppBar(context, bloc.bottomNavigatorIndex),
                bottomNavigationBar: BottomNavigationBar(
                  onTap: (index) {
                    bloc.add(ChangeBottomBarItemEvent(index: index));
                  },
                  currentIndex: bloc.bottomNavigatorIndex,
                  items: bloc.bottomNavigatorItems,
                ),
                body: bloc.bottomNavigatorScreens[bloc.bottomNavigatorIndex],
              ),
            );
          },
        );
      },
    );
  }
}
