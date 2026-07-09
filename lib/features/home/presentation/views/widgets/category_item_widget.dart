import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/config/routing/app_routes.dart';
import 'package:stylish/core/functions/show_image.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/features/categories/presentation/manager/get_categories_cubit/get_categories_cubit.dart';
import 'package:stylish/features/home/data/models/category_model.dart';

class CategoryItemWidget extends StatelessWidget {
  /// This widget is used to display a category item in the categories bar. Image and title.
  const CategoryItemWidget({super.key, required this.categoryItem});

  final CategoryItemModel categoryItem;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        int? categoryId;
        final catState = context.read<GetCategoriesCubit>().state;
        if (catState is GetCategoriesSuccess) {
          final match = catState.categories.where(
            (c) =>
                c.name.toLowerCase() == categoryItem.title.toLowerCase(),
          ).firstOrNull;
          categoryId = match?.id;
        }
        context.push(
          AppRoutes.kProductsView,
          extra: {
            'categoryId': categoryId,
            'categoryName': categoryItem.title,
          },
        );
      },
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
