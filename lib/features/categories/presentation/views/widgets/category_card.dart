import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/features/categories/data/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  final CategoryModel category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Category Image
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(12.r),
                ),
                child: category.image.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: category.image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                                color: AppColors.primary)),
                        errorWidget: (context, url, error) =>
                            _buildPlaceholder(),
                      )
                    : _buildPlaceholder(),
              ),
            ),

            // Category Name
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: Text(
                category.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppTextStyles.semiBold14.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.surfaceVariant,
      child: Icon(Icons.category_outlined, color: AppColors.border, size: 36.r),
    );
  }
}
