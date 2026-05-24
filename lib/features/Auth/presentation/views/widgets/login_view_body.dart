import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/widgets/custom_button.dart';
import 'package:stylish/features/Auth/presentation/views/widgets/create_an_account_widget.dart';
import 'package:stylish/features/Auth/presentation/views/widgets/forget_password_text_widget.dart';
import 'package:stylish/features/Auth/presentation/views/widgets/login_form_widget.dart';
import 'package:stylish/features/Auth/presentation/views/widgets/social_accounts_widgets.dart';
import 'package:stylish/features/Auth/presentation/views/widgets/title_screen_widget.dart';
import 'package:stylish/generated/l10n.dart';

class LoginViewBody extends StatelessWidget {
  LoginViewBody({super.key});
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 30.w),
      child: Column(
        children: [
          // Title
          SizedBox(height: 20.h),
          TitleScreenWidget(title: S.of(context).welcomeBack),

          //Form
          SizedBox(height: 36.h),
          LoginFormWidget(formKey: formKey),

          // Forget Password text
          SizedBox(height: 9.h),
          ForgetPasswordTextWidget(),

          // Login Button
          SizedBox(height: 52.h),
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
          SizedBox(height: 75.h),
          SocialAccountsWidget(),

          // Create an account
          SizedBox(height: 30.h),
          CreateAnAccountTextWidget(),
        ],
      ),
    );
  }
}
