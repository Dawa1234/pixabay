import 'package:pixabay/src/splash.dart';

class Routes {
  static const String initialScreen = "/";
  static const String search = "/searchScreen";
  static const String favorite = "/favoriteScreen";

  static final getRoutes = <String, Function>{
    initialScreen: (arguments) => const SplashScreen()
  };
}
