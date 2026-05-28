import 'package:flutter/material.dart';
import 'package:stylish/core/utils/app_assets.dart';
import 'package:stylish/features/onboarding/data/models/onboarding_model.dart';
import 'package:stylish/generated/l10n.dart';

class OnboardingItemsList {
  final BuildContext context;
  OnboardingItemsList({required this.context});

  List<OnboardingModel> onboardingItems() {
    return [
      OnboardingModel(
        image: Assets.imagesOnBoarding1,
        title: S.of(context).chooseProductsTitle,
        description: S.of(context).chooseProductsSubtitle,
      ),
      OnboardingModel(
        image: Assets.imagesOnBoarding2,
        title: S.of(context).makePaymentTitle,
        description: S.of(context).makePaymentSubtitle,
      ),
      OnboardingModel(
        image: Assets.imagesOnBoarding3,
        title: S.of(context).getYourOrder,
        description: S.of(context).getYourOrderSubtitle,
      ),
    ];
  }
}
