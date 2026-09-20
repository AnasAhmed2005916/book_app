import 'package:bookly_app/features/search/presentation/manager/search_cubit/search_cubit.dart';
import 'package:bookly_app/features/search/presentation/manager/search_cubit/search_state.dart';
import 'package:bookly_app/features/search/presentation/views/widgets/custom_search_text_field.dart';
import 'package:bookly_app/features/search/presentation/views/widgets/search_result_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          const CustomSearchTextField(),
          const SizedBox(height: 15),
          const Text('Results', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is SearchSuccess) {
                  return SearchResultListView(books: state.books);
                }

                if (state is SearchLoadingMore) {
                  return SearchResultListView(
                    books: context.read<SearchCubit>().books,
                    isLoadingMore: true,
                  );
                }

                if (state is SearchEmpty) {
                  return const Center(child: Text('No books found'));
                }

                if (state is SearchFailure) {
                  return Center(child: Text(state.errMessage));
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
