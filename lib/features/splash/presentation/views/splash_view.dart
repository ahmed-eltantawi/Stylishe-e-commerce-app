import 'package:flutter/material.dart';
import 'package:stylish/generated/l10n.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(S.of(context).login)));
  }
}
