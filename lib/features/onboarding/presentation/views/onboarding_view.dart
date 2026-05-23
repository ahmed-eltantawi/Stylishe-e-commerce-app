import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/features/onboarding/presentation/widgets/custom_page_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late PageController pageViewController;
  int index = 1;

  @override
  initState() {
    pageViewController = PageController();
    pageViewController.addListener(() {
      index = pageViewController.page!.round() + 1;
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
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 22.h,
            child: Row(
              children: [
                // changed num
                Text("$index", style: AppTextStyles.semiBold18),
                // /3

                // spacer

                // skip
              ],
            ),
          ),
          // Page view
          Expanded(
            child: CustomPageView(pageViewController: pageViewController),
          ),
          SizedBox(
            height: 27.h,
            width: double.infinity,
            child: Row(
              children: [
                // prv if it available

                // the slider

                // next and get started
              ],
            ),
          ),
        ],
      ),
    );
  }
}
