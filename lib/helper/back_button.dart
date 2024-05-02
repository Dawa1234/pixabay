import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  final Function()? onPressed;
  const AppBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed ?? () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }
}
