import '../models/book.dart';

abstract class BookState {}

class BooksLoading extends BookState {}

class BooksLoaded extends BookState {
  final List<Book> books;

  BooksLoaded(this.books);
}

class BooksError extends BookState {
  final String error;

  BooksError(this.error);
}

//The name 'Book' isn't a type, so it can't be used as a type argument.