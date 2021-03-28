import 'package:flutter/material.dart';
import 'package:my_app/ui/first_screen/FirstScreen.dart';

import 'HomeWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: FirstScreen(),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
    );
  }
}
