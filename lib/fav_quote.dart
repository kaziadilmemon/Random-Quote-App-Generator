import 'package:flutter/material.dart';
import 'package:random_quote/quote.dart';
import 'package:random_quote/random_quotes.dart';

class FavoriteQuotesPage extends StatefulWidget {
  final RandomQuote randomQuotes;

  FavoriteQuotesPage({required this.randomQuotes});

  @override
  _FavoriteQuotesPageState createState() => _FavoriteQuotesPageState();
}

class _FavoriteQuotesPageState extends State<FavoriteQuotesPage> {
  List<Quote> filteredQuotes = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadQuotes();
  }

  Future<void> _loadQuotes() async {
    List<Quote> quotes = await widget.randomQuotes.getFavoriteQuotes();
    setState(() {
      filteredQuotes = quotes;
    });
  }

  void _filterQuotes(String searchText) {
    widget.randomQuotes.getFavoriteQuotes().then((quotes) {
      setState(() {
        filteredQuotes = quotes
            .where((quote) =>
                quote.quote.toLowerCase().contains(searchText.toLowerCase()) ||
                quote.author.toLowerCase().contains(searchText.toLowerCase()))
            .toList();
      });
    });
  }

  void _updateRating(Quote quote, int rating) async {
    setState(() {
      quote.rating = rating;
    });
    await widget.randomQuotes.updateQuote(quote);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Quotes'),
        backgroundColor: Colors.pink.shade900,
        foregroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search quotes...',
                hintStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: TextStyle(color: Colors.white),
              onChanged: _filterQuotes,
            ),
          ),
        ),
      ),
      body: filteredQuotes.isEmpty
          ? const Center(
              child: Text(
                'No favorite quotes added yet!',
                style: TextStyle(
                    fontSize: 20, color: Color.fromRGBO(136, 14, 79, 1)),
              ),
            )
          : ListView.builder(
              itemCount: filteredQuotes.length,
              itemBuilder: (context, index) {
                final quote = filteredQuotes[index];
                return Card(
                  elevation: 8,
                  surfaceTintColor: Colors.pink.shade900,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          quote.quote,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '- ' + quote.author,
                          style: const TextStyle(
                              fontSize: 16, fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: List.generate(5, (starIndex) {
                            return IconButton(
                              icon: Icon(
                                Icons.star,
                                color: starIndex < quote.rating
                                    ? Colors.yellow
                                    : Colors.grey,
                              ),
                              onPressed: () {
                                _updateRating(quote, starIndex + 1);
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
