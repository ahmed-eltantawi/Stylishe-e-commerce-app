import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/generated/l10n.dart';

class RegisterSubtitleTextWidget extends StatelessWidget {
  const RegisterSubtitleTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 120.w,
            child: Text.rich(
              TextSpan(
                text: '${S.of(context).signUpSubtitle1} ',
                style: AppTextStyles.regular12.copyWith(
                  color: AppColors.textHint,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(
                    text: S.of(context).register,
                    style: AppTextStyles.regular12.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(text: ' ${S.of(context).signUpSubtitle2}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
