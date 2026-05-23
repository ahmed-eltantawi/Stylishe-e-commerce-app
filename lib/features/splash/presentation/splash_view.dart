import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/routing/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/core/utils/app_assets.dart';
import 'package:stylish/core/utils/app_colors.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  Future<void> navigateToOnboarding() async {
    await Future.delayed(const Duration(seconds: 2), () {
      context.go(AppRoutes.kOnboardingView);
    });
  }

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  @override
  void initState() {
    super.initState();
    navigateToOnboarding();
    fadeAnimation();
  }

  void fadeAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100.h,
                width: 125.w,
                child: Image.asset(Assets.imagesAppIcon),
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
      ),
    );
  }
}
