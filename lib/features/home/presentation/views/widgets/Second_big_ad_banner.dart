import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/functions/show_image.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/core/widgets/custom_square_button.dart';

class SecondBigAdBanner extends StatelessWidget {
  const SecondBigAdBanner({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12.r),
              topLeft: Radius.circular(12.r),
            ),
            child: showImage(image: image, fit: BoxFit.cover),
          ),
          Container(
            padding: EdgeInsets.all(8.w),
            height: 70.h,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.medium20),
                    Text(
                      subtitle,
                      style: AppTextStyles.medium16.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                SizedBox(
                  height: 30.h,
                  width: 90.w,
                  child: CustomSquareButton(
                    onPressed: onPressed,
                    title: "View all",
                  ),
                ),

                SizedBox(width: 4.w),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
