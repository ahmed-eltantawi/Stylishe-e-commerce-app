import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_assets.dart';
import 'package:stylish/features/Auth/presentation/view_models/user_cubit.dart';
import 'package:stylish/features/Auth/presentation/widgets/custom_text_form_field.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<UserCubit>().formKeySignin,
      child: Column(
        children: [
          //* --- Email input field ---
          CustomTextFormField(
            textInputAction: .next,
            textEditingController: context
                .read<UserCubit>()
                .emailSigninController,
            hintText: 'Username or Email',
            iconAssets: Assets.personIcon,
          ),

          //* --- Password input field ---
          SizedBox(height: 30.h),
          CustomTextFormField(
            textInputAction: .done,
            textEditingController: context
                .read<UserCubit>()
                .passwordSigninController,

            isPassword: true,
            hintText: 'Password',
            iconAssets: Assets.lockIcon,
          ),
        ],
      ),
    );
  }
}
