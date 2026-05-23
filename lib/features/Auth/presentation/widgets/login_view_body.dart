import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/core/widgets/custom_button.dart';
import 'package:stylish/features/Auth/presentation/widgets/custom_text_form_field.dart';
import 'package:stylish/generated/l10n.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 30.w),
      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .start,
        children: [
          // Title
          Text(S.of(context).welcomeBack, style: AppTextStyles.bold36),
          //Form
          CustomTextFormField(
            hintText: 'Username or Email',
            icon: Icons.person,
          ),

          // Forget Password text

          // Login Button
          CustomButton(onPressed: () {}, title: S.of(context).login),

          // Social Login

          // Create an account
        ],
      ),
    );
  }
}
