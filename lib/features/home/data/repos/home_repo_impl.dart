import 'package:bookly_app/core/errors/failures.dart';
import 'package:bookly_app/core/utils/api_service.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/data/repos/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;

  HomeRepoImpl(this.apiService);

  Future<Either<Failure, List<BookModel>>> fetchNewestBooks() async {
    try {
      var data = await apiService.get(
        endPoint: 'search.json?q=programming&sort=new&limit=20',
      );

      List<BookModel> books = [];

      for (var item in data['docs']) {
        books.add(BookModel.fromJson(item));
      }

      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<BookModel>>> fetchFeaturedBooks() async {
    try {
      var data = await apiService.get(
        endPoint: 'search.json?q=programming&limit=20',
      );

      List<BookModel> books = [];

      for (var item in data['docs']) {
        books.add(BookModel.fromJson(item));
      }

      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<BookModel>>> fetchSimilarBooks(
    String subject,
  ) async {
    try {
      var data = await apiService.get(
        endPoint: 'search.json?subject=$subject&limit=10',
      );

      List<BookModel> books = [];

      for (var item in data['docs']) {
        books.add(BookModel.fromJson(item));
      }

      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookModel>>> fetchSearchBooks(
    String query,
    int page,
  ) async {
    try {
      var data = await apiService.get(
        endPoint:
            'search.json?q=${Uri.encodeQueryComponent(query)}&limit=20&page=$page',
      );

      List<BookModel> books = [];

      for (var item in data['docs']) {
        books.add(BookModel.fromJson(item));
      }

      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure(e.toString()));
    }
  }
}
