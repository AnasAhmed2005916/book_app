import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/data/repos/home_repo.dart';
import 'package:bookly_app/features/search/presentation/manager/search_cubit/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.homeRepo) : super(SearchInitial());

  final HomeRepo homeRepo;

  int currentPage = 1;
  String currentQuery = '';
  List<BookModel> books = [];

  Future<void> searchBooks(String query) async {
    if (query.trim().isEmpty) return;

    currentQuery = query.trim();
    currentPage = 1;
    books = [];

    emit(SearchLoading());

    final result = await homeRepo.fetchSearchBooks(currentQuery, currentPage);

    result.fold(
      (failure) {
        emit(SearchFailure(failure.errMessage));
      },
      (newBooks) {
        if (newBooks.isEmpty) {
          emit(SearchEmpty());
        } else {
          books = newBooks;
          emit(SearchSuccess(books));
        }
      },
    );
  }

  Future<void> loadMoreBooks() async {
    if (state is SearchLoadingMore) return;

    currentPage++;

    emit(SearchLoadingMore());

    var result = await homeRepo.fetchSearchBooks(currentQuery, currentPage);

    result.fold(
      (failure) {
        currentPage--;
        emit(SearchSuccess(books));
      },
      (newBooks) {
        books.addAll(newBooks);
        emit(SearchSuccess(books));
      },
    );
  }
}
