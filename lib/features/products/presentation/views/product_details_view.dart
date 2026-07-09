import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/config/routing/app_routes.dart';
import 'package:stylish/config/services/shared_preferences_service.dart';
import 'package:stylish/core/functions/show_custom_dialog.dart';
import 'package:stylish/core/functions/show_snack_bar_function.dart';
import 'package:stylish/core/payment/presentation/checkout_bottom_sheet.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/core/utils/pricing_utils.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';
import 'package:stylish/features/products/presentation/manager/delete_product_cubit/delete_product_cubit.dart';
import 'package:stylish/features/products/presentation/manager/product_details_cubit/product_details_cubit.dart';
import 'package:stylish/features/cart/presentation/manager/cart_cubit/cart_cubit.dart';
import 'package:stylish/features/home/presentation/manager/nav_cubit/nav_cubit.dart';
import 'package:stylish/features/products/presentation/views/widgets/product_details_image_slider.dart';
import 'package:stylish/features/wishlist/presentation/manager/wishlist_cubit/wishlist_cubit.dart';
import 'package:stylish/generated/l10n.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.product});

  /// Passed via GoRouter `extra` for instant display while details load.
  final ProductModel product;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  bool _isDescExpanded = false;
  late ProductModel _product;

  @override
  void initState() {
    super.initState();
    _product = widget.product;
    // Fetch fresh data from API
    context
        .read<ProductDetailsCubit>()
        .getProductDetails(id: _product.id.toInt());
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = SharedPreferencesService.isLoggedIn();

    return BlocListener<DeleteProductCubit, DeleteProductState>(
      listener: (context, state) {
        if (state is DeleteProductSuccess) {
          showSnackBar(context, message: S.of(context).productDeletedSuccess);
          context.pop();
        } else if (state is DeleteProductFailure) {
          showSnackBar(context, message: state.errorMessage);
        }
      },
      child: Scaffold(
        backgroundColor: context.backgroundColor,
        appBar: _buildAppBar(context, isLoggedIn),
        body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsSuccess) {
              _product = state.product;
            }
            return _buildBody(context, isLoggedIn);
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, bool isLoggedIn) {
    return AppBar(
      backgroundColor: context.backgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_rounded,
            color: context.textPrimary),
        onPressed: () => context.pop(),
      ),
      actions: [
          // Favourite button
          BlocBuilder<WishlistCubit, WishlistState>(
            builder: (context, state) {
              final isInWishlist =
                  context.read<WishlistCubit>().isInWishlist(_product.id.toInt());
              return IconButton(
                icon: Icon(
                  isInWishlist ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: isInWishlist ? AppColors.error : context.textPrimary,
                ),
                onPressed: () =>
                    context.read<WishlistCubit>().toggle(_product),
              );
            },
          ),
          if (isLoggedIn) ...[
            // Edit button
            IconButton(
              icon: Icon(Icons.edit_outlined, color: context.textPrimary),
              onPressed: () =>
                  context.push(AppRoutes.kEditProductView, extra: _product),
            ),
          // Delete button
          BlocBuilder<DeleteProductCubit, DeleteProductState>(
            builder: (context, state) {
              if (state is DeleteProductLoading) {
                return const Padding(
                  padding: EdgeInsets.all(12),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                        color: AppColors.primary, strokeWidth: 2),
                  ),
                );
              }
              return IconButton(
                icon: const Icon(Icons.delete_outline, color: AppColors.error),
                onPressed: () => _confirmDelete(context),
              );
            },
          ),
        ],
      ],
    );
  }

  Widget _buildBody(BuildContext context, bool isLoggedIn) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),

            // ── Image Slider ───────────────────────────────────────────
            ProductDetailsImageSlider(images: _product.images),
            SizedBox(height: 16.h),

            // ── Category badge ─────────────────────────────────────────
            if (_product.category?.name != null)
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  _product.category!.name!,
                  style: AppTextStyles.semiBold12
                      .copyWith(color: AppColors.primary),
                ),
              ),
            SizedBox(height: 10.h),

            // ── Title ──────────────────────────────────────────────────
            Text(_product.title, style: AppTextStyles.semiBold18),
            SizedBox(height: 6.h),

            // ── Rating row ─────────────────────────────────────────────
            Row(
              children: [
                ...List.generate(5, (i) {
                  if (i < 4) {
                    return Icon(Icons.star,
                        color: const Color(0xFFEDB310), size: 16.r);
                  } else if (i < 4.5) {
                    return Icon(Icons.star_half,
                        color: const Color(0xFFEDB310), size: 16.r);
                  }
                  return Icon(Icons.star,
                      color: Colors.grey.shade300, size: 16.r);
                }),
                SizedBox(width: 6.w),
                Text('56,890',
                    style:
                        AppTextStyles.regular10.copyWith(color: context.borderColor)),
              ],
            ),
            SizedBox(height: 10.h),

            // ── Price row ──────────────────────────────────────────────
            Row(
              children: [
                Text(
                  PricingUtils.formatPrice(
                      PricingUtils.discountedPrice(_product.price)),
                  style: AppTextStyles.semiBold18
                      .copyWith(color: context.textPrimary),
                ),
                SizedBox(width: 8.w),
                Text(
                  PricingUtils.formatPrice(_product.price),
                  style: AppTextStyles.semiBold14.copyWith(
                    color: context.borderColor,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: context.borderColor,
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    '${PricingUtils.discountPercent}% Off',
                    style: AppTextStyles.regular10
                        .copyWith(color: AppColors.primary),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // ── Product Details section ────────────────────────────────
            Text(S.of(context).productDetails, style: AppTextStyles.semiBold16),
            SizedBox(height: 8.h),
            _buildDescription(),
            SizedBox(height: 24.h),

            // ── Action buttons (placeholders matching mockup) ──────────
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      context.read<CartCubit>().addItem(_product);
                      context.read<NavCubit>().selectTab(2);
                      context.pop();
                    },
                    icon: Icon(Icons.shopping_cart_outlined,
                        color: AppColors.primary, size: 18.r),
                    label: Text(S.of(context).goToCart,
                        style: AppTextStyles.semiBold14
                            .copyWith(color: AppColors.primary)),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      side: BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showCheckoutBottomSheet(
                        context: context,
                        amount: PricingUtils.discountedPrice(_product.price),
                        currency: 'EGP',
                        onSuccess: () {},
                      );
                    },
                    icon: Icon(Icons.flash_on_rounded,
                        color: Colors.white, size: 18.r),
                    label: Text(S.of(context).buyNow,
                        style: AppTextStyles.semiBold14
                            .copyWith(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // ── Delivery info banner ───────────────────────────────────
            Container(
              width: double.infinity,
              padding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.06),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                    color: AppColors.primary.withOpacity(0.2), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Delivery in',
                      style: AppTextStyles.medium12
                          .copyWith(color: context.textSecondary)),
                  Text('1 within Hour',
                      style: AppTextStyles.semiBold16
                          .copyWith(color: context.textPrimary)),
                ],
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription() {
    const int maxLines = 3;
    final text = _product.description;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          maxLines: _isDescExpanded ? null : maxLines,
          overflow: _isDescExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: AppTextStyles.regular14,
        ),
        GestureDetector(
          onTap: () => setState(() => _isDescExpanded = !_isDescExpanded),
          child: Text(
            _isDescExpanded ? 'Less' : '...More',
            style: AppTextStyles.semiBold14
                .copyWith(color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  void _confirmDelete(BuildContext context) {
    showCustomDialog(
      context: context,
      title: S.of(context).deleteProduct,
      message:
          S.of(context).deleteProductConfirmMessage,
      buttonTitle: S.of(context).deleteProductConfirmButton,
      icon: Icons.delete_forever_rounded,
      onPressed: () => context
          .read<DeleteProductCubit>()
          .deleteProduct(id: _product.id.toInt()),
    );
  }
}
