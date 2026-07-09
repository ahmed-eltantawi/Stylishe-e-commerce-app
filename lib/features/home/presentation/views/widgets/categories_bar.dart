import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/features/home/data/models/category_model.dart';
import 'package:stylish/features/home/presentation/views/widgets/category_item_widget.dart';

class CategoriesBar extends StatelessWidget {
  const CategoriesBar({super.key});

  final List<CategoryItemModel> categories = const [
    CategoryItemModel(
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRattQGASBY3b_hbfvAsoQhRNc8rC9y9GH1-DjKTnt3uJ6ae18h",
      title: "Beauty",
    ),
    CategoryItemModel(
      image:
          "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTtaKLU15BZXIsgpuI-XXTST1Cah4x5dVJD7oQFs8AnH4TgrggC",
      title: "Fashion",
    ),
    CategoryItemModel(
      image:
          "https://images.unsplash.com/photo-1566454544259-f4b94c3d758c?fm=jpg&q=60&w=3000&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA==",
      title: "Kids",
    ),
    CategoryItemModel(
      image:
          "https://m.media-amazon.com/images/S/aplus-media-library-service-media/083f345d-0792-4186-bdf9-0d6e45aba9fd.__CR1324,0,5304,5304_PT0_SX300_V1___.jpg",
      title: "Mens",
    ),
    CategoryItemModel(
      image:
          "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcR_4kPJdg13EBSvkD80XxIhN5JlUgVJiv-9c_G9m6tPXxEI0S0_",
      title: "Womens",
    ),
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
