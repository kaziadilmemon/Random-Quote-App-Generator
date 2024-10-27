import 'dart:math';

import 'package:random_quote/database_helper.dart';

import 'quote.dart';

class RandomQuote {
  int _quoteNumber = 0;
  final List<Quote> favoriteQuotes = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> addToFavorites() async {
    final currentQuote = _quoteData[_quoteNumber];
    await _dbHelper.insertQuote(currentQuote);
  }

  Future<List<Quote>> getFavoriteQuotes() async {
    return await _dbHelper.getFavoriteQuotes();
  }

  Future<void> updateQuote(Quote quote) async {
    await _dbHelper.updateQuote(quote);
  }

  final List<Quote> _quoteData = [
    Quote(1, "No one can make you feel inferior without your consent.",
        "Eleanor Roosevelt", 0),
    Quote(
        2,
        "It is better to remain silent at the risk of being thought a fool, than to talk and remove all doubt of it.",
        "Maurice Switzer",
        0),
    Quote(
        3,
        "The fool doth think he is wise, but the wise man knows himself to be a fool.",
        " William Shakespeare",
        0),
    Quote(
        4,
        "Whenever you find yourself on the side of the majority, it is time to reform (or pause and reflect).",
        " Mark Twain ",
        0),
    Quote(5, "The only true wisdom is in knowing you know nothing.",
        " Socrates", 0),
    Quote(
        6,
        "The saddest aspect of life right now is that science gathers knowledge faster than society gathers wisdom.",
        " Isaac Asimov",
        0),
    Quote(
        7,
        "Hold fast to dreams,For if dreams die, Life is a broken-winged bird,That cannot fly.",
        "Langston Hughes",
        0),
    Quote(
        8,
        "It is the mark of an educated mind to be able to entertain a thought without accepting it.",
        " Aristotle",
        0),
    Quote(9, "Any fool can know. The point is to understand.",
        "Albert Einstein", 0),
    Quote(
        10,
        "The best index to a person's character is how he treats people who can't do him any good, and how he treats people who can't fight back.",
        " Abigail Van Buren",
        0),
    Quote(
        11,
        "There are three things all wise men fear: the sea in storm, a night with no moon, and the anger of a gentle man.",
        " Patrick Rothfuss",
        0),
    Quote(
        12,
        "By three methods we may learn wisdom: First, by reflection, which is noblest; Second, by imitation, which is easiest; and third by experience, which is the bitterest.",
        "Confucius",
        0),
    Quote(
        13,
        "In the end, it's not the years in your life that count. It's the life in your years.",
        "Abraham Lincoln",
        0),
    Quote(14, "The only way to do great work is to love what you do.",
        "Steve Jobs", 0),
    Quote(15, "You miss 100% of the shots you don't take.", "Wayne Gretzky", 0),
    Quote(16, "The journey of a thousand miles begins with one step.",
        "Lao Tzu", 0),
    Quote(
        17,
        "The only limit to our realization of tomorrow will be our doubts of today.",
        "Franklin D. Roosevelt",
        0),
    Quote(18, "Believe you can and you're halfway there.", "Theodore Roosevelt",
        0),
    Quote(
        19,
        "The future belongs to those who believe in the beauty of their dreams.",
        "Eleanor Roosevelt",
        0),
    Quote(
        20,
        "Success is not final, failure is not fatal: It is the courage to continue that counts.",
        "Winston Churchill",
        0),
    Quote(21, "In the middle of difficulty lies opportunity.",
        "Albert Einstein", 0),
  ];

  String getQuoteText() {
    return _quoteData[_quoteNumber].quote;
  }

  String getQuoteAuthor() {
    return " -- " + _quoteData[_quoteNumber].author;
  }

  void reset() {
    _quoteNumber = 0;
  }

  nextQuote() {
    int max = _quoteData.length;
    Random random = new Random();
    _quoteNumber = random.nextInt(max);
  }
}
