import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stylish/core/utils/app_colors.dart';

class PromoPageIndicator extends StatelessWidget {
  const PromoPageIndicator({
    super.key,
    required PageController pageController,
    required this.images,
  }) : _pageController = pageController;

  final PageController _pageController;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: _pageController,
      count: images.length, // the number of cards
      effect: ScaleEffect(
        activeDotColor: AppColors.activePinkIndicator,
        dotColor: AppColors.border,
        dotHeight: 8.h,
        dotWidth: 8.w,
        spacing: 5.w,
        scale: 1.4, // it's make the indicator bigger than the normal dot 40%
      ),
    );
  }
}
