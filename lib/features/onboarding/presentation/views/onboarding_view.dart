import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/core/routing/app_routes.dart';
import 'package:stylish/core/utils/app_assets.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/features/onboarding/presentation/models/onboarding_model.dart';
import 'package:stylish/features/onboarding/presentation/widgets/onboarding_item.dart';
import 'package:stylish/features/onboarding/presentation/widgets/upper_bar_widget.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late PageController pageViewController;
  int pageNumber = 1;

  final List<OnboardingModel> onboardingItems = const [
    OnboardingModel(
      image: Assets.imagesOnBoarding1,
      title: 'Choose Products',
      description:
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
    OnboardingModel(
      image: Assets.imagesOnBoarding2,
      title: 'Make Payment',
      description:
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
    OnboardingModel(
      image: Assets.imagesOnBoarding3,
      title: 'Get Your Order',
      description:
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
  ];

  @override
  initState() {
    pageViewController = PageController();
    pageViewController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: .symmetric(horizontal: 17.w),
          child: Column(
            children: [
              // upper bar
              UpperBarWidget(index: pageNumber),
              // Page view
              Expanded(
                child: PageView(
                  controller: pageViewController,
                  onPageChanged: (value) =>
                      setState(() => pageNumber = value + 1),
                  children: List.generate(
                    onboardingItems.length,
                    (index) =>
                        OnboardingItem(onboardingModel: onboardingItems[index]),
                  ),
                ),
              ),
              // lower bar
              SizedBox(
                height: 27.h,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // prv if it available
                    pageNumber == 1
                        ? SizedBox()
                        : GestureDetector(
                            onTap: () => pageViewController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.linear,
                            ),
                            child: Text(
                              "Prev",
                              style: AppTextStyles.semiBold18.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                    // the slider

                    // next and get started
                    GestureDetector(
                      onTap: pageNumber == onboardingItems.length
                          ? () => context.go(AppRoutes.kLoginView)
                          : () => pageViewController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.linear,
                            ),
                      child: Text(
                        pageNumber == onboardingItems.length
                            ? "Get Started"
                            : "Next",
                        style: AppTextStyles.semiBold18.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
