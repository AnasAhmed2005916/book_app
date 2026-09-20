import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:flutter/material.dart';

class CustomListViewItem extends StatelessWidget {
  final BookModel book;

  const CustomListViewItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.8 / 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(
              'https://covers.openlibrary.org/b/id/${book.coverId}-L.jpg',
            ),
          ),
        ),
      ),
    );
  }
}
