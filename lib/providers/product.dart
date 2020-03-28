import 'dart:convert';

import 'package:My_Shop/models/http_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus() async {
    final url = 'https://myshopflutter-8902d.firebaseio.com/products/$id.json';
    var oldFavorite = isFavorite;
    _setFavValue(!isFavorite);

    final response = await http.patch(
      url,
      body: json.encode({
        'isFavorite': isFavorite,
      }),
    );

    if (response.statusCode >= 400) {
      _setFavValue(oldFavorite);
      throw HttpException('Error on favorite');
    }
    oldFavorite = null;
  }
}
