import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/features/home/presentation/widgets/product_grid_view.dart';
import 'package:salla/features/search/presentation/bloc/search_bloc.dart';

class SearchLayout extends StatefulWidget {
  const SearchLayout({Key? key}) : super(key: key);

  @override
  State<SearchLayout> createState() => _SearchLayoutState();
}

class _SearchLayoutState extends State<SearchLayout> {
  var searchBloc;

  @override
  void initState() {
    searchBloc = SearchBloc.get(context);
    searchBloc.add(SearchProductsEvent(text: 'iphone'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return state is SearchLoadedSuccessState
              ? ProductGridView(
                  products: state.searchProduct.products,
                  physics: const BouncingScrollPhysics(),
                )
              : Container();
        },
      ),
    );
  }
}
