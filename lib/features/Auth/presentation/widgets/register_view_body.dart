import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/routing/app_routes.dart';
import 'package:stylish/core/widgets/custom_button.dart';
import 'package:stylish/features/Auth/presentation/widgets/custom_title_screen_widget.dart';
import 'package:stylish/features/Auth/presentation/widgets/lower_text_widget.dart';
import 'package:stylish/features/Auth/presentation/widgets/register_form_widget.dart';
import 'package:stylish/features/Auth/presentation/widgets/register_subtitle_text_widget.dart';
import 'package:stylish/features/Auth/presentation/widgets/social_accounts_widgets.dart';
import 'package:stylish/generated/l10n.dart';

class RegisterViewBody extends StatelessWidget {
  RegisterViewBody({super.key});
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return
    // --- Horizontal Padding around the page ---
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        children: [
          // --- Title ---
          SizedBox(height: 20.h),
          CustomTitleScreenWidget(title: S.of(context).createAnAccount),

          // --- Form ---
          SizedBox(height: 30.h),
          RegisterFormWidget(formKey: formKey),

          // --- Subtitle text ---
          SizedBox(height: 20.h),
          RegisterSubtitleTextWidget(),

          // --- Register Button ---
          SizedBox(height: 40.h),
          CustomButton(onPressed: () {}, title: S.of(context).createAnAccount),

          // --- Social Login ---
          SizedBox(height: 40.h),
          SocialAccountsWidget(),

          // --- Go To Login Page ---
          SizedBox(height: 30.h),
          LowerTextWidget(
            normalText: "I Already Have An Account",
            boldText: "Login",
            pageRoute: AppRoutes.kLoginView,
          ),
        ],
      ),
    );
  }
}
