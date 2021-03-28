import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    print("_GameSceneState.build");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Switcher Sample'),
      ),
      body: BodyWidget(),
    );
  }
}

class BodyWidget extends StatefulWidget {
  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  @override
  Widget build(BuildContext context) {
    print("_BodyWidgetState.build");
    return ChangeNotifierProvider(
      create: (BuildContext context) {},
      child: Center(
        child: ButtonWidget(),
      ),
    );
  }
}

class ButtonWidget extends StatefulWidget {
  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    print("_ButtonWidgetState.build");
    return FlatButton(
      child: Text("Tap"),
      onPressed: () {
        setState(() {
          print("redraw 1");
        });
      },
    );
  }
}
