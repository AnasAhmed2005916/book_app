import 'package:bookly_app/features/favorites/data/datasources/favorites_local_data_source.dart';
import 'package:bookly_app/features/favorites/data/repos/favorites_repo.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';

class FavoritesRepoImpl implements FavoritesRepo {
  final FavoritesLocalDataSource localDataSource;

  FavoritesRepoImpl(this.localDataSource);

  @override
  Future<void> addFavorite(BookModel book) {
    return localDataSource.addFavorite(book);
  }

  @override
  Future<void> removeFavorite(String key) {
    return localDataSource.removeFavorite(key);
  }

  @override
  Future<List<BookModel>> getFavorites() {
    return localDataSource.getFavorites();
  }

  @override
  Future<bool> isFavorite(String key) {
    return localDataSource.isFavorite(key);
  }
}
