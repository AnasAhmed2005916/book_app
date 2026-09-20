import 'package:bookly_app/core/utils/service_locator.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/data/repos/home_repo_impl.dart';
import 'package:bookly_app/features/home/presentation/manager/similar_books_cubit/similar_books_cubit.dart';
import 'package:bookly_app/features/home/presentation/views/widgets/book_details_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDetailsView extends StatelessWidget {
  final BookModel book;

  const BookDetailsView({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SimilarBooksCubit(getIt.get<HomeRepoImpl>())
            ..fetchSimilarBooks(book.subjects?.first ?? 'programming'),
      child: Scaffold(
        body: SafeArea(child: BookDetailsViewBody(book: book)),
      ),
    );
  }
}
