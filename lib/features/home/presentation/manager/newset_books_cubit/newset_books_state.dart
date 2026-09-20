import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';

abstract class NewsetBooksState {
  const NewsetBooksState();
}

class NewsetBooksInitial extends NewsetBooksState {}

class NewsetBooksLoading extends NewsetBooksState {}

class NewsetBooksSuccess extends NewsetBooksState {
  final List<BookModel> books;
  const NewsetBooksSuccess(this.books);
}

class NewsetBooksFailure extends NewsetBooksState {
  final String errMessage;
  const NewsetBooksFailure(this.errMessage);
}
