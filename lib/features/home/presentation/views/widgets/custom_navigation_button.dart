import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/features/home/presentation/views/widgets/horizontal_product_list.dart';

class CustomNavigationButton extends StatelessWidget {
  const CustomNavigationButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      //* Circular navigation button used for horizontal list movement
      child: Container(
        width: HorizontalProductListState.buttonSize.r,
        height: HorizontalProductListState.buttonSize.r,

        decoration: BoxDecoration(
          shape: BoxShape.circle,

          color: AppColors.onPrimary.withOpacity(
            0.5,
          ), // Semi-transparent glass effect

          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withOpacity(0.05),
              blurRadius: 4.r,
              spreadRadius: 1.r,
            ),
          ],
        ),

        child: Icon(
          icon,
          size: HorizontalProductListState.iconSize.r,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
