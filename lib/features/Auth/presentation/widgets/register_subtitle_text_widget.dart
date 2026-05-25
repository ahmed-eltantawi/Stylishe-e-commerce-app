import 'package:flutter/material.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';

class RegisterSubtitleTextWidget extends StatelessWidget {
  const RegisterSubtitleTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text.rich(
        TextSpan(
          text: 'By clicking the ',
          style: AppTextStyles.regular12.copyWith(
            color: AppColors.textHint,
            fontWeight: FontWeight.w600,
          ),
          children: [
            TextSpan(
              text: 'Register',
              style: AppTextStyles.regular12.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const TextSpan(text: ' button, you agree\n to the public offer'),
          ],
        ),
      ),
    );
  }
}
