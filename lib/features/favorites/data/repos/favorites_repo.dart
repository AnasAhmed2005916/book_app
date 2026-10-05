import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';

abstract class FavoritesRepo {
  Future<void> addFavorite(BookModel book);

  Future<void> removeFavorite(String key);

  Future<List<BookModel>> getFavorites();

  Future<bool> isFavorite(String key);
}
