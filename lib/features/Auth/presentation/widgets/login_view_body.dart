import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_assets.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/core/widgets/custom_button.dart';
import 'package:stylish/features/Auth/presentation/widgets/custom_text_form_field.dart';
import 'package:stylish/features/Auth/presentation/widgets/login_form_widget.dart';
import 'package:stylish/generated/l10n.dart';

class LoginViewBody extends StatelessWidget {
  LoginViewBody({super.key});
  final GlobalKey<FormState> formKey = GlobalKey();
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
          LoginFormWidget(formKey: formKey),

          // Forget Password text

          // Login Button
          CustomButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                try {
                  // Login Method
                } catch (e) {
                  // Show Error
                }
              }
            },
            title: S.of(context).login,
          ),

          // Social Login

          // Create an account
        ],
      ),
    );
  }
}
