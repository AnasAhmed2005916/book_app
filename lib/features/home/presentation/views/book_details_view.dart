import 'package:bookly_app/core/utils/service_locator.dart';
import 'package:bookly_app/features/favorites/data/repos/favorites_repo_impl.dart';
import 'package:bookly_app/features/favorites/presentation/manager/favorites_cubit/favorites_cubit.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/data/repos/home_repo_impl.dart';
import 'package:bookly_app/features/home/presentation/manager/book_details_cubit/book_details_cubit.dart';
import 'package:bookly_app/features/home/presentation/manager/similar_books_cubit/similar_books_cubit.dart';
import 'package:bookly_app/features/home/presentation/views/widgets/book_details_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDetailsView extends StatelessWidget {
  final BookModel book;

  const BookDetailsView({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    print('BOOK TITLE: ${book.title}');
    print('BOOK KEY: ${book.key}');
    print('BOOK SUBJECTS: ${book.subjects}');
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              BookDetailsCubit(getIt.get<HomeRepoImpl>())
                ..fetchBookDetails(book.key!),
        ),
        BlocProvider(
          create: (context) =>
              SimilarBooksCubit(getIt.get<HomeRepoImpl>())..fetchSimilarBooks(
                book.subjects != null && book.subjects!.isNotEmpty
                    ? book.subjects!.first
                    : 'programming',
              ),
        ),
        BlocProvider(
          create: (context) =>
              FavoritesCubit(getIt.get<FavoritesRepoImpl>())
                ..checkFavorite(book.key!),
        ),
      ],
      child: Scaffold(
        body: SafeArea(child: BookDetailsViewBody(book: book)),
      ),
    );
  }
}
