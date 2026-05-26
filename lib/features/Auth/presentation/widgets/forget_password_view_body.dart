import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/widgets/custom_button.dart';
import 'package:stylish/features/Auth/presentation/view_models/user_cubit.dart';
import 'package:stylish/features/Auth/presentation/widgets/custom_text_form_field.dart';
import 'package:stylish/features/Auth/presentation/widgets/custom_title_screen_widget.dart';
import 'package:stylish/features/Auth/presentation/widgets/forget_password_subtitle_text_widget.dart';
import 'package:stylish/generated/l10n.dart';

class ForgetPasswordViewBody extends StatelessWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 30.w),
      child: Column(
        children: [
          //* --- Title ---
          SizedBox(height: 20.h),
          CustomTitleScreenWidget(title: S.of(context).forgotPasswordTitle),

          //* --- TextFiled email ---
          SizedBox(height: 30.h),
          CustomTextFormField(
            textInputAction: .done,
            textEditingController: context
                .read<UserCubit>()
                .emailSignupController,
            hintText: S.of(context).enterYourEmailAddress,
            prefixIcon: Icons.email_rounded,
          ),

          //* --- subtitle text ---
          SizedBox(height: 25.h),
          ForgetPasswordSubtitleTextWidget(),

          //* --- Submit Button ---
          SizedBox(height: 40.h),
          CustomButton(title: S.of(context).submit, onPressed: () {}),
        ],
      ),
    );
  }
}
