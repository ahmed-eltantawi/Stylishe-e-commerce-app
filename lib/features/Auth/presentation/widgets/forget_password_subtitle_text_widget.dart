import 'package:flutter/material.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/generated/l10n.dart';

class ForgetPasswordSubtitleTextWidget extends StatelessWidget {
  const ForgetPasswordSubtitleTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "*",
        style: AppTextStyles.regular12,
        children: [
          TextSpan(
            text: " ${S.of(context).forgetPasswordSubtitle}",
            style: AppTextStyles.regular12.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
