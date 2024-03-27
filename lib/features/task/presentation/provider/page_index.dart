
import 'package:flutter/material.dart' show ChangeNotifier;

class PageIndexProvider extends ChangeNotifier {
  int _pageNumber = 0;

  void setPageNumber(int number) {
    _pageNumber = number;
    notifyListeners();
  }

  int get getPageNumber => _pageNumber;
}