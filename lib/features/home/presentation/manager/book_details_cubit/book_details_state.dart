import 'package:bookly_app/features/home/data/models/book_details_model/book_details_model.dart';

abstract class BookDetailsState {
  const BookDetailsState();
}

class BookDetailsInitial extends BookDetailsState {}

class BookDetailsLoading extends BookDetailsState {}

class BookDetailsSuccess extends BookDetailsState {
  final BookDetailsModel bookDetails;

  const BookDetailsSuccess(this.bookDetails);
}

class BookDetailsFailure extends BookDetailsState {
  final String errMessage;

  const BookDetailsFailure(this.errMessage);
}
