import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

              // app logo
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
