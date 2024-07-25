import 'package:flutter/material.dart';
import 'package:naturemedix/models/walkthrough_model.dart';
import '../utils/walkthrough_data.dart';

class WalkthroughProvider extends ChangeNotifier {
  final _featureData = FEATURE_DATA;
  int _INITIAL_PAGE = 0;
  AppFeature? _INITIAL_FEATURE;

  AppFeature get feature => _INITIAL_FEATURE ?? _featureData[0];
  int get initialPage => _INITIAL_PAGE;
  int get maxPage => _featureData.length;

  set page(int pageNumber) {
    _INITIAL_PAGE = pageNumber;
    _INITIAL_FEATURE = _featureData[_INITIAL_PAGE];
    notifyListeners();
  }

  void nextPage(PageController controller) {
    controller.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.linearToEaseOut);
    notifyListeners();
  }

  void skipAll(PageController controller) {
    controller.animateToPage(maxPage,
        duration: const Duration(seconds: 1), curve: Curves.linearToEaseOut);
    notifyListeners();
  }
}
