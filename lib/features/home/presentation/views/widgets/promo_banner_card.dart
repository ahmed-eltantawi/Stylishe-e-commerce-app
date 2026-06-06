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

  @override
  Widget build(BuildContext context) {
    const bannerColor = Color(0xFFF97199);

    return Column(
      children: [
        // --- the Advertisement ---
        SizedBox(
          height: 190.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: 3, // the number of cards
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w),

                // --- Small space between the cards ---
                decoration: BoxDecoration(
                  color: bannerColor,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Stack(
                    children: [
                      // --- image ---
                      Positioned(
                        right: 0,
                        bottom: 0,
                        top: 0,
                        child: Image.asset(
                          //TODO: change this with the image
                          Assets.imagesAppIcon,
                          fit: BoxFit.contain,
                        ),
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
                            Text(
                              '50-40% OFF',
                              style: AppTextStyles.semiBold20.copyWith(
                                fontWeight: .w700,
                              ),
                            ),
                            // --- text ---
                            SizedBox(height: 8.h),

                            Text(
                              'Now in (product)\nAll colours',
                              style: AppTextStyles.regular12.copyWith(
                                color: AppColors.onPrimary.withOpacity(.7),
                              ),
                            ),
                            SizedBox(height: 12.h),

                            // --- Shop Now button ---
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5.w,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Shop Now',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 6.w),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 16.sp,
                                  ),
                                ],
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
        SizedBox(height: 12.h),
        SmoothPageIndicator(
          controller: _pageController,
          count: 3, // يجب أن يطابق الـ itemCount الخاص بالـ PageView
          effect: WormEffect(
            // تأثير الـ Worm ناعم جداً ويشبه التصميم تماماً
            activeDotColor: bannerColor,
            dotColor: Colors.grey[300]!,
            dotHeight: 8.h,
            dotWidth: 8.w,
            spacing: 8.w,
          ),
        ),
      ],
    );
  }
}
