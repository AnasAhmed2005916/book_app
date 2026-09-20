import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;
  Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);
  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with ApiServer');

      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with ApiServer');

      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioError.response?.statusCode,
          dioError.response,
        );

      case DioExceptionType.badCertificate:
        return ServerFailure('Bad certificate');

      case DioExceptionType.cancel:
        return ServerFailure('Request was cancelled');

      case DioExceptionType.connectionError:
        return ServerFailure('Connection error');

      case DioExceptionType.unknown:
        return ServerFailure('Unexpected error');

      case DioExceptionType.transformTimeout:
        return ServerFailure('Transform timeout');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, Response? response) {
    switch (statusCode) {
      case 400:
        return ServerFailure('Bad request');

      case 401:
        return ServerFailure('Unauthorized');

      case 403:
        return ServerFailure('Forbidden');

      case 404:
        return ServerFailure('Not found');

      case 500:
        return ServerFailure('Internal server error');

      default:
        return ServerFailure('Something went wrong');
    }
  }
}
