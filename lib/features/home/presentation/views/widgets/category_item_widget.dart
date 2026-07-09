import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/functions/show_image.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/features/home/data/models/category_model.dart';
import 'package:stylish/features/home/presentation/manager/nav_cubit/nav_cubit.dart';

class CategoryItemWidget extends StatelessWidget {
  /// This widget is used to display a category item in the categories bar. Image and title.
  const CategoryItemWidget({super.key, required this.categoryItem});

  final CategoryItemModel categoryItem;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context
          .read<NavCubit>()
          .selectTabWithCategory(3, categoryItem.title),
      child: Column(
        children: [
          // --- Image ---
          ClipRRect(
            borderRadius: BorderRadius.circular(100.r),
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: Colors.grey,
                child: showImage(image: categoryItem.image, fit: BoxFit.cover),
              ),
            ),
          ),

          // --- Space ---
          SizedBox(height: 4.h),

          // --- Title ---
          Text(categoryItem.title, style: AppTextStyles.regular10),
        ],
      ),
    );
  }
}
