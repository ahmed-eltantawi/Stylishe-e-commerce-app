import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/core/routing/app_routes.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';

class CreateAnAccountTextWidget extends StatelessWidget {
  const CreateAnAccountTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      children: [
        Text(
          "Create An Account? ",
          style: AppTextStyles.regular14.copyWith(fontWeight: FontWeight.w600),
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
    );
  }
}
