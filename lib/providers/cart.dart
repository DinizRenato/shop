import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shop/providers/product.dart';

class CartItem {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.productId,
      @required this.quantity,
      @required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {...this._items};
  }

  int get itemsCount {
    return this._items.length;
  }

  double get totalAmount {
    double total = 0.0;

    this._items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });

    return total;
  }

  void addItem(Product product) {
    if (this._items.containsKey(product.id)) {
      this._items.update(
            product.id,
            (existingItem) => CartItem(
              id: existingItem.id,
              productId: product.id,
              title: existingItem.title,
              quantity: existingItem.quantity + 1,
              price: existingItem.price,
            ),
          );
    } else {
      this._items.putIfAbsent(
            product.id,
            () => CartItem(
              id: Random().nextDouble().toString(),
              title: product.title,
              productId: product.id,
              quantity: 1,
              price: product.price,
            ),
          );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear(){
    this._items = {};
    notifyListeners();
  }
}
