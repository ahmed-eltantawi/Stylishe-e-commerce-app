import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
  });
  final String hintText;
  final String icon;
  final bool isPassword;
  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 1.w, color: AppColors.border),
      borderRadius: BorderRadius.circular(10.r),
    );

    return TextFormField(
      validator: (value) => value!.isEmpty ? '$hintText is required' : null,
      obscureText: isPassword,
      decoration: InputDecoration(
        fillColor: AppColors.disabled,
        hint: Text(hintText, style: AppTextStyles.medium12),
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        prefixIconConstraints: BoxConstraints(minWidth: 16.w, minHeight: 20.h),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 11.w),
          child: SizedBox(
            width: 16.w,
            height: 20.h,
            child: SvgPicture.asset(icon),
          ),
        ),
        suffixIcon: isPassword
            ? Padding(
                padding: EdgeInsets.only(right: 15.w),
                child: Icon(
                  Icons.visibility_off_outlined,
                  color: AppColors.textHint,
                ),
              )
            : null,
      ),
    );
  }
}
