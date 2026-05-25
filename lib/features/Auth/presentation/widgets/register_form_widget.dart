import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_assets.dart';
import 'package:stylish/features/Auth/presentation/view_models/user_cubit.dart';
import 'package:stylish/features/Auth/presentation/widgets/custom_text_form_field.dart';

class RegisterFormWidget extends StatelessWidget {
  const RegisterFormWidget({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          //* --- Email input field ---
          CustomTextFormField(
            textInputAction: .next,
            textEditingController: context
                .read<UserCubit>()
                .emailSignupController,
            hintText: 'Username or Email',
            icon: Assets.personIcon,
          ),

          //* --- Password input field ---
          SizedBox(height: 30.h),
          CustomTextFormField(
            textInputAction: .next,
            textEditingController: context
                .read<UserCubit>()
                .passwordSignupController,
            isPassword: true,
            hintText: 'Password',
            icon: Assets.lockIcon,
          ),

          //* --- Confirm Password input field ---
          SizedBox(height: 30.h),
          CustomTextFormField(
            textInputAction: .done,
            textEditingController: context
                .read<UserCubit>()
                .confirmPasswordSignupController,
            isPassword: true,
            hintText: 'Confirm Password',
            icon: Assets.lockIcon,
          ),
        ],
      ),
    );
  }
}
