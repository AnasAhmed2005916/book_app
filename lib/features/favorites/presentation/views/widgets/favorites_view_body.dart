import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/features/favorites/presentation/manager/favorites_cubit/favorites_cubit.dart';
import 'package:bookly_app/features/favorites/presentation/manager/favorites_cubit/favorites_state.dart';
import 'package:bookly_app/features/favorites/presentation/views/widgets/favorite_book_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FavoritesViewBody extends StatelessWidget {
  const FavoritesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is FavoritesEmpty) {
          return const _EmptyFavoritesWidget();
        }

        if (state is FavoritesFailure) {
          return Center(
            child: Text(state.errMessage, textAlign: TextAlign.center),
          );
        }

        if (state is FavoritesSuccess) {
          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: state.books.length,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 14);
            },
            itemBuilder: (context, index) {
              final book = state.books[index];

              return FavoriteBookListItem(
                book: book,
                onTap: () async {
                  await context.push(AppRouter.kBookDetailsView, extra: book);

                  if (context.mounted) {
                    context.read<FavoritesCubit>().getFavorites();
                  }
                },
                onFavoriteTap: () async {
                  await context.read<FavoritesCubit>().removeFavorite(book);
                },
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}

class _EmptyFavoritesWidget extends StatelessWidget {
  const _EmptyFavoritesWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border_rounded,
                size: 40,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'No favorite books yet',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              'Books you add to your favorites will appear here.',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
