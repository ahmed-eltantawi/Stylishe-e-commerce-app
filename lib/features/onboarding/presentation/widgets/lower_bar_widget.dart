import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stylish/core/utils/app_constants.dart';
import 'package:stylish/config/routing/app_routes.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/generated/l10n.dart';

class LowerBarWidget extends StatelessWidget {
  const LowerBarWidget({
    super.key,
    required this.pageNumber,
    required PageController pageViewController,
    required this.onboardingItemsLength,
  }) : _pageViewController = pageViewController;

  final int pageNumber;
  final PageController _pageViewController;
  final int onboardingItemsLength;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 27.h,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          // prv if it available
          SizedBox(
            width: 122.w,
            child: pageNumber == 1
                ? SizedBox()
                : GestureDetector(
                    onTap: () => _pageViewController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear,
                    ),
                    child: Text(
                      S.of(context).prev,
                      style: AppTextStyles.semiBold18.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
          ),

          // the Smooth Page Indicator
          SmoothPageIndicator(
            controller: _pageViewController,
            count: onboardingItemsLength,
            effect: ExpandingDotsEffect(
              activeDotColor: AppColors.textPrimary,
              dotColor: AppColors.textSecondary,
              dotHeight: 10.h,
              dotWidth: 10.w,
              expansionFactor: 4,
              spacing: 10.w,
            ),
          ),

          // next and get started
          SizedBox(
            width: 122.w,
            child: Align(
              // change alignment based on the language
              alignment: AppConstants.languageCode == 'ar'
                  ? Alignment.centerLeft
                  : Alignment.centerRight,

              child: GestureDetector(
                onTap: pageNumber == onboardingItemsLength
                    ? () => context.go(AppRoutes.kLoginView)
                    : () => _pageViewController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linear,
                      ),
                child: Text(
                  pageNumber == onboardingItemsLength
                      ? S.of(context).getStarted
                      : S.of(context).next,
                  style: AppTextStyles.semiBold18.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
