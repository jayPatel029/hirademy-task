  import 'package:flutter/material.dart';
  import '../models/book_model.dart';

  class BookDetailsDialog extends StatelessWidget {
    final Book book;

    const BookDetailsDialog({super.key, required this.book});

    @override
    Widget build(BuildContext context) {
      return AlertDialog(
        title: Text(book.title),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Author(s): ${book.authors.join(', ')}'),
            Text('ISBN: ${book.isbn}'),
            Text('Page Count: ${book.pageCount}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    }
  }
