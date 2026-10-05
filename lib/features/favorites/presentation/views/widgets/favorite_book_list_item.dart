import 'package:bookly_app/core/assets/assets.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:flutter/material.dart';

class FavoriteBookListItem extends StatelessWidget {
  final BookModel book;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  const FavoriteBookListItem({
    super.key,
    required this.book,
    required this.onTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 130,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: book.coverId != null
                  ? Image.network(
                      'https://covers.openlibrary.org/b/id/${book.coverId}-M.jpg',
                      width: 75,
                      height: 110,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          Assets.testImage,
                          width: 75,
                          height: 110,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Image.asset(
                      Assets.testImage,
                      width: 75,
                      height: 110,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    book.title ?? 'Unknown Title',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    book.authorName != null && book.authorName!.isNotEmpty
                        ? book.authorName!.first
                        : 'Unknown Author',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onFavoriteTap,
              icon: const Icon(Icons.favorite_rounded, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
