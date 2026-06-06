import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_assets.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/features/home/data/category_model.dart';
import 'package:stylish/features/home/presentation/views/widgets/category_item_widget.dart';

class CategoriesBar extends StatelessWidget {
  const CategoriesBar({super.key});

  final List<CategoryItemModel> categories = const [
    CategoryItemModel(image: Assets.imagesAppIcon, title: "Beauty"),
    CategoryItemModel(image: Assets.imagesAppIcon, title: "Fashion"),
    CategoryItemModel(image: Assets.imagesAppIcon, title: "Kids"),
    CategoryItemModel(image: Assets.imagesAppIcon, title: "Mens"),
    CategoryItemModel(image: Assets.imagesAppIcon, title: "Womens"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),

      child: Row(
        children: [
          // this for loop will make a row of categories items
          for (int i = 0; i < categories.length; i++) ...[
            Expanded(child: CategoryItemWidget(categoryItem: categories[i])),

            // it make sure that the last item doesn't have margin
            if (i < categories.length - 1) SizedBox(width: 16.w),
          ],
        ],
      ),
    );
  }
}
