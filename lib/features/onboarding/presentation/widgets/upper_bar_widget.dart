import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/config/routing/app_routes.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/generated/l10n.dart';

class UpperBarWidget extends StatelessWidget {
  const UpperBarWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 22.h,
      child: Row(
        children: [
          // changed num
          Text("$index", style: AppTextStyles.semiBold18),
          // /3
          Text(
            "/3",
            style: AppTextStyles.semiBold18.copyWith(
              color: context.textSecondary,
            ),
          ),

          // spacer
          Spacer(),
          // skip
          GestureDetector(
            onTap: () => context.go(AppRoutes.kLoginView),
            child: Text(S.of(context).skip, style: AppTextStyles.semiBold18),
          ),
        ],
      ),
    );
  }
}
