import 'package:flutter/foundation.dart';
import 'package:shop_app/models/cart_item.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items;

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount{
    return _items == null ? 0 : _items.length;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(productId, (value) =>
          CartItem(id: value.id,
              title: value.title,
              quantity: value.quantity + 1,
              price: value.price));
    }
    else {
      _items.putIfAbsent(productId,
              () =>
              CartItem(id: DateTime.now().toString(),
                  title: title,
                  quantity: 1,
                  price: price));
    }
    notifyListeners();
  }
}
