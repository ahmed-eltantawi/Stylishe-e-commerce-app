import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final IconData icon;
  final bool isPassword;
  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 1.w, color: AppColors.border),
      borderRadius: BorderRadius.circular(10.r),
    );

    return TextFormField(
      decoration: InputDecoration(
        fillColor: AppColors.disabled,
        hint: Text(hintText, style: AppTextStyles.medium12),
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        prefixIcon: Icon(size: 24.sp, icon, color: AppColors.textHint),
      ),
    );
  }
}
