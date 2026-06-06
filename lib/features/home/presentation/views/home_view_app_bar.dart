import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stylish/core/functions/show_image.dart';
import 'package:stylish/core/utils/app_assets.dart';

class HomeViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .only(top: 20.h),
      child: SizedBox(
        height: 55.h,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              // menu icon
              showImage(Assets.iconsMenuIcon),

              // logo and text
              // SizedBox(
              //   width: 40.w,
              //   // height: 30.h,
              //   child: Image.asset(Assets.imagesAppIcon),
              // ),
              // Text(
              //   "Stylish",
              //   style: AppTextStyles.extraBold24.copyWith(color: Color(0xff4392F9)),
              // ),

              // ! try
              showImage(Assets.iconsAppBarLogo),

              // Avatar
              SizedBox(
                height: 40.h,
                width: 40.w,
                child: showImage(Assets.imagesAvatar),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
