import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stylish/core/utils/app_assets.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';

class SocialAccountsWidget extends StatelessWidget {
  const SocialAccountsWidget({super.key});
  final List<String> socialIcons = const [
    Assets.googleIcon,
    Assets.appleIcon,
    Assets.facebookIcon,
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "- OR Continue With -",
          style: AppTextStyles.medium12.copyWith(
            color: AppColors.textSecondary,
          ),
        ),

        // --- Social Login ---
        SizedBox(height: 20.h),
        SizedBox(
          width: 185.w,
          height: 55.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(socialIcons.length, (index) {
              return SvgPicture.asset(socialIcons[index]);
            }),
          ),
        ),
      ],
    );
  }
}
