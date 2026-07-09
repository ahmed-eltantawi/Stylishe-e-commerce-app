import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_assets.dart';
import 'package:stylish/features/home/presentation/views/widgets/promo_banner_card_item.dart';
import 'package:stylish/features/home/presentation/views/widgets/promo_page_indicator.dart';

class PromoBannerCardPageView extends StatefulWidget {
  const PromoBannerCardPageView({super.key});

  @override
  State<PromoBannerCardPageView> createState() =>
      _PromoBannerCardPageViewState();
}

class _PromoBannerCardPageViewState extends State<PromoBannerCardPageView> {
  // pageView controller
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose(); // remove the controller from the memory
    super.dispose();
  }

  final List<String> images = const [
    Assets.imagesPromoBannerCard1,
    Assets.imagesPromoBannerCard2,
    Assets.imagesPromoBannerCard3,
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //* --- Promo Banner Card ---
        SizedBox(
          height: 190.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: images.length, // the number of cards
            itemBuilder: (context, index) {
              return PromoBannerCardItem(image: images[index]);
            },
          ),
        ),

        //* --- Indicator ---
        SizedBox(height: 16.h),
        PromoPageIndicator(pageController: _pageController, images: images),
      ],
    );
  }
}
