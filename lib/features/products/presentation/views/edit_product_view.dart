import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/core/functions/show_snack_bar_function.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/features/categories/data/models/category_model.dart';
import 'package:stylish/features/categories/presentation/manager/get_categories_cubit/get_categories_cubit.dart';
import 'package:stylish/features/products/data/models/create_product_request.dart';
import 'package:stylish/features/products/presentation/manager/edit_product_cubit/edit_product_cubit.dart';
import 'package:stylish/features/products/presentation/views/widgets/product_form_widget.dart';
// TODO: consider extracting to a shared/core model if more features need it
import 'package:stylish/features/home/data/models/product_model/product_model.dart';

class EditProductView extends StatefulWidget {
  const EditProductView({super.key, required this.product});

  final ProductModel product;

  @override
  State<EditProductView> createState() => _EditProductViewState();
}

class _EditProductViewState extends State<EditProductView> {
  @override
  void initState() {
    super.initState();
    context.read<GetCategoriesCubit>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text('Edit Product', style: AppTextStyles.semiBold18),
        centerTitle: true,
      ),
      body: BlocConsumer<EditProductCubit, EditProductState>(
        listener: (context, state) {
          if (state is EditProductSuccess) {
            showSnackBar(context, message: 'Product updated successfully');
            context.pop();
          } else if (state is EditProductFailure) {
            showSnackBar(context, message: state.errorMessage);
          }
        },
        builder: (context, editState) {
          final isLoading = editState is EditProductLoading;

          return BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
            builder: (context, catState) {
              if (catState is GetCategoriesLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }

              List<CategoryModel> categories = [];
              if (catState is GetCategoriesSuccess) {
                categories = catState.categories;
              }

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding:
                    EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: ProductFormWidget(
                  categories: categories,
                  isLoading: isLoading,
                  submitLabel: 'Update Product',
                  initialProduct: widget.product,
                  onSubmit: (CreateProductRequest request) {
                    context.read<EditProductCubit>().editProduct(
                          id: widget.product.id.toInt(),
                          request: request,
                        );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
