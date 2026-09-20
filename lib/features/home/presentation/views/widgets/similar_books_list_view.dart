import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/presentation/views/widgets/similar_books_list_view_item.dart';
import 'package:flutter/material.dart';

class SimilarBooksListView extends StatelessWidget {
  final List<BookModel> books;

  const SimilarBooksListView({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: books.length,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 16);
        },
        itemBuilder: (context, index) {
          return SizedBox(
            width: 145,
            child: SimilarBooksListViewItem(book: books[index]),
          );
        },
      ),
    );
  }
}
