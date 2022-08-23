import 'package:flutter/cupertino.dart';

class VerseProvider with ChangeNotifier {
  bool viewInfo = false;

  void surahInfo() {
    if (viewInfo == false) {
      viewInfo = true;
    } else {
      viewInfo = false;
    }
    notifyListeners();
  }

  bool isHn = false;

  void switchChange(bool val) {
    isHn = val;
    notifyListeners();
  }
}
