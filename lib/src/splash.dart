import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pixabay/infrastructure/endpoints.dart';
import 'package:pixabay/infrastructure/repo/http_repo_impl.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: InkWell(
                onTap: () async {
                  try {
                    final data = await HttpRepoImpl().fetchApiData(
                        path: UrlConst.SEARCH_IMAGE,
                        query: {"key": "43661498-ffa56af4d2575e5d3f0232aeca"});
                    log(data);
                  } catch (e) {
                    log(e.toString());
                  }
                },
                child: const Text("SplashScreen"))));
  }
}
