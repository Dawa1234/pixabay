import 'package:flutter/cupertino.dart';
import 'package:pixabay/config/routes/routes.dart';

class GeneratedRoute {
  static Route onGeneratedRoute(RouteSettings settings) => CupertinoPageRoute(
      settings: settings,
      builder: (context) =>
          Routes.getRoutes[settings.name]!(settings.arguments));
}
