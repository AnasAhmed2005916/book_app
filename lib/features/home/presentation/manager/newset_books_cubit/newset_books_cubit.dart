import 'package:bookly_app/features/home/data/repos/home_repo.dart';
import 'package:bookly_app/features/home/presentation/manager/newset_books_cubit/newset_books_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsetBooksCubit extends Cubit<NewsetBooksState> {
  NewsetBooksCubit(this.homeRepo) : super(NewsetBooksInitial());
  final HomeRepo homeRepo;
  Future<void> fetchNewsetBooks() async {
    emit(NewsetBooksLoading());
    var result = await homeRepo.fetchNewestBooks();
    result.fold(
      (failure) {
        emit(NewsetBooksFailure(failure.errMessage));
      },
      (books) {
        emit(NewsetBooksSuccess(books));
      },
    );
  }
}
