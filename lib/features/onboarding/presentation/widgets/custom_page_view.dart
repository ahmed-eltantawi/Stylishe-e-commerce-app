// import 'package:flutter/material.dart';
// import 'package:stylish/core/utils/app_assets.dart';
// import 'package:stylish/features/onboarding/presentation/models/onboarding_model.dart';
// import 'package:stylish/features/onboarding/presentation/widgets/onboarding_item.dart';

// class CustomPageView extends StatelessWidget {
//   const CustomPageView({super.key, required this.pageViewController});

//   final PageController pageViewController;
//   final List<OnboardingModel> onboardingItems = const [
//     OnboardingModel(
//       image: Assets.imagesOnBoarding1,
//       title: 'Choose Products',
//       description:
//           'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
//     ),
//     OnboardingModel(
//       image: Assets.imagesOnBoarding2,
//       title: 'Make Payment',
//       description:
//           'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
//     ),
//     OnboardingModel(
//       image: Assets.imagesOnBoarding3,
//       title: 'Get Your Order',
//       description:
//           'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return
//     PageView(
//       controller: pageViewController,
//       children: List.generate(
//         onboardingItems.length,
//         (index) => OnboardingItem(onboardingModel: onboardingItems[index]),
//       ),
//     );
//   }
// }
