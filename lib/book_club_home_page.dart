import 'package:bloc_pattern/bloc/book_event.dart';
import 'package:bloc_pattern/bloc/book_state.dart';
import 'package:bloc_pattern/book_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/book_bloc.dart';

class BookClubHomePage extends StatefulWidget {
  @override
  _BookClubHomePageState createState() => _BookClubHomePageState();
}

class _BookClubHomePageState extends State<BookClubHomePage> {
  String selectedSortOption = 'Author';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Club Home'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Sort by:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 10),
                ChoiceChip(
                  label: Text('Author'),
                  selected: selectedSortOption == 'Author',
                  onSelected: (isSelected) {
                    setState(() {
                      selectedSortOption = 'Author';
                      context.read<BookBloc>().add(LoadBooksByAuthor());
                    });
                  },
                ),
                SizedBox(width: 10),
                ChoiceChip(
                  label: Text('Title'),
                  selected: selectedSortOption == 'Title',
                  onSelected: (isSelected) {
                    setState(() {
                      selectedSortOption = 'Title';
                      context.read<BookBloc>().add(LoadBooksByTitle());
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Books',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: BlocBuilder<BookBloc, BookState>(
              builder: (context, state) {
                if (state is BooksLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is BooksLoaded) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: state.books.map((book) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BookDetailPage(book: book),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: 120,
                                  height:
                                      160, // Increased height to make the books taller
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      book.imageAssetPath ??
                                          'assets/images/default_image.jpg',
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey,
                                          child: Center(
                                            child: Text(
                                              'Image Not Found',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: 8), // Space between image and title
                                Text(
                                  book.title,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                } else if (state is BooksError) {
                  return Center(child: Text(state.error));
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
