import 'package:flutter/material.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        children: [
          Row(
            children: [
              // changed num

              // /3

              // spacer

              // skip
            ],
          ),
          // Page view

          //
          Row(
            children: [
              // prv if it available

              // the slider

              // next and get started
            ],
          ),
        ],
      ),
    );
  }
}
