import 'package:flutter/foundation.dart';

class OnboardingProvider extends ChangeNotifier {
  int _pageIndex = 1;

  int get pageIndex => _pageIndex;

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
}
