import 'package:bloc_pattern/bloc/book_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/book_bloc.dart';
import 'book_club_home_page.dart';

void main() {
  runApp(BookClubApp());
}

class BookClubApp extends StatelessWidget {
  const BookClubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Club',
      home: BlocProvider(
        create: (_) => BookBloc()..add(LoadBooksByAuthor()),
        child: BookClubHomePage(),
      ),
    );
  }
}
