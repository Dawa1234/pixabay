import 'package:pixabay/src/pages/favorite_screen/favorite_screen.dart';
import 'package:pixabay/src/pages/search_screen/search_screen.dart';
import 'package:pixabay/src/splash.dart';

class Routes {
  static const String initialScreen = "/";
  static const String searchScreen = "/searchScreen";
  static const String favoriteScreen = "/favoriteScreen";

  static final getRoutes = <String, Function>{
    initialScreen: (arguments) => const SplashScreen(),
    searchScreen: (arguments) => const SearchScreen(),
    favoriteScreen: (arguments) => const FavoriteScreen(),
  };
}
