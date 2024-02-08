import 'package:flutter/material.dart';

import '../../main.dart';

class SearchProvider extends ChangeNotifier {
  String? mov;

  Future<void> fetchDataFromPrefs() async {
    String? storedmovie = prefs.getString('movie');
    if (storedmovie != null) {
      mov = storedmovie;
      print(mov);
      notifyListeners(); // Notify listeners about the change
    }
  }
}