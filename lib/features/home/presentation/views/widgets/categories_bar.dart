import 'package:flutter/material.dart';
import 'package:stylish/core/utils/app_assets.dart';
import 'package:stylish/features/home/presentation/views/widgets/category_item_widget.dart';

class CategoriesBar extends StatelessWidget {
  const CategoriesBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return CategoryItemWidget(
          image: Assets.screensPlaceOrder,
          title: "Beauty",
        );
      }),
    );
  }
}
