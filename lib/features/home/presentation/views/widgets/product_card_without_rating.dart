import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/config/routing/app_routes.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/core/utils/pricing_utils.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';

class ProductCardWithoutRating extends StatelessWidget {
  const ProductCardWithoutRating({super.key, required this.product});
  static const double cardHeight = 185;
  final ProductModel product;

  double get priceBeforeDiscount =>
      PricingUtils.priceBeforeDiscount(product.price);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.kProductDetailsView, extra: product),
      child: SizedBox(
        height: cardHeight.h,
        width: cardHeight.w,
        child: Column(
          children: [
          // * ---- Product Image ----
          Expanded(
            child: Container(
              // width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                image: DecorationImage(
                  image: NetworkImage(product.images[0]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // gap between image and text layout
          SizedBox(height: 4.h),

          //* ----  Product Title Header Text ----
          Container(
            decoration: BoxDecoration(
              color: context.backgroundColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.medium12.copyWith(color: Colors.black),
                ),

                SizedBox(height: 4.h),

                //* ---- Product Body Description Text ----
                Text(
                  product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.regular10,
                ),

                SizedBox(height: 4.h),

                Text(
                  PricingUtils.formatPrice(
                      PricingUtils.discountedPrice(product.price)),
                  style: AppTextStyles.semiBold12.copyWith(
                    color: context.textPrimary,
                  ),
                ),

                //* Pricing Row Layout Structure (Original Line out & Discount Status)
                Row(
                  children: [
                    // Original Price Text with a strikethrough line
                    Text(
                      '₹${priceBeforeDiscount.toStringAsFixed(0)}',
                      style: AppTextStyles.semiBold12.copyWith(
                        color: context.borderColor,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: context.borderColor,
                        decorationThickness: 1.5,
                      ),
                    ),
                    SizedBox(width: 8.w),

                    Text(
                      '${PricingUtils.discountPercent}% Off',
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.regular10.copyWith(
                        color: AppColors.pinkBanner,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }
}
