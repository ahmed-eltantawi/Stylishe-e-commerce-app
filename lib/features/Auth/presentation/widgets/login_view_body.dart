import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/core/routing/app_routes.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/core/widgets/custom_button.dart';
import 'package:stylish/features/Auth/presentation/widgets/login_form_widget.dart';
import 'package:stylish/features/Auth/presentation/widgets/social_accounts_widgets.dart';
import 'package:stylish/features/Auth/presentation/widgets/title_screen_widget.dart';
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
          Align(
            alignment: .centerRight,
            child: Text(
              S.of(context).forgetPassword,
              style: AppTextStyles.regular12.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

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
          Row(
            mainAxisAlignment: .center,
            children: [
              Text(
                "Create An Account? ",
                style: AppTextStyles.regular14.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () => context.go(AppRoutes.kRegisterView),
                child: Text(
                  "Sign Up",
                  style: AppTextStyles.semiBold14.copyWith(
                    color: AppColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
