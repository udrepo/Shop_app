import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false
      });

  void toggleFavoriteStatus() async{
    final oldStatus = isFavorite;
     isFavorite = !isFavorite;
     notifyListeners();
    final url = Uri.https(
        'test-shop-6a886-default-rtdb.firebaseio.com', '/products/$id.json');
    try{
    var response = await http.patch(url, body: json.encode({
      'isFavorite' : isFavorite
    })
    );
    if(response.statusCode >=400) _setFavStatus(oldStatus);
    }catch(error){
      _setFavStatus(oldStatus);
    }
  }

  void _setFavStatus(bool oldStatus) {
    isFavorite = oldStatus;
    notifyListeners();
  }
}
