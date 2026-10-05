import 'package:bookly_app/features/favorites/presentation/views/favorites_view.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/presentation/views/book_details_view.dart';
import 'package:bookly_app/features/home/presentation/views/home_view.dart';
import 'package:bookly_app/features/search/presentation/views/search_view.dart';
import 'package:bookly_app/features/splash/presentation/views/splash_view.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kHomeView = '/homeView';
  static const kBookDetailsView = '/bookDetailsView';
  static const kSearchView = '/searchView';
  static const kFavoritesView = '/favorites';
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(path: kHomeView, builder: (context, state) => const HomeView()),
      GoRoute(
        path: kBookDetailsView,
        builder: (context, state) {
          final book = state.extra as BookModel;

          return BookDetailsView(book: book);
        },
      ),
      GoRoute(
        path: kSearchView,
        builder: (context, state) => const SearchView(),
      ),

      GoRoute(
        path: kFavoritesView,
        builder: (context, state) => const FavoritesView(),
      ),
    ],
  );
}
