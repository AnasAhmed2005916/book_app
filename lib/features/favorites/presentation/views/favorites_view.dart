import 'package:bookly_app/core/utils/service_locator.dart';
import 'package:bookly_app/features/favorites/data/repos/favorites_repo_impl.dart';
import 'package:bookly_app/features/favorites/presentation/manager/favorites_cubit/favorites_cubit.dart';
import 'package:bookly_app/features/favorites/presentation/views/widgets/favorites_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FavoritesCubit(getIt.get<FavoritesRepoImpl>())..getFavorites(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          title: const Text('Favorites'),
        ),
        body: const FavoritesViewBody(),
      ),
    );
  }
}
