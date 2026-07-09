import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/config/routing/app_routes.dart';
import 'package:stylish/config/services/shared_preferences_service.dart';
import 'package:stylish/core/functions/show_snack_bar_function.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/features/categories/presentation/manager/get_categories_cubit/get_categories_cubit.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';
import 'package:stylish/features/products/presentation/manager/get_products_cubit/get_products_cubit.dart';
import 'package:stylish/features/products/presentation/views/widgets/products_filter_bar.dart';
import 'package:stylish/features/products/presentation/views/widgets/products_grid_item.dart';
import 'package:stylish/core/functions/get_shimmer_product.dart';
import 'package:stylish/generated/l10n.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({
    super.key,
    this.initialCategoryId,
    this.categoryName,
    this.hideBackButton = false,
  });

  final int? initialCategoryId;
  final String? categoryName;
  final bool hideBackButton;

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final TextEditingController _searchCtrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();
  int? _activeCategoryId;
  String? _searchQuery;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _activeCategoryId = widget.initialCategoryId;
    _scrollCtrl.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchProducts(title: null);
      context.read<GetCategoriesCubit>().getCategories();
    });
  }

  void _fetchProducts({int? categoryId, String? title}) {
    _activeCategoryId = categoryId ?? _activeCategoryId;
    context.read<GetProductsCubit>().fetchProducts(
          categoryId: _activeCategoryId,
          title: title ?? _searchQuery,
        );
  }

  void _onScroll() {
    if (!_scrollCtrl.hasClients) return;
    final maxScroll = _scrollCtrl.position.maxScrollExtent;
    final current = _scrollCtrl.offset;
    if (maxScroll - current <= 300) {
      context.read<GetProductsCubit>().fetchMoreProducts();
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchCtrl.dispose();
    _scrollCtrl.removeListener(_onScroll);
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = SharedPreferencesService.isLoggedIn();

    return Scaffold(
      backgroundColor: context.greyBackground,
      appBar: _buildAppBar(),
      floatingActionButton: isLoggedIn ? _buildFab(context) : null,
      body: Column(
        children: [
          // ── Search bar ─────────────────────────────────────────────
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: _buildSearchBar(),
          ),

          // ── Categories filter bar ──────────────────────────────────
          BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
            builder: (context, state) {
              if (state is GetCategoriesSuccess &&
                  state.categories.isNotEmpty) {
                return Padding(
                  padding: EdgeInsets.only(
                      left: 16.w, right: 16.w, bottom: 8.h),
                  child: ProductsFilterBar(
                    categories: state.categories,
                    onCategorySelected: (id) {
                      _activeCategoryId = id;
                      _fetchProducts(categoryId: id);
                    },
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),

          // ── Products count header ──────────────────────────────────
          BlocBuilder<GetProductsCubit, GetProductsState>(
            builder: (context, state) {
              if (state is GetProductsSuccess ||
                  state is GetProductsPaginationLoading ||
                  state is GetProductsPaginationFailure) {
                final count = switch (state) {
                  GetProductsSuccess s => s.products.length,
                  GetProductsPaginationLoading s => s.currentProducts.length,
                  GetProductsPaginationFailure s => s.currentProducts.length,
                  _ => 0,
                };
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                  child: Row(
                    children: [
                      Text(
                        '$count+ Items',
                        style: AppTextStyles.semiBold16,
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),

          // ── Products Grid ──────────────────────────────────────────
          Expanded(
            child: BlocConsumer<GetProductsCubit, GetProductsState>(
              listener: (context, state) {
                if (state is GetProductsFailure) {
                  showSnackBar(context, message: state.errorMessage);
                } else if (state is GetProductsPaginationFailure) {
                  showSnackBar(context, message: state.errorMessage);
                }
              },
              builder: (context, state) {
                if (state is GetProductsLoading) {
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return getShimmerProduct(context);
                    },
                  );
                }

                if (state is GetProductsFailure) {
                  return _buildError(context, state.errorMessage);
                }

                List<ProductModel> products = [];
                bool isPaginationLoading = false;

                if (state is GetProductsSuccess) {
                  products = state.products;
                } else if (state is GetProductsPaginationLoading) {
                  products = state.currentProducts;
                  isPaginationLoading = true;
                } else if (state is GetProductsPaginationFailure) {
                  products = state.currentProducts;
                }

                if (products.isEmpty) {
                  return _buildEmpty();
                }

                return RefreshIndicator(
                  color: AppColors.primary,
                  onRefresh: () async => _fetchProducts(),
                  child: GridView.builder(
                    controller: _scrollCtrl,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      childAspectRatio: 0.65,
                    ),
                    itemCount:
                        products.length + (isPaginationLoading ? 2 : 0),
                    itemBuilder: (context, index) {
                      if (index >= products.length) {
                        return _buildShimmerCard();
                      }
                      return ProductsGridItem(product: products[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: context.backgroundColor,
      elevation: 0,
      leading: widget.hideBackButton
          ? null
          : IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: context.textPrimary),
              onPressed: () => context.pop(),
            ),
      title: Text(
        widget.categoryName ?? 'Products',
        style: AppTextStyles.semiBold18,
      ),
      centerTitle: true,
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: context.backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(color: context.shadowColor, blurRadius: 8),
        ],
      ),
      child: TextField(
        controller: _searchCtrl,
        onChanged: (val) {
          _searchQuery = val;
          if (_debounce?.isActive ?? false) _debounce?.cancel();
          _debounce = Timer(const Duration(milliseconds: 500), () {
            if (val.isEmpty || val.length >= 2) {
              _fetchProducts(title: val.isEmpty ? null : val);
            }
          });
        },
        decoration: InputDecoration(
          hintText: S.of(context).search,
          hintStyle: AppTextStyles.medium12,
          prefixIcon:
              Icon(Icons.search, color: context.textHint, size: 20.r),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        ),
      ),
    );
  }

  Widget _buildFab(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => context.push(AppRoutes.kAddProductView),
      backgroundColor: AppColors.primary,
      icon: const Icon(Icons.add, color: Colors.white),
      label: Text(S.of(context).addProduct,
          style: AppTextStyles.semiBold14.copyWith(color: Colors.white)),
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
            style:
                ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            onPressed: () => _fetchProducts(),
            child: Text(S.of(context).tryAgain,
                style: AppTextStyles.semiBold14
                    .copyWith(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined,
              color: context.borderColor, size: 80.r),
          SizedBox(height: 16.h),
          Text(S.of(context).noProductsFound, style: AppTextStyles.semiBold18),
          SizedBox(height: 8.h),
          Text(S.of(context).tryDifferentSearch,
              style: AppTextStyles.regular14),
        ],
      ),
    );
  }

  Widget _buildShimmerCard() {
    return Container(
      decoration: BoxDecoration(
        color: context.surfaceVariant,
        borderRadius: BorderRadius.circular(12.r),
      ),
    );
  }
}
