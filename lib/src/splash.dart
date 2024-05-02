import 'package:flutter/material.dart';
import 'package:pixabay/config/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut);
    _animationController.addListener(() => setState(() {}));
    _animationController.forward().whenComplete(
        () => Navigator.pushReplacementNamed(context, Routes.searchScreen));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Hero(
      tag: "pixabay",
      child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          height: _animation.value * 120,
          width: _animation.value * 120,
          child: Image.asset("assets/images/pixabay.png")),
    )));
  }
}
