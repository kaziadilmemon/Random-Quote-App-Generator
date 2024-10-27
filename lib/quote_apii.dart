import 'dart:convert';
import 'package:http/http.dart' as http;
import 'quote.dart';

class QuoteApiService {
  final String baseUrl = 'https://api.quotable.io';

  Future<Quote?> fetchRandomQuote() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/random'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Quote(
          data['_id'],
          data['content'],
          data['author'],
          0,
        );
      }
    } catch (e) {
      print('Error fetching random quote: $e');
    }
    return null;
  }
}
