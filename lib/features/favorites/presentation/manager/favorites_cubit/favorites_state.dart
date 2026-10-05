import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';

abstract class FavoritesState {
  const FavoritesState();
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesSuccess extends FavoritesState {
  final List<BookModel> books;

  const FavoritesSuccess(this.books);
}

class FavoritesEmpty extends FavoritesState {}

class FavoritesFailure extends FavoritesState {
  final String errMessage;

  const FavoritesFailure(this.errMessage);
}

class FavoriteActionLoading extends FavoritesState {}

class FavoriteActionSuccess extends FavoritesState {
  final String bookKey;

  const FavoriteActionSuccess(this.bookKey);
}

class FavoriteActionFailure extends FavoritesState {
  final String errMessage;

  const FavoriteActionFailure(this.errMessage);
}

class FavoriteStatusChanged extends FavoritesState {
  final bool isFavorite;

  const FavoriteStatusChanged(this.isFavorite);
}
