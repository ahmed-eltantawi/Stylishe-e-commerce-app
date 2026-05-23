import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';

class UpperBarWidget extends StatelessWidget {
  const UpperBarWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 22.h,
      child: Row(
        children: [
          // changed num
          Text("$index", style: AppTextStyles.semiBold18),
          // /3
          Text(
            "/3",
            style: AppTextStyles.semiBold18.copyWith(
              color: AppColors.textSecondary,
            ),
          ),

          // spacer
          Spacer(),
          // skip
          Text("Skip", style: AppTextStyles.semiBold18),
        ],
      ),
    );
  }
}
