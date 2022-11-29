import 'package:flutter/material.dart';

class SearchNotifier extends ChangeNotifier {
  int _index = 0;
  int get index => _index;
  set index(int value) {
    _index = value;
    notifyListeners();
  }
}
