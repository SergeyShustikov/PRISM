import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class FirstProvider extends ChangeNotifier {
  int count = 10;
  void increaseCount() {
    count *= 10;
    notifyListeners();
  }
}

class SecondProvider extends ChangeNotifier {
  int count = 0;
  void increaseCount() {
    count++;
    notifyListeners();
  }
}

abstract class Controller {
  List<SingleChildWidget> providers = [];

  void activate();

  void deactivate();
}

mixin ControllerChildMixin<R extends Controller, S extends Screen> {
  R getController(BuildContext context) {
    return context.findRootAncestorStateOfType<S>().controller;
  }
}

mixin Screen<W extends StatefulWidget,C extends Controller>
    on State<W> {
  @protected
  C get controller;

  @override
  void initState() {
    super.initState();
    controller.activate();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [...controller.providers],
      child: Builder(
        builder: (BuildContext context) {
          return buildWidget(context);
        },
      ),
    );
  }

  Widget buildWidget(BuildContext context);

  @override
  void dispose() {
    super.dispose();
    controller.deactivate();
  }

  @override
  void setState(fn) {
    throw Exception("setState forbidden to use directly");
  }
}

class ExampleController extends Controller {
  var firstProvider = FirstProvider();
  var secondProvider = SecondProvider();

  @override
  void activate() {
    providers
        .add(ChangeNotifierProvider<FirstProvider>.value(value: firstProvider));
    providers.add(
        ChangeNotifierProvider<SecondProvider>.value(value: secondProvider));
  }

  @override
  void deactivate() {}

  void increaseCount() {
    firstProvider.increaseCount();
    secondProvider.increaseCount();
  }
}

class ExampleScreen extends StatefulWidget {
  @override
  _ExampleScreenState createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> with Screen {
  @override
  ExampleController controller = ExampleController();
  bool init = false;
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SecondProvider>(
      builder: (context, sprovider, widget) {
        return Consumer<FirstProvider>(
          builder: (context, provider, widget) {
            return Center(
              child: DeepChildButton(firstProvider: provider, secondProvider: sprovider),
            );
          },
        );
      },
    );
  }
}

class DeepChildButton extends StatelessWidget
    with ControllerChildMixin<ExampleController, _ExampleScreenState> {
  const DeepChildButton({
    Key key,
    @required this.firstProvider,
    @required this.secondProvider,
  }) : super(key: key);

  final FirstProvider firstProvider;
  final SecondProvider secondProvider;

  @override
  Widget build(BuildContext context) {
    var controller = getController(context);

    return FlatButton(
      child: Text("${firstProvider.count} \\ ${secondProvider.count}"),
      onPressed: () {
        controller.increaseCount();
      },
    );
  }
}
