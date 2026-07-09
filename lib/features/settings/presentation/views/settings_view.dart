import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBackground,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('Settings', style: AppTextStyles.semiBold18),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24.r),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.settings_outlined,
                  color: AppColors.primary, size: 56.r),
            ),
            SizedBox(height: 24.h),
            Text('Coming Soon', style: AppTextStyles.semiBold18),
            SizedBox(height: 8.h),
            Text(
              'This feature is coming soon. Stay tuned!',
              style: AppTextStyles.regular14,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
