import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/functions/show_image.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/core/widgets/custom_outlined_button.dart';

class PromoBannerCardItem extends StatelessWidget {
  const PromoBannerCardItem({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),

      // --- Small space between the cards ---
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Stack(
          children: [
            // --- Full Background image ---
            Positioned.fill(
              child: showImage(image: image, fit: BoxFit.cover),
            ),
            // --- content (text and button) ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
                  CustomOutlinedButton(
                    onViewAllPressed: () {},
                    title: 'Shop Now',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
