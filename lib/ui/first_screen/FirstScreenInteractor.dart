import 'package:my_app/ui/first_screen/FirstScreenRouter.dart';
import 'package:provider/provider.dart';

import '../../Core.dart';

class FirstScreenInteractor extends Interactor<FirstScreenRouter> {
  ChangeNotifierProvider<FirstProvider> provider;
  @override
  void activate() {
    // The type of ChangeNotifierProvider should be pointed!!!
    // Otherwise you'll get a runtime error
    providers.add(
      ChangeNotifierProvider<FirstProvider>(
        create: (_) {
          return FirstProvider();
        },
      ),
    );
  }

  @override
  void deactivate() {
    // dispose whatever you need
  }

  void navigateToSecondScreen() {
    // maybe you need to save something, but for this example we just open new screen
    router.navigateToSecondScreen();
  }

  @override
  FirstScreenRouter router = FirstScreenRouter();
}
