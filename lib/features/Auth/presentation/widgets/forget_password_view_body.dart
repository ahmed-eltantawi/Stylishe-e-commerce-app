import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/features/Auth/presentation/widgets/custom_title_screen_widget.dart';
import 'package:stylish/generated/l10n.dart';

class ForgetPasswordViewBody extends StatelessWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: .symmetric(horizontal: 30.w),
        child: Column(
          children: [
            //* --- Title ---
            SizedBox(height: 20.h),
            CustomTitleScreenWidget(title: S.of(context).forgetPassword),

            //* --- TextFiled email ---

            //* --- subtitle text ---

            //* --- Submit Button ---
          ],
        ),
      ),
    );
  }
}
