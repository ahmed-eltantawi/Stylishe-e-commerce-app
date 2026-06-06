import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/functions/show_image.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/features/home/data/category_model.dart';

class CategoryItemWidget extends StatelessWidget {
  /// This widget is used to display a category item in the categories bar. Image and title.
  const CategoryItemWidget({super.key, required this.categoryItem});

  final CategoryItemModel categoryItem;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // --- Image ---
        showImage(image: categoryItem.image),

        // --- Space ---
        SizedBox(height: 4.h),

        // --- Title ---
        Text(categoryItem.title, style: AppTextStyles.regular10),
      ],
    );
  }
}
