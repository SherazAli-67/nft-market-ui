import 'package:flutter/foundation.dart';

class CollectionProvider extends ChangeNotifier {
  int _selectedTabIndex = 0;
  bool _isWatchlisted = false;

  int get selectedTabIndex => _selectedTabIndex;

  bool get isWatchlisted => _isWatchlisted;

  void selectTab(int index) {
    if (_selectedTabIndex == index) return;
    _selectedTabIndex = index;
    notifyListeners();
  }

  void toggleWatchlist() {
    _isWatchlisted = !_isWatchlisted;
    notifyListeners();
  }
}
