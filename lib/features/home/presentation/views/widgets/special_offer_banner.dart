import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/functions/show_image.dart';
import 'package:stylish/core/utils/app_assets.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';

class SpecialOfferBanner extends StatelessWidget {
  const SpecialOfferBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 85.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.background,
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //* --- Left Side: Special Offer Logo ---
          showImage(image: Assets.imagesSpecialOffer, fit: BoxFit.contain),

          SizedBox(width: 24.w),

          //* --- Right Side: Text Content ---
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                //* --- Title and Emoji Badge Row ---
                Row(
                  children: [
                    // Title
                    Text(
                      'Special Offers',
                      style: AppTextStyles.medium16.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(width: 8.0.w),

                    // Circular Emoji Badge
                    Container(
                      alignment: Alignment.center,
                      height: 20.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text('😱', style: TextStyle(fontSize: 10.sp)),
                    ),
                  ],
                ),
                SizedBox(height: 4.0.h),

                //* --- Subtitle Description ---
                Text(
                  'We make sure you get the offer you need at best prices',
                  style: AppTextStyles.light12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
