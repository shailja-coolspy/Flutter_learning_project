import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavorite = false});


  void _setFavValue(bool newValue){
    isFavorite=newValue;
    notifyListeners();
  }

//If fails then it roll backs::
  Future<void> toggleFavoriteStatus(String token,String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    //we tell that something have changed:::like set satate()
    notifyListeners();
    final url = Uri.https('flutter-update-db0fa-default-rtdb.firebaseio.com',
        '/userFavourites/$userId/$id.json',{'auth':'$token'});
    try {
      final response=await http.put(url, body: json.encode(isFavorite));
      if(response.statusCode>=400){
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
