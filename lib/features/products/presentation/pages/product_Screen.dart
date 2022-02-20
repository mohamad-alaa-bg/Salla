import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/features/home/presentation/bloc/home_bloc.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late HomeBloc bloc;
  @override
  void initState() {
    bloc = HomeBloc.get(context);
    bloc.add(GetHomePageDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => current is HomePageDataSuccess,
      builder: (context, state) {
        if (state is HomePageDataIsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HomePageDataSuccess) {
          bloc.oldHomeData = state.homeData;
          return Center(
            child: Text(state.homeData.status.toString()),
          );
        }
        return Container();
      },
    );
  }
}
