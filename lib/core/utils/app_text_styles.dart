import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_colors.dart';

abstract class AppTextStyles {
  static TextStyle extraBold24 = TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: 24.sp,
    color: AppColors.textPrimary,
  );
  static TextStyle semiBold18 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18.sp,
    color: AppColors.textPrimary,
  );
  static TextStyle semiBold20 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20.sp,
  );
  static TextStyle semiBold14 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14.sp,
    color: AppColors.textSecondary,
  );

  static TextStyle medium12 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12.sp,
  );

  static TextStyle regular12 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
  );
  static TextStyle regular14 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
  );

  static TextStyle bold36 = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 36.sp,
  );
}
