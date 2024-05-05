import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book_model.dart';


class Api {
  static const String baseUrl = 'https://softwium.com/api';

  static Future<List<Book>> getAllBooks() async {
    try {
      var response = await http.get(Uri.parse('$baseUrl/books'));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<Book> books = [];
        for (var item in jsonData) {
          books.add(Book.fromJson(item));
        }
        return books;
      } else {
        throw Exception('Failed to fetch all books: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching all books: $e');
    }
  }
  static Future<Book?> getBookById(int id) async {
    try {
      var response = await http.get(Uri.parse('$baseUrl/books/$id'));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        return Book.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        print('Book with id $id not found');
        return null;
      } else {
        throw Exception('Failed to fetch book with id $id: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching book with id $id: $e');
    }
  }
}
