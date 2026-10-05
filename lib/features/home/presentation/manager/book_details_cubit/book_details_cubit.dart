import 'package:bookly_app/features/home/data/repos/home_repo.dart';
import 'package:bookly_app/features/home/presentation/manager/book_details_cubit/book_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDetailsCubit extends Cubit<BookDetailsState> {
  BookDetailsCubit(this.homeRepo) : super(BookDetailsInitial());

  final HomeRepo homeRepo;

  Future<void> fetchBookDetails(String key) async {
    emit(BookDetailsLoading());

    final result = await homeRepo.fetchBookDetails(key);

    result.fold(
      (failure) {
        emit(BookDetailsFailure(failure.errMessage));
      },
      (bookDetails) {
        emit(BookDetailsSuccess(bookDetails));
      },
    );
  }
}
