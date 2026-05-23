import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_assets.dart';
import 'package:stylish/features/onboarding/presentation/models/onboarding_model.dart';
import 'package:stylish/features/onboarding/presentation/widgets/onboarding_item.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  final List<OnboardingModel> onboardingItems = const [
    OnboardingModel(
      image: Assets.imagesOnBoarding1,
      title: 'Choose Products',
      description:
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
    OnboardingModel(
      image: Assets.imagesOnBoarding2,
      title: 'Make Payment',
      description:
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
    OnboardingModel(
      image: Assets.imagesOnBoarding3,
      title: 'Get Your Order',
      description:
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 22.h,
            child: Row(
              children: [
                // changed num

                // /3

                // spacer

                // skip
              ],
            ),
          ),
          // Page view
          Expanded(
            child: PageView(
              children: List.generate(
                onboardingItems.length,
                (index) =>
                    OnboardingItem(onboardingModel: onboardingItems[index]),
              ),
            ),
          ),
          //
          SizedBox(
            height: 27.h,
            width: double.infinity,
            child: Row(
              children: [
                // prv if it available

                // the slider

                // next and get started
              ],
            ),
          ),
        ],
      ),
    );
  }
}
