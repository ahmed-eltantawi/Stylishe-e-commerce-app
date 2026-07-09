import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_assets.dart';
import 'package:stylish/features/Auth/presentation/manager/signin_cubit/signin_cubit.dart';
import 'package:stylish/features/Auth/presentation/widgets/custom_text_form_field.dart';
import 'package:stylish/generated/l10n.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SigninCubit>().formKeySignin,
      child: Column(
        children: [
          //* --- Email input field ---
          CustomTextFormField(
            textInputAction: .next,
            textEditingController: context
                .read<SigninCubit>()
                .emailSigninController,
            hintText: S.of(context).userNameOrEmail,
            iconAssets: Assets.iconsPerson,
          ),

          //* --- Password input field ---
          SizedBox(height: 30.h),
          CustomTextFormField(
            textInputAction: .done,
            textEditingController: context
                .read<SigninCubit>()
                .passwordSigninController,

            isPassword: true,
            hintText: S.of(context).password,
            iconAssets: Assets.iconsLock,
          ),
        ],
      ),
    );
  }
}
