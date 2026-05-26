import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/core/routing/app_routes.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/generated/l10n.dart';

class ForgetPasswordTextWidget extends StatelessWidget {
  const ForgetPasswordTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .centerRight,
      child: GestureDetector(
        onTap: () => context.go(AppRoutes.kForgetPasswordView),
        child: Text(
          S.of(context).forgotPassword,
          style: AppTextStyles.regular12.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
