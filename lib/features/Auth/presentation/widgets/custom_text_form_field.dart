import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    super.key,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    required this.textEditingController,
    required this.textInputAction,
  });
  final TextEditingController textEditingController;
  final TextInputAction textInputAction;
  final String hintText;
  final String icon;
  bool isPassword;
  IconData passwordIcon = Icons.visibility_outlined;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

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
      validator: (value) =>
          value!.isEmpty ? '${widget.hintText} is required' : null,
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
            child: SvgPicture.asset(widget.icon),
          ),
        ),

        //--- the suffix icon if it is password ---
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () => changeVisibility(),
                child: Icon(widget.passwordIcon, color: AppColors.textHint),
              )
            : null,
      ),
    );
  }

  void changeVisibility() {
    //* --- This Method changes the visibility of the password text field ---

    if (widget.passwordIcon == Icons.visibility_outlined) {
      widget.passwordIcon = Icons.visibility_off_outlined;
      obscurePassword = true;
    } else {
      widget.passwordIcon = Icons.visibility_outlined;
      obscurePassword = false;
    }

    setState(() {});
  }
}
