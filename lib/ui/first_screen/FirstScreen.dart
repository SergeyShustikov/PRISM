import 'package:flutter/material.dart';
import 'package:my_app/ui/first_screen/FirstScreenInteractor.dart';
import 'package:my_app/ui/first_screen/FirstScreenRouter.dart';

import '../../Core.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends Screen<FirstScreenInteractor> {
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("This is first screen"),
            TextButton(
              onPressed: () {
                interactor.navigateToSecondScreen();
              },
              child: Text("Go to second screen"),
            )
          ],
        ),
      ),
    );
  }

  @override
  FirstScreenInteractor interactor = FirstScreenInteractor();
}
