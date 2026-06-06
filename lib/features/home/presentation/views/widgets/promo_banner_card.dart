import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stylish/core/utils/app_assets.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';

class PromoBannerCard extends StatefulWidget {
  const PromoBannerCard({super.key});

  @override
  State<PromoBannerCard> createState() => _PromoBannerCardState();
}

class _PromoBannerCardState extends State<PromoBannerCard> {
  // pageView controller
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose(); // remove the controller from the memory
    super.dispose();
  }

  final List<String> images = const [
    Assets.imagesPromoBannerCard1,
    Assets.imagesPromoBannerCard1,
    Assets.imagesPromoBannerCard1,
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // --- the Promo Banner Cards ---
        SizedBox(
          height: 190.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: images.length, // the number of cards
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w),

                // --- Small space between the cards ---
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Stack(
                    children: [
                      // --- Full Background image ---
                      Positioned.fill(
                        child: Image.asset(images[index], fit: BoxFit.cover),
                      ),
                      // --- content (text and button) ---
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // --- title ---
                            Text(
                              '50-40% OFF',
                              style: AppTextStyles.semiBold20.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            // --- subtitle ---
                            SizedBox(height: 8.h),
                            Text(
                              'Now in (product)\nAll colours',
                              style: AppTextStyles.regular12.copyWith(
                                color: AppColors.onPrimary.withOpacity(.9),
                              ),
                            ),

                            // --- Shop Now button ---
                            SizedBox(height: 12.h),
                            InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(8.r),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 8.h,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.onPrimary,
                                    width: 1.5.w,
                                  ),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Shop Now',
                                      style: AppTextStyles.semiBold12,
                                    ),
                                    SizedBox(width: 6.w),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: AppColors.onPrimary,
                                      size: 16.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // --- Indicator ---
        SizedBox(height: 16.h),
        SmoothPageIndicator(
          controller: _pageController,
          count: images.length, // the number of cards
          effect: ScaleEffect(
            activeDotColor: AppColors.activePinkIndicator,
            dotColor: AppColors.border,
            dotHeight: 8.h,
            dotWidth: 8.w,
            spacing: 12.w,
            scale:
                1.4, // it's bigger make the indicator bigger than the normal dot
          ),
        ),
      ],
    );
  }
}
