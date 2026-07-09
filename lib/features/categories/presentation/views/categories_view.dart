import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/config/routing/app_routes.dart';
import 'package:stylish/core/functions/show_snack_bar_function.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/features/categories/data/models/category_model.dart';
import 'package:stylish/features/categories/presentation/manager/get_categories_cubit/get_categories_cubit.dart';
import 'package:stylish/features/categories/presentation/views/widgets/category_card.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  void initState() {
    super.initState();
    context.read<GetCategoriesCubit>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBackground,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text('Categories', style: AppTextStyles.semiBold18),
        centerTitle: true,
      ),
      body: BlocConsumer<GetCategoriesCubit, GetCategoriesState>(
        listener: (context, state) {
          if (state is GetCategoriesFailure) {
            showSnackBar(context, message: state.errorMessage);
          }
        },
        builder: (context, state) {
          if (state is GetCategoriesLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state is GetCategoriesFailure) {
            return _buildError(context, state.errorMessage);
          }

          if (state is GetCategoriesSuccess) {
            return _buildGrid(context, state.categories);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildGrid(BuildContext context, List<CategoryModel> categories) {
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async =>
          context.read<GetCategoriesCubit>().getCategories(),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 0.85,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return CategoryCard(
              category: category,
              onTap: () => context.push(
                AppRoutes.kProductsView,
                extra: {'categoryId': category.id, 'categoryName': category.name},
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: AppColors.error, size: 64.r),
          SizedBox(height: 16.h),
          Text(message,
              style: AppTextStyles.regular14, textAlign: TextAlign.center),
          SizedBox(height: 16.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary),
            onPressed: () =>
                context.read<GetCategoriesCubit>().getCategories(),
            child:
                Text('Try Again', style: AppTextStyles.semiBold14.copyWith(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
