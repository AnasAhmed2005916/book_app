import 'package:bookly_app/features/favorites/data/repos/favorites_repo.dart';
import 'package:bookly_app/features/favorites/presentation/manager/favorites_cubit/favorites_state.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this.favoritesRepo) : super(FavoritesInitial());

  final FavoritesRepo favoritesRepo;

  List<BookModel> books = [];
  bool isFavorite = false;

  Future<void> getFavorites() async {
    emit(FavoritesLoading());

    try {
      final favorites = await favoritesRepo.getFavorites();

      if (favorites.isEmpty) {
        books = [];
        emit(FavoritesEmpty());
      } else {
        books = favorites;
        emit(FavoritesSuccess(books));
      }
    } catch (e) {
      emit(FavoritesFailure(e.toString()));
    }
  }

  Future<void> toggleFavorite(BookModel book) async {
    if (book.key == null) return;

    try {
      if (isFavorite) {
        await favoritesRepo.removeFavorite(book.key!);
        isFavorite = false;
      } else {
        await favoritesRepo.addFavorite(book.copyWith(isFavorite: true));
        isFavorite = true;
      }

      emit(FavoriteStatusChanged(isFavorite));
    } catch (e) {
      emit(FavoriteActionFailure(e.toString()));
    }
  }

  Future<void> checkFavorite(String key) async {
    isFavorite = await favoritesRepo.isFavorite(key);
    emit(FavoriteStatusChanged(isFavorite));
  }

  Future<void> removeFavorite(BookModel book) async {
    if (book.key == null) return;

    try {
      await favoritesRepo.removeFavorite(book.key!);
      await getFavorites();
    } catch (e) {
      emit(FavoritesFailure(e.toString()));
    }
  }
}
