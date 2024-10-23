import 'package:flutter_bloc/flutter_bloc.dart';
import 'book_event.dart';
import 'book_state.dart';
import '../models/book.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final List<Book> _books = [
    Book(
      title: 'Walk into Shadow',
      author: 'J.D. Salinger',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
      imageAssetPath: 'assets/images/image.png',
    ),
    Book(
      title: 'Light Beyond Garden Wall',
      author: 'Meng Jin',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
      imageAssetPath: 'assets/images/beyond.png',
    ),
    Book(
      title: 'The Mothers',
      author: 'Arthur Golden',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
      imageAssetPath: 'assets/images/mother.png',
    ),
    Book(
      title: 'Never Give Up',
      author: 'F. Scott Fitzgerald',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
      imageAssetPath: 'assets/images/give.png',
    ),
    Book(
      title: 'Intution',
      author: 'George Orwell',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
      imageAssetPath: 'assets/images/int.png',
    ),
  ];

  BookBloc() : super(BooksLoading()) {
    on<LoadBooksByAuthor>(_onLoadBooksByAuthor);
    on<LoadBooksByTitle>(_onLoadBooksByTitle);
  }

  void _onLoadBooksByAuthor(LoadBooksByAuthor event, Emitter<BookState> emit) {
    try {
      final sortedBooks = List<Book>.from(_books)
        ..sort((a, b) => a.author.compareTo(b.author));
      emit(BooksLoaded(sortedBooks));
    } catch (e) {
      emit(BooksError('Failed to load books sorted by author.'));
    }
  }

  void _onLoadBooksByTitle(LoadBooksByTitle event, Emitter<BookState> emit) {
    try {
      final sortedBooks = List<Book>.from(_books)
        ..sort((a, b) => a.title.compareTo(b.title));
      emit(BooksLoaded(sortedBooks));
    } catch (e) {
      emit(BooksError('Failed to load books sorted by title.'));
    }
  }
}
