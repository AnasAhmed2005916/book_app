import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';

abstract class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<BookModel> books;

  const SearchSuccess(this.books);
}

class SearchLoadingMore extends SearchState {}

class SearchFailure extends SearchState {
  final String errMessage;

  const SearchFailure(this.errMessage);
}

class SearchEmpty extends SearchState {}
