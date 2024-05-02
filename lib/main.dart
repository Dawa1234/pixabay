import 'package:flutter/material.dart';
import 'package:pixabay/config/routes/generated_route.dart';
import 'package:pixabay/config/theme/theme.dart';
import 'package:pixabay/service/http_execute_api.dart';
import 'package:pixabay/service/server_config.dart';

void main() {
  // runZonedGuarded(() {
  // }, (error, stack) {
  //   log(error.toString());
  // });
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AppWrapper());
}

class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  _bootServer() {
    HttpExecuter.init(LiveServerConfig());
  }

  @override
  void initState() {
    super.initState();
    _bootServer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: CustomThemeData.themeData(),
        onGenerateRoute: GeneratedRoute.onGeneratedRoute);
  }
}
