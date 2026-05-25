import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_assets.dart';
import 'package:stylish/features/Auth/presentation/widgets/custom_text_form_field.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key, required this.formKey});
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
        ],
      ),
    );
  }
}
