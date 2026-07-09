import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/features/categories/data/models/category_model.dart';

/// Horizontal scrollable filter bar for filtering products by category.
/// Shows an "All" chip first, then one chip per category.
class ProductsFilterBar extends StatefulWidget {
  const ProductsFilterBar({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  final List<CategoryModel> categories;
  final void Function(int? categoryId) onCategorySelected;

  @override
  State<ProductsFilterBar> createState() => _ProductsFilterBarState();
}

class _ProductsFilterBarState extends State<ProductsFilterBar> {
  int? _selectedId; // null means "All"

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.categories.length + 1, // +1 for "All"
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildChip(label: 'All', categoryId: null);
          }
          final cat = widget.categories[index - 1];
          return _buildChip(label: cat.name, categoryId: cat.id);
        },
      ),
    );
  }

  Widget _buildChip({required String label, required int? categoryId}) {
    final isSelected = _selectedId == categoryId;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedId = categoryId);
        widget.onCategorySelected(categoryId);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.background,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 1.w,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.25),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  )
                ]
              : [],
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.semiBold14.copyWith(
              color: isSelected ? AppColors.onPrimary : AppColors.textSecondary,
              fontSize: 12.sp,
            ),
          ),
        ),
      ),
    );
  }
}
