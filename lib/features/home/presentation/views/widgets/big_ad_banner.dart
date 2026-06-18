import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/functions/show_image.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/core/widgets/custom_square_button.dart';

class BigAdBanner extends StatelessWidget {
  const BigAdBanner({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.action,
  });
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return Container(
      // banner width
      width: double.infinity,

      // banner height
      height: 172.h,

      // banner background color and border
      decoration: BoxDecoration(
        color: AppColors.greyBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),

      // banner layout
      child: Stack(
        children: [
          // --- background image section ---
          Positioned.fill(
            child: ClipRRect(
              // Apply border radius to all corners so the image respects the container bounds
              borderRadius: BorderRadius.circular(12.r),
              child: showImage(image: image, fit: BoxFit.cover),
            ),
          ),

          // --- right side text and button section ---
          Row(
            children: [
              Spacer(flex: 3),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // title text
                      Text(
                        title,
                        style: AppTextStyles.medium16.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),

                      // spacing
                      SizedBox(height: 8.h),

                      // subtitle text
                      Text(
                        subtitle,
                        style: AppTextStyles.regular10,
                        textAlign: TextAlign.right,
                      ),

                      // space between text and button
                      SizedBox(height: 10.h),

                      // bottom button
                      Align(
                        alignment: .centerRight,
                        child: CustomSquareButton(
                          onPressed: action,
                          title: 'Visit now',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
