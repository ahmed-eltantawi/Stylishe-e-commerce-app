import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/features/home/presentation/views/widgets/categories_bar.dart';
import 'package:stylish/features/home/presentation/views/widgets/custom_filter_bar.dart';
import 'package:stylish/features/home/presentation/views/widgets/custom_search_bar.dart';
import 'package:stylish/features/home/presentation/views/widgets/promo_banner_card.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return
    // some padding around the page
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child:
          // ListView that contains all the widgets in homebody
          Column(
            children: [
              // --- Search Bar ---
              _CustomSizedBox(),
              CustomSearchBar(textEditingController: TextEditingController()),

              // --- Filter bar ---
              _CustomSizedBox(),
              CustomFilterBar(),

              // --- Categories ---
              _CustomSizedBox(),
              CategoriesBar(),

              // --- First Advertisement ---
              _CustomSizedBox(),
              PromoBannerCard(),

              // --- deal of the day ---
              _CustomSizedBox(),

              // --- products ---
              _CustomSizedBox(),

              //  --- Special Offers ---
              _CustomSizedBox(),

              // --- Big Advertisement component ---
              _CustomSizedBox(),

              // --- Trending products ---
              _CustomSizedBox(),

              // --- products ---
              _CustomSizedBox(),

              // --- Big Advertisement component ---
              _CustomSizedBox(),

              // --- Sponsored ---
              _CustomSizedBox(),
            ],
          ),
    );
  }
}

class _CustomSizedBox extends StatelessWidget {
  /// custom sized box to make all the widgets have the same padding in upper
  const _CustomSizedBox({super.key});
  final double height = 16;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height.h);
  }
}
