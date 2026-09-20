import 'package:bookly_app/core/assets/assets.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/presentation/manager/similar_books_cubit/similar_books_cubit.dart';
import 'package:bookly_app/features/home/presentation/manager/similar_books_cubit/similar_books_state.dart';
import 'package:bookly_app/features/home/presentation/views/widgets/book_rating.dart';
import 'package:bookly_app/features/home/presentation/views/widgets/books_action_widget.dart';
import 'package:bookly_app/features/home/presentation/views/widgets/custom_book_details_app_bar.dart';
import 'package:bookly_app/features/home/presentation/views/widgets/similar_books_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDetailsViewBody extends StatelessWidget {
  final BookModel book;

  const BookDetailsViewBody({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: CustomBookDetailsAppBar()),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              children: [
                Container(
                  height: 330,
                  width: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 25,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: book.coverId != null
                        ? Image.network(
                            'https://covers.openlibrary.org/b/id/${book.coverId}-L.jpg',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                Assets.testImage,
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        : Image.asset(Assets.testImage, fit: BoxFit.cover),
                  ),
                ),

                const SizedBox(height: 28),

                Text(
                  book.title ?? 'Unknown Title',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Styles.textStyle20.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  book.authorName?.first ?? 'Unknown Author',
                  textAlign: TextAlign.center,
                  style: Styles.textStyle16.copyWith(color: Colors.grey),
                ),

                const SizedBox(height: 12),

                const BookRating(),

                const SizedBox(height: 24),

                const BooksAction(),

                const SizedBox(height: 30),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'You may also like',
                    style: Styles.textStyle18.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: BlocBuilder<SimilarBooksCubit, SimilarBooksState>(
            builder: (context, state) {
              if (state is SimilarBooksSuccess) {
                return SimilarBooksListView(books: state.books);
              } else if (state is SimilarBooksFailure) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(state.errMessage),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.all(30),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 30)),
      ],
    );
  }
}
