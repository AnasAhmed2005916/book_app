import 'package:bookly_app/core/utils/api_service.dart';
import 'package:bookly_app/features/favorites/data/datasources/favorites_local_data_source.dart';
import 'package:bookly_app/features/favorites/data/repos/favorites_repo_impl.dart';
import 'package:bookly_app/features/home/data/repos/home_repo_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));

  getIt.registerSingleton<HomeRepoImpl>(HomeRepoImpl(getIt.get<ApiService>()));

  getIt.registerSingleton<FavoritesLocalDataSource>(FavoritesLocalDataSource());

  getIt.registerSingleton<FavoritesRepoImpl>(
    FavoritesRepoImpl(getIt.get<FavoritesLocalDataSource>()),
  );
}
