import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_app/ui/second_screen/SecondScreenInteractor.dart';

import '../../Core.dart';
import '../../Core.dart';

class SecondScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SecondScreenState();
}

class _SecondScreenState extends Screen<SecondScreenInteractor> {
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Second screen"),
      ),
    );
  }

  @override
  SecondScreenInteractor interactor = SecondScreenInteractor();
}
