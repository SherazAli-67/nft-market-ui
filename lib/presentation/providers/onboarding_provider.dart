import 'package:flutter/foundation.dart';

class OnboardingProvider extends ChangeNotifier {
  int _pageIndex = 1;
  bool _isNextPressed = false;

  int get pageIndex => _pageIndex;

  bool get isNextPressed => _isNextPressed;

  void setPageIndex(int index) {
    if (_pageIndex == index) return;
    _pageIndex = index;
    notifyListeners();
  }

  void nextPage({required int pageCount}) {
    if (_pageIndex >= pageCount - 1) return;
    _pageIndex++;
    notifyListeners();
  }

  void setNextPressed(bool value) {
    if (_isNextPressed == value) return;
    _isNextPressed = value;
    notifyListeners();
  }
}
