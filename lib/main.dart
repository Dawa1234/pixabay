import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixabay/config/routes/generated_route.dart';
import 'package:pixabay/config/theme/theme.dart';
import 'package:pixabay/helper/shared_pref.dart';
import 'package:pixabay/service/http_execute_api.dart';
import 'package:pixabay/service/server_config.dart';
import 'package:pixabay/src/bloc/favorite_cubit/favorite_cubit.dart';
import 'package:pixabay/src/bloc/search_bloc/search_bloc.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SharedPref.init();
    runApp(const AppWrapper());
  }, (error, stack) {
    log(error.toString());
  });
}

class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  _bootServer() => HttpExecuter.init(LiveServerConfig());

  @override
  void initState() {
    super.initState();
    _bootServer();
  }

  @override
  Widget build(BuildContext ifcontext) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SearchBloc()),
          BlocProvider(create: (context) => FavoriteCubit()..init()),
        ],
        child: MaterialApp(
            theme: CustomThemeData.themeData(),
            debugShowCheckedModeBanner: kDebugMode,
            onGenerateRoute: GeneratedRoute.onGeneratedRoute));
  }
}
