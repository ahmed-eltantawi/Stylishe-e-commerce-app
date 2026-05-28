import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_assets.dart';
import 'package:stylish/features/Auth/presentation/manager/user_cubit.dart';
import 'package:stylish/features/Auth/presentation/widgets/custom_text_form_field.dart';
import 'package:stylish/generated/l10n.dart';

class RegisterFormWidget extends StatelessWidget {
  const RegisterFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<UserCubit>().formKeySignup,
      child: Column(
        children: [
          //* --- Email input field ---
          CustomTextFormField(
            textInputAction: .next,
            textEditingController: context
                .read<UserCubit>()
                .emailSignupController,
            hintText: S.of(context).userNameOrEmail,
            iconAssets: Assets.personIcon,
          ),

          //* --- Password input field ---
          SizedBox(height: 30.h),
          CustomTextFormField(
            textInputAction: .next,
            textEditingController: context
                .read<UserCubit>()
                .passwordSignupController,
            isPassword: true,
            hintText: S.of(context).password,
            iconAssets: Assets.lockIcon,
          ),

          //* --- Confirm Password input field ---
          SizedBox(height: 30.h),
          CustomTextFormField(
            textInputAction: .done,
            textEditingController: context
                .read<UserCubit>()
                .confirmPasswordSignupController,
            isPassword: true,
            hintText: S.of(context).confirmPassword,
            iconAssets: Assets.lockIcon,
          ),
        ],
      ),
    );
  }
}
