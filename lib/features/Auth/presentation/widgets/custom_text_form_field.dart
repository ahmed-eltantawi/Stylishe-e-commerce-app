import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/features/Auth/presentation/functions/change_visibility.dart';
import 'package:stylish/features/Auth/presentation/functions/validate_form_field.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.iconAssets,
    this.isPassword = false,
    required this.textEditingController,
    required this.textInputAction,
    this.prefixIcon,
  });
  final TextEditingController textEditingController;
  final TextInputAction textInputAction;
  final String hintText;
  final String? iconAssets;
  final IconData? prefixIcon;
  final bool isPassword;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

IconData passwordIcon = Icons.visibility_off_outlined;

bool obscurePassword = true;

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    //--- the border of the text field ---
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 1.w, color: AppColors.border),
      borderRadius: BorderRadius.circular(10.r),
    );

    //--- the text field ---
    return TextFormField(
      // controller
      controller: widget.textEditingController,

      // input Action to go to the next text field or close the keyboard
      textInputAction: widget.textInputAction,

      // validate the form field
      validator: (value) {
        validateFormField(
          value: value,
          hintText: widget.hintText,
          isPassword: widget.isPassword,
        );
        return null;
      },

      // obscure the password
      obscureText: widget.isPassword ? obscurePassword : false,
      decoration: InputDecoration(
        fillColor: AppColors.disabled,

        //--- the hint ---
        hint: Text(widget.hintText, style: AppTextStyles.medium12),

        //--- the border ---
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,

        //--- the prefix icon ---
        prefixIconConstraints: BoxConstraints(minWidth: 16.w, minHeight: 20.h),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 11.w),
          child: SizedBox(
            width: 16.w,
            height: 20.h,
            child: widget.iconAssets == null
                ? Icon(widget.prefixIcon, color: AppColors.textHint)
                : SvgPicture.asset(widget.iconAssets!),
          ),
        ),

        //--- the suffix icon if it is password ---
        suffixIcon: widget.isPassword
            // change the icon and the obscure password
            ? GestureDetector(
                onTap: () {
                  changeVisibility();
                  setState(() {});
                },
                child: Icon(passwordIcon, color: AppColors.textHint),
              )
            : null,
      ),
    );
  }
}
