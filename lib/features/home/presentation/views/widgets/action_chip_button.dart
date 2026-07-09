import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';

class ActionChipButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final double width = 70;
  final double height = 25;

  const ActionChipButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Apply responsive defaults here so the constructor remains const
    final buttonWidth = width.w;
    final buttonHeight = height.h;

    return Material(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.4),
      borderRadius: BorderRadius.circular(6.r), // Responsive radius
      child:
          // we use InkWell to add a ripple effect instead of a GestureDetector
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(6.r),
            child: SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  // --- text ---
                  Text(
                    label,
                    style: AppTextStyles.regular12.copyWith(
                      color: context.textPrimary,
                    ),
                  ),

                  SizedBox(width: 4.w),

                  // --- icon ---
                  Icon(icon, size: 16.sp, color: context.textPrimary),
                ],
              ),
            ),
          ),
    );
  }
}
