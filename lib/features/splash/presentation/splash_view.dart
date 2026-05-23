import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/routing/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/core/utils/app_colors.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Future<void> navigateToOnboarding() async {
    await Future.delayed(const Duration(seconds: 2), () {
      context.go(AppRoutes.kOnboardingView);
    });
  }

  @override
  void initState() {
    super.initState();
    navigateToOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100.h,
              width: 125.w,
              child: Image.asset("assets/images/app_icon.png"),
            ),
            Text(
              "Stylish",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 40,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
