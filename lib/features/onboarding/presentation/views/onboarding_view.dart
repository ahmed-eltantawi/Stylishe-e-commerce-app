import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/features/onboarding/data/onboarding_items_list.dart';
import 'package:stylish/features/onboarding/presentation/widgets/lower_bar_widget.dart';
import 'package:stylish/features/onboarding/presentation/widgets/onboarding_item.dart';
import 'package:stylish/features/onboarding/presentation/widgets/upper_bar_widget.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late PageController _pageViewController;
  int pageNumber = 1;

  @override
  initState() {
    _pageViewController = PageController();
    _pageViewController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onboardingItems = OnboardingItemsList(
      context: context,
    ).onboardingItems();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: .symmetric(horizontal: 17.w),
          child: Column(
            children: [
              // upper bar Widget
              UpperBarWidget(index: pageNumber),
              // Page view
              Expanded(
                child: PageView(
                  controller: _pageViewController,
                  onPageChanged: (value) =>
                      setState(() => pageNumber = value + 1),
                  children: List.generate(
                    onboardingItems.length,
                    (index) =>
                        OnboardingItem(onboardingModel: onboardingItems[index]),
                  ),
                ),
              ),

              // lower bar Widget
              LowerBarWidget(
                pageNumber: pageNumber,
                pageViewController: _pageViewController,
                onboardingItemsLength: onboardingItems.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
