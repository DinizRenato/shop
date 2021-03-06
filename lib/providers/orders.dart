import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shop/providers/cart.dart';

class Order {
  final String id;
  final double total;
  final List<CartItem> products;
  final DateTime date;

  Order({this.id, this.total, this.products, this.date});
}

class Orders with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [...this._items];
  }

  int get itemsCount {
    return this._items.length;
  }

  void addOrder(Cart cart) {
    this._items.insert(
          0,
          new Order(
            id: Random().nextDouble().toString(),
            total: cart.totalAmount,
            date: DateTime.now(),
            products: cart.items.values.toList(),
          ),
        );
        notifyListeners();
  }
}
