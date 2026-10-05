import 'package:bookly_app/core/assets/assets.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/features/favorites/presentation/manager/favorites_cubit/favorites_cubit.dart';
import 'package:bookly_app/features/favorites/presentation/manager/favorites_cubit/favorites_state.dart';
import 'package:bookly_app/features/home/data/models/book_details_model/book_details_model.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/presentation/manager/book_details_cubit/book_details_cubit.dart';
import 'package:bookly_app/features/home/presentation/manager/book_details_cubit/book_details_state.dart';
import 'package:bookly_app/features/home/presentation/manager/similar_books_cubit/similar_books_cubit.dart';
import 'package:bookly_app/features/home/presentation/manager/similar_books_cubit/similar_books_state.dart';
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
          child: BlocBuilder<BookDetailsCubit, BookDetailsState>(
            builder: (context, state) {
              if (state is BookDetailsLoading) {
                return const Padding(
                  padding: EdgeInsets.all(40),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (state is BookDetailsFailure) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(state.errMessage),
                );
              }

              if (state is BookDetailsSuccess) {
                return _BookDetailsContent(
                  book: book,
                  bookDetails: state.bookDetails,
                );
              }

              return const SizedBox();
            },
          ),
        ),
        SliverToBoxAdapter(
          child: BlocBuilder<SimilarBooksCubit, SimilarBooksState>(
            builder: (context, state) {
              if (state is SimilarBooksSuccess) {
                return SimilarBooksListView(books: state.books);
              }

              if (state is SimilarBooksFailure) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(state.errMessage),
                );
              }

              return const Padding(
                padding: EdgeInsets.all(30),
                child: Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 30)),
      ],
    );
  }
}

class _BookDetailsContent extends StatelessWidget {
  final BookModel book;
  final BookDetailsModel bookDetails;

  const _BookDetailsContent({required this.book, required this.bookDetails});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                        return Image.asset(Assets.testImage, fit: BoxFit.cover);
                      },
                    )
                  : Image.asset(Assets.testImage, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 28),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  book.title ?? 'Unknown Title',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Styles.textStyle20.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, state) {
                  final isFavorite = context.read<FavoritesCubit>().isFavorite;

                  return IconButton(
                    onPressed: () {
                      context.read<FavoritesCubit>().toggleFavorite(book);
                    },
                    icon: Icon(
                      isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: isFavorite ? Colors.red : null,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            book.authorName != null && book.authorName!.isNotEmpty
                ? book.authorName!.first
                : 'Unknown Author',
            textAlign: TextAlign.center,
            style: Styles.textStyle16.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          _BookInfo(bookDetails: bookDetails),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'You may also like',
              style: Styles.textStyle18.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _BookInfo extends StatelessWidget {
  final BookDetailsModel bookDetails;

  const _BookInfo({required this.bookDetails});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (bookDetails.numberOfPages != null)
          _InfoRow(
            icon: Icons.menu_book_rounded,
            title: 'Pages',
            value: '${bookDetails.numberOfPages}',
          ),
        if (bookDetails.subjects != null && bookDetails.subjects!.isNotEmpty)
          _InfoRow(
            icon: Icons.category_outlined,
            title: 'Category',
            value: bookDetails.subjects!.first,
          ),
        if (bookDetails.description != null &&
            bookDetails.description!.isNotEmpty) ...[
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'About this book',
              style: Styles.textStyle18.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            bookDetails.description!,
            style: Styles.textStyle14.copyWith(
              color: Colors.grey.shade700,
              height: 1.6,
            ),
          ),
        ],
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            '$title: ',
            style: Styles.textStyle14.copyWith(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Styles.textStyle14,
            ),
          ),
        ],
      ),
    );
  }
}
