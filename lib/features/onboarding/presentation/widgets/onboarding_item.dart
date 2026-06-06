import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stylish/core/functions/show_image.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/features/onboarding/data/models/onboarding_model.dart';

class OnboardingItem extends StatelessWidget {
  const OnboardingItem({super.key, required this.onboardingModel});

  final OnboardingModel onboardingModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .center,
      children: [
        showImage(image: onboardingModel.image),
        Text(onboardingModel.title, style: AppTextStyles.extraBold24),
        SizedBox(height: 10.h),
        Text(
          onboardingModel.description,
          style: AppTextStyles.semiBold14,
          textAlign: .center,
        ),
      ],
    );
  }
}
