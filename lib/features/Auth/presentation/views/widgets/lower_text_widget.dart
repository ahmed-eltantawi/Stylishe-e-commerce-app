import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';

class LowerTextWidget extends StatelessWidget {
  const LowerTextWidget({
    super.key,
    required this.normalText,
    required this.boldText,
    required this.pageRoute,
  });
  final String normalText;
  final String boldText;
  final String pageRoute;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      children: [
        Text(
          "$normalText ",
          style: AppTextStyles.regular14.copyWith(fontWeight: FontWeight.w600),
        ),
        GestureDetector(
          onTap: () => context.go(pageRoute),
          child: Text(
            boldText,
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
