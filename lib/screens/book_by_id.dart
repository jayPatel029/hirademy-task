import 'package:flutter/material.dart';
import '../api/api_service.dart';
import 'screens.dart';

class GetBookByIdPage extends StatefulWidget {
  const GetBookByIdPage({Key? key});

  @override
  _GetBookByIdPageState createState() => _GetBookByIdPageState();
}

class _GetBookByIdPageState extends State<GetBookByIdPage> {
  final TextEditingController _controller = TextEditingController();
  int? _bookId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Book by ID'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return _buildMobileLayout();
          } else {
            return _buildWebLayout();
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Enter Book ID',
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _bookId = int.tryParse(value);
              });
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _getBook,
            child: const Text('Get Book'),
          ),
        ],
      ),
    );
  }

  Widget _buildWebLayout() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter Book ID',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _bookId = int.tryParse(value);
                });
              },
            ),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: _getBook,
            child: const Text('Get Book'),
          ),
        ],
      ),
    );
  }

  void _getBook() {
    if (_bookId != null) {
      Api.getBookById(_bookId!).then((book) {
        if (book != null) {
          showDialog(
            context: context,
            builder: (context) => BookDetailsDialog(
              book: book,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Book with ID $_bookId not found'),
          ));
        }
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error fetching book: $error'),
        ));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter a valid book ID'),
      ));
    }
  }
}

