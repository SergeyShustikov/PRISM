import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

abstract class Router {
  BuildContext context;

  void setContext(BuildContext context) {
    this.context = context;
  }
}

class NoRouter extends Router {}

abstract class Interactor<R extends Router> {
  List<SingleChildWidget> providers = [];
  @protected
  R router;
  void activate();

  void deactivate();
}

mixin InteractorChildMixin<I extends Interactor, S extends Screen> {
  I getInteractor(BuildContext context) {
    return context.findRootAncestorStateOfType<S>().interactor;
  }
}

abstract class Screen<I extends Interactor> extends State {
  @protected
  I interactor;

  @override
  void initState() {
    super.initState();
    interactor.activate();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      interactor.router.setContext(this.context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return interactor.providers.isNotEmpty
        ? MultiProvider(
            providers: [...interactor.providers],
            child: Builder(
              builder: (BuildContext context) {
                return buildWidget(context);
              },
            ),
          )
        : Builder(
            builder: (BuildContext context) {
              return buildWidget(context);
            },
          );
  }

  Widget buildWidget(BuildContext context);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant StatefulWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
    interactor.deactivate();
  }

  @override
  void setState(fn) {
    throw Exception("setState forbidden to use directly");
  }
}
