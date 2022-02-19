import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/features/home/presentation/bloc/home_bloc.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = HomeBloc.get(context);
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              bloc.add(ChangeBottomBarItemEvent(index: index));
            },
            currentIndex: bloc.bottomNavigatorIndex,
            items: bloc.bottomNavigatorItems,
          ),
          body: bloc.bottomNavigatorScreens[bloc.bottomNavigatorIndex],
        );
      },
    );
  }
}
