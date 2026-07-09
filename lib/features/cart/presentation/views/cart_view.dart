import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:stylish/config/routing/app_routes.dart';
import 'package:stylish/core/payment/presentation/checkout_bottom_sheet.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/core/utils/pricing_utils.dart';
import 'package:stylish/features/cart/data/models/cart_item.dart';
import 'package:stylish/features/cart/presentation/manager/cart_cubit/cart_cubit.dart';
import 'package:stylish/generated/l10n.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.greyBackground,
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
        elevation: 0,
        title: Text(S.of(context).cartTitle, style: AppTextStyles.semiBold18),
        centerTitle: true,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading || state is CartInitial) {
            return const Center(
                child: CircularProgressIndicator(color: AppColors.primary));
          } else if (state is CartFailure) {
            return Center(child: Text(state.message));
          } else if (state is CartLoaded) {
            if (state.items.isEmpty) {
              return _buildEmptyCart(context);
            }
            return _buildCartList(context, state.items, state.totalPrice);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.r),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.shopping_cart_outlined,
                color: AppColors.primary, size: 56.r),
          ),
          SizedBox(height: 24.h),
          Text(S.of(context).cartEmptyTitle, style: AppTextStyles.semiBold18),
          SizedBox(height: 8.h),
          Text(
            S.of(context).cartEmptySubtitle,
            style: AppTextStyles.regular14,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCartList(
      BuildContext context, List<CartItem> items, double total) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.all(16.w),
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, __) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final item = items[index];
              return _buildCartItem(context, item);
            },
          ),
        ),
        _buildCheckoutBottomBar(context, total),
      ],
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem item) {
    return GestureDetector(
      onTap: () =>
          context.push(AppRoutes.kProductDetailsView, extra: item.product),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: context.backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
                color: context.shadowColor, blurRadius: 8, offset: const Offset(0, 2))
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedNetworkImage(
                imageUrl: item.product.images.isNotEmpty
                    ? item.product.images.first
                    : 'https://via.placeholder.com/150',
                width: 80.w,
                height: 80.h,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(color: AppColors.primary)),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.regular14),
                  SizedBox(height: 4.h),
                  Text(
                    PricingUtils.formatPrice(
                        PricingUtils.discountedPrice(item.product.price)),
                    style: AppTextStyles.semiBold16,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                _buildQtyBtn(context, Icons.remove, () {
                  context.read<CartCubit>().updateQuantity(
                      item.product.id.toInt(), item.quantity - 1);
                }),
                SizedBox(width: 12.w),
                Text('${item.quantity}', style: AppTextStyles.semiBold14),
                SizedBox(width: 12.w),
                _buildQtyBtn(context, Icons.add, () {
                  context.read<CartCubit>().updateQuantity(
                      item.product.id.toInt(), item.quantity + 1);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQtyBtn(BuildContext context, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4.r),
        decoration: BoxDecoration(
          color: context.greyBackground,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Icon(icon, size: 16.r, color: context.textPrimary),
      ),
    );
  }

  Widget _buildCheckoutBottomBar(BuildContext context, double total) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: context.backgroundColor,
        boxShadow: [
          BoxShadow(
              color: context.shadowColor,
              blurRadius: 16,
              offset: const Offset(0, -4))
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(S.of(context).total,
                      style: AppTextStyles.semiBold20
                          .copyWith(color: context.textPrimary)),
                  Text('₹${total.toStringAsFixed(0)}',
                      style: AppTextStyles.semiBold20
                          .copyWith(color: AppColors.primary)),
              ],
            ),
          ),
          Expanded(
            child: ElevatedButton(
                onPressed: () {
                  if (total > 0) {
                    showCheckoutBottomSheet(
                      context: context,
                      amount: total,
                      currency: 'EGP',
                      onSuccess: () {
                        context.read<CartCubit>().clearCart();
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r)),
                ),
                child: Text(S.of(context).checkout,
                    style: AppTextStyles.semiBold16
                        .copyWith(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
