import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_assets.dart';
import 'package:stylish/features/Auth/presentation/views/widgets/custom_text_form_field.dart';

class RegisterFormWidget extends StatelessWidget {
  const RegisterFormWidget({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            hintText: 'Username or Email',
            icon: Assets.personIcon,
          ),
          SizedBox(height: 30.h),
          CustomTextFormField(
            isPassword: true,
            hintText: 'Password',
            icon: Assets.lockIcon,
          ),
          SizedBox(height: 30.h),
          CustomTextFormField(
            isPassword: true,
            hintText: 'Confirm Password',
            icon: Assets.lockIcon,
          ),
        ],
      ),
    );
  }
}
