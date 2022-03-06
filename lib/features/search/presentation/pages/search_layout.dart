import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/core/widgets/custom_text_form_field.dart';
import 'package:salla/features/home/presentation/widgets/product_grid_view.dart';
import 'package:salla/features/search/presentation/bloc/search_bloc.dart';

class SearchLayout extends StatefulWidget {
  const SearchLayout({Key? key}) : super(key: key);

  @override
  State<SearchLayout> createState() => _SearchLayoutState();
}

class _SearchLayoutState extends State<SearchLayout> {
  var searchBloc;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    searchBloc = SearchBloc.get(context);
     searchBloc.add(SearchProductsEvent(text: ''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CustomTextFormField(
                  textEditingController: searchController,
                  label: 'Search',
                  onSubmitted: (value) => searchBloc
                      .add(SearchProductsEvent(text: searchController.text)),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      searchBloc.add(
                          SearchProductsEvent(text: searchController.text));
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                state is SearchLoadedSuccessState
                    ? Expanded(
                        child: ProductGridView(
                          products: state.searchProduct.products,
                          physics: const BouncingScrollPhysics(),
                        ),
                      )
                    : const LinearProgressIndicator()
              ],
            ),
          );
        },
      ),
    );
  }
}
