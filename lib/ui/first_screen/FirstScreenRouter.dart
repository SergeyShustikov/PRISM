import 'package:flutter/material.dart';
import 'package:my_app/ui/second_screen/SecondScreen.dart';

import '../../Core.dart' as core;

class FirstScreenRouter extends core.Router {
  void navigateToSecondScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return SecondScreen();
    }));
  }
}
