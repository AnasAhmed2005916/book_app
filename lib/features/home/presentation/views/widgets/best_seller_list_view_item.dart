import 'package:bookly_app/core/assets/assets.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BestSellerListViewItem extends StatelessWidget {
  final BookModel book;

  const BestSellerListViewItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(AppRouter.kBookDetailsView, extra: book);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: book.coverId != null
                  ? Image.network(
                      'https://covers.openlibrary.org/b/id/${book.coverId}-L.jpg',
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          Assets.testImage,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Image.asset(
                      Assets.testImage,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            book.title ?? 'Unknown Title',
            style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            book.authorName?.first ?? 'Unknown Author',
            style: Styles.textStyle14,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            book.firstPublishYear?.toString() ?? 'Unknown Year',
            style: Styles.textStyle14.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
